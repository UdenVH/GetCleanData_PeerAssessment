#  Project title: "Getting and Cleaning Data"
#
#  UvH, 16/3/2015
#

setwd("~/Documents/Coursera - Getting and Cleaning Data - 2015march/project")

## Loading and preprocessing the data

# assumption: the data has been downloaded from Coursera and is stored on the 
# local hard drive. The zip-file 'getdata_projectfiles_UCI HAR Dataset.zip' 
# was unzipped into the /data/raw-directory of this project.

# The activity monitoring data is stored in csv-format, including header columns. 
# The raw data is stored in the '/data/raw/UCI HAR Dataset/test' and 'train'-
# directories of this project. 
# Note that I am working on a pc with the Linux operating system, therefore the 
# directory path may seem unfamiliar.

# from the documentation (README.txt): the column names can be found in file features.txt
columnNames <- read.csv("./data/raw/UCI HAR Dataset/features.txt", header=FALSE, sep=" ")
# only keep the descriptive values
columnNames <- columnNames[,2]

# clean column-names
# Because the column-names need domain knowledge to make them more readible, 
# only basic transformations were applied by setting the column-names to lower
# case and removing some of the special characters:
columnNames <- tolower(columnNames)
columnNames <- gsub("-","_",columnNames)
columnNames <- gsub(",","",columnNames)
columnNames <- gsub("\\(","",columnNames)
columnNames <- gsub("\\)","",columnNames)

# now read in the measurement data:
x_test <- read.table('./data/raw/UCI HAR Dataset/test/X_test.txt', as.is = TRUE)
x_train <- read.table('./data/raw/UCI HAR Dataset/train/X_train.txt', as.is = TRUE)
samsungData <- rbind(x_test,x_train)
names(samsungData) <- columnNames

# remove unnecessary data to prevent memory issues:
remove(x_test, x_train)

# 2) subset on columns in order to keep only 
# - columns in the time-domain
# - columns containing the mean/stnd in the name
samsungData <- samsungData[,grepl("^t", columnNames)]
columnNames <- names(samsungData)
samsungData <- samsungData[,grepl("mean|std", columnNames)]
```

# 3) Uses descriptive activity names to name the activities in the data set

# merge measurements with subjects and activity-descriptions:
subjects_test  <- read.csv("./data/raw/UCI HAR Dataset/test/subject_test.txt", header=FALSE)
subjects_train <- read.csv("./data/raw/UCI HAR Dataset/train/subject_train.txt", header=FALSE)
subjects <- rbind(subjects_test, subjects_train)

activities_test  <- read.csv("./data/raw/UCI HAR Dataset/test/y_test.txt", header=FALSE)
activities_train <- read.csv("./data/raw/UCI HAR Dataset/train/y_train.txt", header=FALSE)
activities <- rbind(activities_test, activities_train)

# load activity descriptions:
activityLabels <- read.csv("./data/raw/UCI HAR Dataset/activity_labels.txt", header=FALSE, sep=" ")
activityLabels[,2] <- tolower(activityLabels[,2])

# merge activity ids and activity descriptions:
activities <- merge.data.frame(activities, activityLabels, by = "V1")

# merge subjects, activities & measurements:
samsungData <- cbind(subjects, activities[,2], samsungData)


# remove unnecessary data to prevent memory issues:
remove(subjects_test, subjects_train, activities_test, activities_train, activityLabels)

# 4. Appropriately labels the data set with descriptive variable names.

# already done, so only update the two new columns containing the subject and activity
colnames(samsungData)[1] <- "subjectid"
colnames(samsungData)[2] <- "activity"

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# perform aggregation per subjectid & activity combination:
columnCount <- dim(samsungData)[[2]]
tidySamsungData <- aggregate(samsungData[,3:columnCount], by=samsungData[c("subjectid","activity")], FUN=mean)

# order by subjectid & activity:
orderedTidySamsungData <- tidySamsungData[order(tidySamsungData$subjectid, tidySamsungData$activity), ]

# verify results:
dim(orderedTidySamsungData)

noOfSubjects <- length(unique(samsungData$subjectid))
noOfActivities <- length(unique(samsungData$activity))
noOfSummaryRows <- noOfSubjects * noOfActivities

# only 35 rows with the 22 variables. Can this be correct? I expected noOfSummaryRows=180 rows.
t <- samsungData[samsungData$subjectid==1,2]
unique(t)
# [1] walking_upstairs   walking_downstairs
# so only two activities for subject 1, which corresponds to results in cdata

# now save the data:
if (!file.exists("data/tidy")) {
   dir.create("data/tidy")
}
write.table(orderedTidySamsungData, file="./data/tidy/samsung.txt", row.name=FALSE)

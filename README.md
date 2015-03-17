---
author: "UvH"
date: "03/17/2015"
title: 'Coursera "Getting and Cleaning Data"'
output:
  html_document:
    keep_md: yes
    theme: cerulean
---

# Project readme "creating tidied Samsung Galaxy S smartphone data-set"

## Preconditions

In order for the script "run_analysis.R" to process the data, the following conditions must be met:  

 1. the data has been downloaded from the [Coursera class website](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip),  
 2. a project-directory has been created on the local hard drive,  
 3. a data-subdirectory has been created with a subdirectory:  
    + raw  
 4. the zip-file has been unzipped into the /data/raw-directory  
(resulting in a directory /data/raw/UCI HAR Dataset/)  
 5. R has been installed (i have been using R version 3.1.2 (2014-10-31) -- "Pumpkin Helmet")  

## Processing

The data is processed by only one script called "run_analysis.R". No special libraries are required.

The script processes all data in the following order.

### Column names

The raw data is described in the document /data/raw/UCI HAR Dataset/README.txt. This file shows that the column names can be found in file features.txt

Because making the column-names more readible needs domain knowledge, only basic transformations are applied by 

  * setting the column-names to lower-case, and 
  * removing or replacing the special characters in the names:
      + replace "-" with "_",
      + remove characters like ",", "(" and ")".

### Measurement data

The two files with training and test-data are loaded and merged together into a data frame. The column names are applied to the data frame.

Next, the data is subsetted in order to keep only   

  * columns in the time-domain,   
  * columns containing the mean and standard deviation for each measurement.  

The subsetting is performed by applying regular expressions on the column names.

Next, the measurement data is column-merged with the subject ids and with the activities. The activity ids are replaced with the activity descriptions.  
The column names of these two new columns containing the subject and activity are updated to get the more descriptive values "subjectid" and "activity".  

Finally, the aggregate-function is used to calculate the mean value of each measurement for each combination of subject and activity. This aggregated data is sorted, first by subjectid and second by (the factored value of) the activity.

The resulting tidied data is saved to the /data/tidy-directory.

## Results

After completion of the script, the tidied data can be found in the directory
/data/tidy/ in the file "samsung.txt".

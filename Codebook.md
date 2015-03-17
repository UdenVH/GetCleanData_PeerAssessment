# Coursera "Getting and Cleaning Data"
UvH  
03/17/2015  

# Project codebook "tidied Samsung Galaxy S smartphone data-set"

## Variables

This paragraph describes type of variables in the tidied data set.



The names of the columns are:

```
##  [1] "subjectid"             "activity"             
##  [3] "tbodyacc_mean_x"       "tbodyacc_mean_y"      
##  [5] "tbodyacc_mean_z"       "tgravityacc_mean_x"   
##  [7] "tgravityacc_mean_y"    "tgravityacc_mean_z"   
##  [9] "tbodyaccjerk_mean_x"   "tbodyaccjerk_mean_y"  
## [11] "tbodyaccjerk_mean_z"   "tbodygyro_mean_x"     
## [13] "tbodygyro_mean_y"      "tbodygyro_mean_z"     
## [15] "tbodygyrojerk_mean_x"  "tbodygyrojerk_mean_y" 
## [17] "tbodygyrojerk_mean_z"  "tbodyaccmag_mean"     
## [19] "tgravityaccmag_mean"   "tbodyaccjerkmag_mean" 
## [21] "tbodygyromag_mean"     "tbodygyrojerkmag_mean"
```
  
  
The first column contains an anonymised id of the subject. The second column contains the textual description of the activity. The other columns contain either the mean or the standard deviation of one of the measurements in the time-domain.  

More information on these measurement variables can be found in the file "/data/raw/UCI HAR Dataset/README.txt" and at the website [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#) that describes the data.


## Data

This paragraph describes the variables and their values.

The tidied data set has the dimensions of ``22`` columns and ``35`` rows. 

The subject column contains the ids of ``30`` subjects. The sorted ids are given by

```
##  [1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23
## [24] 24 25 26 27 28 29 30
```
It can be seen that no subjects are missing from the data set.

The activity column contains ``6`` unique activities The unique activity descriptions are given by

```
## [1] "walking_downstairs" "walking_upstairs"   "walking"           
## [4] "sitting"            "standing"           "laying"
```

Because the tidied data set has only ``35`` rows, it can be concluded that the different subjects did not perform all activities (because otherwise ``30`` subjects times ``6`` activities would have resulted in ``180`` rows).

The following table shows the minimum, mean and maximum values of the different measurement variables in the tidied data set.


variable                minimum       mean          maximum     
----------------------  ------------  ------------  ------------
tbodyacc_mean_x         0.2651        0.2745        0.2816      
tbodyacc_mean_y         -0.02329      -0.01779      -0.01440    
tbodyacc_mean_z         -0.11828      -0.10857      -0.09497    
tgravityacc_mean_x      0.4753        0.6818        0.9522      
tgravityacc_mean_y      -0.330027     -0.007277      0.174813   
tgravityacc_mean_z      -0.16118       0.08407       0.27695    
tbodyaccjerk_mean_x     0.06288       0.07915       0.10428     
tbodyaccjerk_mean_y     -0.001545      0.007789      0.024308   
tbodyaccjerk_mean_z     -0.025952     -0.005265      0.017874   
tbodygyro_mean_x        -0.07013      -0.02791       0.04461    
tbodygyro_mean_y        -0.12419      -0.07715      -0.04715    
tbodygyro_mean_z        0.05399       0.08709       0.11225     
tbodygyrojerk_mean_x    -0.12113      -0.09822      -0.07311    
tbodygyrojerk_mean_y    -0.07042      -0.04277      -0.03459    
tbodygyrojerk_mean_z    -0.06220      -0.05382      -0.01692    
tbodyaccmag_mean        -0.68648      -0.51796      -0.01408    
tgravityaccmag_mean     -0.68648      -0.51796      -0.01408    
tbodyaccjerkmag_mean    -0.8302       -0.6273       -0.2197     
tbodygyromag_mean       -0.76468      -0.57519      -0.09166    
tbodygyrojerkmag_mean   -0.8823       -0.7457       -0.4057     


## Transformations

This paragraph describes the transformations tha have been applied to the variables.

The only transformation that has been applied to the raw data set is that the mean (average) value has been calculated of each measurement for each combination of subject and activity. This aggregated data has been sorted, first by subjectid and second by (the factored value of) the activity.

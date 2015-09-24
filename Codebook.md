# Output Data: tidy_data_set.txt
### Summary
* Headers: Subject, Activity, Mean (as average), Standard Deviation (as average)
* Classes: Integer, Factor, Numeric, Numeric
* Rows: 180
* N/As: none
* Separator: space

### Columns
* Subject - test subject identificator. Integers from 1 to 30.
* Activity - activity descriptor. 6 factors as following: LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS.
* Mean(as average) - averaged measured values (from predefined dataset) for every combination of subject and activity.
* Standard Deviation(as average) - **averaged** measured values (from predefined dataset) for every combination of subject and activity. Note that the standard deviation is not calculated over the whole dataset but averaged value of subset standard deviations!

# Original dataset 
Source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# Steps from the original dataset to the output dataset

## Merging the data sets:

###Reading in multiple data frames:
* Reading in the measurement sets as numeric from fixed width (16) files. (Using libraries *LaF* and *ffbase* to speed up reading from fixed width format)
* Reading in the labels as integer.
* Reading in the subjects as factors (to avoid converting later).

### Merging the data:
* Adding the training measurement rows to the test measurement rows.
* Adding the training subject rows to the test subject rows.
* Adding the training labels rows to the test labels rows.
* Adding the label and the set columns to the label column.

## Extracting means and standard deviations:
* Using the measurements data frame and going through it twice line by line creating lists as mean and standard deviation values respectively. The means are calculated using R base package version 3.2.1 function **mean()** and standard deviations using R stats package version 3.2.1 function **sd()**.
* Merging the subjects, labels, means, and standard deviations by columns

## Mapping the labels to activities and labeling data:
* Reading in the mapping between labels and activities
* Merging it with the data frame by mapping the activity code
* Labeling the data frame. (Note that the merging resulted in changing the order between the first 2 columns)

## Creating tidy_data_set.txt
* Grouped the data frame by measurement identificators. (Using dplyr library.)
* Summarized the data frame matching identificators to average means and standard deviations from the measurements.
* Assigned new names to the data set.
* Wrote the data set into file.


# Background information: the task
You should create one R script called run_analysis.R that does the following. 

1. Merges the training and the test sets to create one data set.
1. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


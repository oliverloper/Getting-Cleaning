#Course project for the Coursera Getting and Cleaning Data
## The task
You should create one R script called run_analysis.R that does the following. 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Solution
R script: run_analysis.R (https://github.com/oliverloper/Getting-Cleaning/blob/master/run_analysis.R)
Source data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Output data: https://github.com/oliverloper/Getting-Cleaning/blob/master/tidy_data_set.txt
Codebook: https://github.com/oliverloper/Getting-Cleaning/blob/master/Codebook.md

Parameters from the original data:
* From original codebook: 561 measurements per entry
* From original codebook: 30 subjects (separated into 2 not overlapping groups)
* From original codebook: 6 different activities
* From original codebook: No missing values
* From original codebook: 10299 entries (separated into 2 not overlapping groups)
* Observation: measurements data in fixed width file type 

Main data processing functions:
* Calculating means and averages: mean()
* Calculating standard deviation: sd()
* Merging data: cbind(), rbind(), merge()
* Grouping: group_by(), summarize(), mean()
* Reading: read.table(), laf_open_faf(), laf_to_ffdf()

Notes:
* R version: 3.2.1 
* OS: Windows 10
* Used packages: LaF, ffbase, dplyr
* *To run the script source data needs to be unzipped to the working directory.*

*The linked codebook (and comments integrated into the linked R script) provide additional information about the analysis.*

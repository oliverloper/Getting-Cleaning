#Using LaF and ffbase libraries to speed up reading from a fixed width file.
library(LaF)
library(ffbase)

#Assigning file locations (as relative from working directory) and reading in the data about training
#Subjects are read in as factors to avoid the converting later for group_by
training_labels_file_location="UCI HAR Dataset/train/y_train.txt"
training_set_file_location="UCI HAR Dataset/train/x_train.txt"
training_subject_file_location="UCI HAR Dataset/train/subject_train.txt"

training.set.laf<-laf_open_fwf(training_set_file_location, column_width= c(rep(16, 561)), column_types=c(rep("numeric",561)))
temp<-laf_to_ffdf(training.set.laf, nrows=7400)
training.set <- as.data.frame(temp)

training.labels <- read.table(training_labels_file_location, sep = "\t", colClasses=("integer"), col.names = ("labels"))
training.subjects <- read.table(training_subject_file_location, sep = "\t", colClasses=("factor"), col.names=("subjects"))

#Assigning file locations (as relative from working directory) and reading in the data about test
#Subjects are read in as factors to avoid the converting later for group_by
test_labels_file_location="UCI HAR Dataset/test/y_test.txt"
test_set_file_location="UCI HAR Dataset/test/X_test.txt"
test_subject_file_location="UCI HAR Dataset/test/subject_test.txt"

test.set.laf<-laf_open_fwf(test_set_file_location, column_width= c(rep(16, 561)), column_types=c(rep("numeric",561)))
temp<-laf_to_ffdf(test.set.laf, nrows=3000)
test.set <- as.data.frame(temp)

test.labels <- read.table(test_labels_file_location, sep = "\t", colClasses=("integer"),col.names = ("labels"))
test.subjects <- read.table(test_subject_file_location, sep = "\t", colClasses=("factor"), col.names=("subjects"))

#Merging test and training data by rows
data.labels<-rbind(test.labels, training.labels)
data.subjects<-rbind(test.subjects, training.subjects)


#Merging 2 data frames
#Expected to correspond to task 1: Merges the training and the test sets to create one data set.
data.sets<-rbind(test.set, training.set)

#Extracting 2 lists to get means and standard deviations
#Expected to correspond to task 2: Extracts only the measurements on the mean and standard deviation for each measurement.
means<-apply(data.sets,1, mean)
stddevs<-apply(data.sets,1,sd)
calculated<-cbind(data.subjects, data.labels, means, stddevs)

#Reading in activity codes and mapping to the created frame.
#Expecting to correspond to task 3:Uses descriptive activity names to name the activities in the data set
activity_codes_file_location="UCI HAR Dataset/activity_labels.txt"
activity_codes<-read.table(activity_codes_file_location, sep=" ",colClasses = c("integer","factor"),col.names = c("id","description"))
calculated<-merge(calculated, activity_codes, by.x=2, by.y=1, sort=FALSE)

#Adding column names.
#Expecting it to correspond to task 4: Appropriately labels the data set with descriptive variable names. 
names(calculated)<-c("Activity.Code", "Subject", "Mean","StdDev","Activity.Name")

#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for 
#each activity and each subject.
library(dplyr)
averaged<-group_by(calculated, Subject, Activity.Name)
averaged<-summarize(averaged, mean(Mean), mean(StdDev))
names(averaged)<-c("Subject", "Activity", "Mean (as average)", "Standard Deviation (as average)")

#Please upload the tidy data set created in step 5 of the instructions. Please upload your data set as a txt file created with 
#write.table() using row.name=FALSE

write.table(averaged, "tidy_data_set.txt", row.names = FALSE)

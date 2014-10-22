#!/usr/bin/env R -f
#
# Coursera Getting and Cleaning Data Course Project
#

library(dplyr)
library(tidyr)

# Get the source dataset

if(!file.exists("UCI HAR Dataset")) {
  if(!file.exists("data.zip")) {
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, destfile="data.zip", method="curl")
  }

  unzip("data.zip")
}

# Merge the test and train datasets

# Load global data
features <- read.table("UCI HAR Dataset/features.txt")

activities <- read.table("UCI HAR Dataset/activity_labels.txt")
names(activities) <- c("id", "activity")

# Load test data
test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names=features[,2])
test_subjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test_activities <- read.table("UCI HAR Dataset/test/y_test.txt")
test <- cbind(test, subjectid=test_subjects[,1], activityid=test_activities[,1])

# Load train data
train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names=features[,2])
train_subjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train_activities <- read.table("UCI HAR Dataset/train/y_train.txt")
train <- cbind(train, subjectid=train_subjects[,1], activityid=train_activities[,1])

# Merge 
data <- rbind(test, train)

# Fix columns names
cols <- tolower(names(data))
cols <- gsub("\\.", "", cols)
names(data) <- cols

# Get only the mean and stddev of measurements
data <- select(data, contains("mean"), contains("std"), subjectid, activityid)

# Merge the activity labels and remove the id
data <- merge(data, activities, by.x="activityid", by.y="id")
data <- select(data, -activityid)

# Create new tidy dataset
res <- gather(data, "measurement", "value", -subjectid, -activity)
res <- summarize(group_by(res, subjectid, activity, measurement), average=mean(value))
write.table(res, "tidy.txt", row.names=FALSE)

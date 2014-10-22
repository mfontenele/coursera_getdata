# Course Project for Getting and Cleaning Data


This repository holds the Course Project for the [Getting and Cleaning Data](https://www.coursera.org/course/getdata) course at Coursera.

This document describes how the `run_analysis.R` script works. Its objective is to tidy up the [source dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). Detailed information on the source dataset can be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

## Files


There are 3 files in this repository:

* `README.md` - describing how the analysis work;
* `CodeBook.md` - describing the data the analysis produces;
* `run_analysis.R` - the analysis script.

The script assumes that a `UCI HAR Dataset` directory exists in the current directory and contains the unzipped contents of the source dataset.

After the script is run, a `tidy.txt` file is created in the current directory. The contents of this file are described in the [code book](CodeBook.md).


## How the analysis is done

The first step in the analysis is downloading and unzipping the source dataset if it does not exist in the current directory.

With the data on disk, the script continues by loading the `features.txt` and `activity_labels.txt` files adding column names to the last one. 

It then loads in sequence the `X_test.txt`, `subject_test.txt` and `y_test.txt` files. It uses the contents of the features dataset as the column names for the X_test dataset. It then adds the contents of the subject_test and y_test datasets as columns to the test dataset.

At this point we have the test dataset with column names from the features dataset, the original measurement data columns and the subject ids and activity ids columns.

The script does the same thing for the similar group of train files.

After the two datasets, test and train, are ready, the script adds the rows in the train at the end of the test dataset creating a new merged dataset.

Now it fixes column names by transforming them into lower case and removing all dots.

It proceeds by selecting only the columns that have `mean` and `std` in their names plus the subject and activity id columns.

Later it uses the activity id column to match the activity labels to the corresponding rows. Afterwards it removes the activity id from the dataset.

The last step is to gather the measurements columns into two columns, one for the type of measurement and the other for the measurement value. With the data tidily formatted, it computes the mean of each measure by subject id and activity.

The data is finally written to disk.


## How to read the data

In order to view the tidy data produced by the analysis, the following R expression can be used:

```R
data <- read.table(file_path, header = TRUE)
View(data)
```
# tidy.txt Code Book

This document describes the data produced by the `run_analysis.R` script. The name of the dataset file is `tidy.txt`. 

The source dataset for the script is described [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

The conversion process is described in the [README file](README.md).

## Contents

### subjectid Column

An integer identifier of the subject who carried out the experiment.

### activity Column

A character string activity label describing what the subject was doing during each measurement.

One of: 

* WALKING, 
* WALKING_UPSTAIRS, 
* WALKING_DOWNSTAIRS, 
* SITTING, 
* STANDING and 
* LAYING.

### measurement Column

Measurement type as a character string. 

The type corresponds to the mean and standard deviation measurement columns in the source dataset. The names are slightly different because they were all converted to lower case and all special characters (-, ( and )) were removed.

Detailed information on these types can be found in the [original dataset code book](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) and in the `features_info.txt` file inside the data package.

### average Column

This floating point column holds the average of the measurements for a given subject, activity and measurement.

The unit of the measurement is the same as for the correspondent column in the source dataset and can be found in the code book linked above.

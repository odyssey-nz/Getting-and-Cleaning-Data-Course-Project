# Getting and Cleaning Data Course Project


## Overview

### Description of Human Activity Recognition Using Smartphones Dataset

The purpose of this project is to import and prepare the data contained in the Human Activity Recognition Using Smartphones Dataset for analysis in R.

This dataset contains data collected from the sensor signals (accelerometer and gyroscope) from the Samsung Galaxy S II smartphone.

The experiments have been carried out with a group of 30 volunteers.  Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.  For further information please see: './raw data/README.txt'

### Features of HAR Dataset

The features selected for this database were generated from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.  For a description of how the signals were processed please see: 'features_info.txt'

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

For the purpose of this project, we are only interested in the mean value [mean()] and standard deivation [std()] variables that were estimated from the above signals.


## Data Processing Steps

The below data processing steps are a written explanation for the code contained in the 'run_analysis.R' script, described in order of execution.  For further details please see the comments contained in the script.

### 1. Obtaining Raw Dataset

The raw dataset was downloaded from the following URL:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The ZIP file was then extracted to the working directory.

The following files were used in this analysis:

Descriptive Variable Names
        
        - 'activity_labels.txt' : Provides the descriptive activity names for the activity codes contained in the 'test/y_test.txt' and 'train/y_train.txt' files.
        
        - 'features.txt' : Provides the descriptive feature names from the columns contained in the 'test/X_test.txt' and 'train/X_train.txt' files.
        
Training Dataset
        
        - 'train/X_train.txt': Dataset containing the feature variables for the 21 volunteers in the 'Training' group.

        - 'train/y_train.txt': Dataset containing the activity codes that correspond to the 'train/X_train.txt' file.
        
        - 'train/subject_train.txt': Each row identifies the subject who performed the activity corresponding to the 'train/X_train.txt' file.
        
Test Dataset

        - 'test/X_test.txt': Dataset containing the feature variables for the 9 volunteers in the 'Test' group.

        - 'test/y_test.txt': Dataset containing the activity codes that correspond to the 'train/X_test.txt' file.
        
        - 'test/subject_test.txt': Each row identifies the subject who performed the activity corresponding to the 'test/X_test.txt' file.

### 2. Importing the Raw Data Files

The 'run_analysis.R' script contains the R code used to import and process the raw data files.

First, the 'activity_labels.txt' and 'features.txt' files are read into R using read.table().  The features data is modified to include an identifying variable that will later be used to merge the feature descriptions to the training and test datasets.

Then the training data ('train/X_train.txt', 'train/y_train.txt', 'train/subject_train.txt') are imported into R using read.table().

Finally, the test data ('test/X_test.txt', 'test/y_test.txt', 'test/subject_test.txt') are imported into R using read.table().

### 3. Creating Training and Test Datasets with Descriptive Activity and Variable Names

Training Data

The activity_labels are used to update the y_train data with the descriptive activity names corresponding to the activity codes and the variable identifying the number of the volunteer (1-30) is renamed as the subject variable.  Finally, all the training data is column-bound into one data frame using the cbind() function; this allows us to preserve the order of the data as received in the original text files and ensure that the rows correctly match.

The data frame now containing all of the training data is reshaped from wide to long using the melt() function in R and the descriptive variable names from the features data are merged onto this data frame using a variable that matches the descriptive name to the original column position (V[x]).  An additional variable is added that identifies the observations in this data frame as belonging to the training group.

Test Data

The above steps are then performed on the test data as described above.

### 4. Merge the Training and Test data sets to create one Final Dataset

The training and test data sets created above are then combined using the rbind() function in R to "stack" the data sets on top of each other.

### 5. Filter Final Dataset to Contain Only Mean and Standard Deviation Variables

The merged data set created above is then filtered using the grep() function in R to only include the rows where the feature description includes an exact match for "mean()" or "std()".

### 6. Create a second, independent tidy data set with the average of each variable for each activity and each subject

Finally, the above data set is grouped by subject, activity, group, and variable and then summarised by using the mean() function in R.

The summarised data is output to: './output/summary.csv'

These data can be read back into R using the following code:

        reread <- read.table("./output/summary.txt", header = TRUE)

A code book for the output data is included as 'CodeBook.md'


### References

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

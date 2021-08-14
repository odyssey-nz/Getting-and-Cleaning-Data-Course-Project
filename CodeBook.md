# DATA DICTIONARY
## for './output/summary.csv'


### subject

This variable identifies the subject who performed the activity (numbered 1-30).

The variable is created by column binding the data (using the cbind() function in R) from the 'test/subject_test.txt' with the data from the 'test/X_test.txt' file for the test set, preserving the order of the original data to ensure that the correct rows are matched.  For the training set, the same process is used to create the variable from the 'train/subject_train.txt' file, column binding it with the data from the 'train/X_train.txt' file.


### activity

This variable identifies the activity that was being performed:

        1 WALKING
        2 WALKING_UPSTAIRS
        3 WALKING_DOWNSTAIRS
        4 SITTING
        5 STANDING
        6 LAYING
        
The variable is created by column binding the data (using the cbind() function in R) from the 'test/y_test.txt' with the data from the 'test/X_test.txt' file for the test set, preserving the order of the original data to ensure that the correct rows are matched.  For the training set, the same process is used to create the variable from the 'train/y_train.txt' file, column binding it with the data from the 'train/X_train.txt' file.

Activity descriptions are added from the 'activity_labels.txt' file which contain the descriptions corresponding to the activity codes in the 'test/y_test.txt' and 'train/y_train.txt' files.


### group

This variable identifies the group that the subject belongs to:

        1 TRAIN
        2 TEST
        
This variable is created prior to row binding (using the rbind() function in R) the training and test datasets to create one final dataset, identifying whether the row of data came from the training or the test dataset.


### variable

This variable describes the feature variable estimated from the accelerometer and gyroscope 3-axial raw signals:

        fBodyAcc-mean()-X
        fBodyAcc-mean()-Y
        fBodyAcc-mean()-Z
        fBodyAcc-std()-X
        fBodyAcc-std()-Y
        fBodyAcc-std()-Z
        fBodyAccJerk-mean()-X
        fBodyAccJerk-mean()-Y
        fBodyAccJerk-mean()-Z
        fBodyAccJerk-std()-X
        fBodyAccJerk-std()-Y
        fBodyAccJerk-std()-Z
        fBodyAccMag-mean()
        fBodyAccMag-std()
        fBodyBodyAccJerkMag-mean()
        fBodyBodyAccJerkMag-std()
        fBodyBodyGyroJerkMag-mean()
        fBodyBodyGyroJerkMag-std()
        fBodyBodyGyroMag-mean()
        fBodyBodyGyroMag-std()
        fBodyGyro-mean()-X
        fBodyGyro-mean()-Y
        fBodyGyro-mean()-Z
        fBodyGyro-std()-X
        fBodyGyro-std()-Y
        fBodyGyro-std()-Z
        tBodyAcc-mean()-X
        tBodyAcc-mean()-Y
        tBodyAcc-mean()-Z
        tBodyAcc-std()-X
        tBodyAcc-std()-Y
        tBodyAcc-std()-Z
        tBodyAccJerk-mean()-X
        tBodyAccJerk-mean()-Y
        tBodyAccJerk-mean()-Z
        tBodyAccJerk-std()-X
        tBodyAccJerk-std()-Y
        tBodyAccJerk-std()-Z
        tBodyAccJerkMag-mean()
        tBodyAccJerkMag-std()
        tBodyAccMag-mean()
        tBodyAccMag-std()
        tBodyGyro-mean()-X
        tBodyGyro-mean()-Y
        tBodyGyro-mean()-Z
        tBodyGyro-std()-X
        tBodyGyro-std()-Y
        tBodyGyro-std()-Z
        tBodyGyroJerk-mean()-X
        tBodyGyroJerk-mean()-Y
        tBodyGyroJerk-mean()-Z
        tBodyGyroJerk-std()-X
        tBodyGyroJerk-std()-Y
        tBodyGyroJerk-std()-Z
        tBodyGyroJerkMag-mean()
        tBodyGyroJerkMag-std()
        tBodyGyroMag-mean()
        tBodyGyroMag-std()
        tGravityAcc-mean()-X
        tGravityAcc-mean()-Y
        tGravityAcc-mean()-Z
        tGravityAcc-std()-X
        tGravityAcc-std()-Y
        tGravityAcc-std()-Z
        tGravityAccMag-mean()
        tGravityAccMag-std()
        
Only the variables estimating the mean or standard deviation have been selected for this dataset.  The descriptive variable names from the 'features.txt' file were merged onto the combined training and test dataset using a variable that was created to match the row number from the 'features.txt' file to the original column position (V[x]) from the 'train/X_train.txt' and 'test/X_test.txt' files.


## mean

This is the mean value as estimated by the mean() function in R, grouped by  'subject', 'activity', 'group', and 'variable'.

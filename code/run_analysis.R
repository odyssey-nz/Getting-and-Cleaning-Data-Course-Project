## Title: "Import, Merge, and Tidy Data for Analysis"
## Date: 11/08/2021
## Author: Josh Neale

library(dplyr)

## 0. Import 'features' (Column Labels) and 'activity_labels'

features <- read.table("./data/UCI HAR Dataset/features.txt")

# Prepare features data frame to merge with 'Training' and 'Test' Data
# Create "V[x]" variable to merge on and rename columns
features <-     features %>%
                mutate(variable = paste("V", V1, sep = "")) %>%
                rename(variableName = V2) %>%
                select(variable, variableName)

activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")


## 1A. Import 'Training' Data

# Read in subject data
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
# Each row identifies the subject who performed the activity for each window sample.
# Its range is from 1 to 30.

# Read in X_train data ("Training set")
X_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")

# Read in y_train data ("Training labels")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")


## 1B. Combine and Clean "Training" Data

# Update "Training labels" as factor with descriptive activity names
y_train <-      y_train %>%
                mutate(activity = factor(V1, levels = activity_labels$V1,
                                            labels = activity_labels$V2)) %>%
                select(activity)

# Rename subject variable
subject_train <-        subject_train %>%
                        rename(subject = V1)

# Column bind all "Training" Data into one data frame                   
train_combined <- cbind(subject_train, y_train, X_train)

# Cast as data frame extension
train_combined <- as_tibble(train_combined)

# Reshape data from wide to long
library(reshape2)

train_melt <- melt(train_combined, 
                   id = c("subject", "activity"))

# Merge on descriptive variable names from "features.txt"
train_final <- merge(x = train_melt, y = features, by = "variable", all.x = TRUE)
# Select relevant columns
train_final2 <-  train_final %>%
                #Add additional variable identifying 'TRAIN' or 'TEST' group
                mutate(group = as.integer(1)) %>%
                select(subject, activity, group, variableName, value) %>%
                rename(variable = variableName)

train_final2 <- as_tibble(train_final2)

## 2A. Import 'Test' Data

# Read in subject data
subject_test<- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
# Each row identifies the subject who performed the activity for each window sample.
# Its range is from 1 to 30.

# Read in X_test data ("Test set")
X_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")

# Read in y_test data ("Test labels")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")


## 2B. Combine and Clean "Test" Data

# Update "Test labels" as factor with descriptive activity names
y_test <-      y_test %>%
        mutate(activity = factor(V1, levels = activity_labels$V1,
                                 labels = activity_labels$V2)) %>%
        select(activity)

# Rename subject variable
subject_test <- subject_test %>%
                rename(subject = V1)

# Column bind all "Test" Data into one data frame                   
test_combined <- cbind(subject_test, y_test, X_test)

# Cast as data frame extension
test_combined <- as_tibble(test_combined)

# Reshape data from wide to long
library(reshape2)

test_melt <- melt(test_combined, 
                   id = c("subject", "activity"))

# Merge on descriptive variable names from "features.txt"
test_final <- merge(x = test_melt, y = features, by = "variable", all.x = TRUE)
# Select relevant columns
test_final2 <-  test_final %>%
        #Add additional variable identifying 'TRAIN' or 'TEST' group
        mutate(group = as.integer(2)) %>%
        select(subject, activity, group, variableName, value) %>%
        rename(variable = variableName)

test_final2 <- as_tibble(test_final2)


## 3. Merge the "Training" and the "Test" data to create one data set

all_data <- rbind(train_final2, test_final2)

all_data <- as_tibble(all_data)

# Cast "group" variable as factor
all_data <-     all_data %>%
                mutate(group = factor(group, levels = c(1,2),
                                      labels = c("TRAIN","TEST")))


# 4. Extract the measurements on the mean and standard deviation for each measurement
final <- all_data[grep("(mean|std)[(][)]", all_data$variable),]
# Measurements are extracted where the feature description includes
# and exact match for "mean()" or "std()"
final <- as_tibble(final)


# 5. From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.

final_summary <-        final %>%
                        group_by(subject, activity, group, variable) %>%
                        summarise(mean = mean(value))

# 6. Output Summary Data
write.table(final_summary, "./output/summary.csv", row.names = FALSE, sep = ",")
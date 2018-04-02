# 1. Make libraries available
library(dplyr)

# 2. Read files from the unzipped folder "UCI HAR" Dataset in your current working
# directory.

# 2.1 Links the class labels with their activity name.
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

# 2.2 List of all features
feature_list <- read.table("./UCI HAR Dataset/features.txt")

# 2.3 Each row identifies the subject who performed the activity for each
# window sample of the test set. Its range is from 1 to 30. 
test_subject_labels <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# 2.4 Test set measurements
test_measurements <- read.table("./UCI HAR Dataset/test/X_test.txt")

# 2.5 Test activity labels
test_activity_labels <- read.table("./UCI HAR Dataset/test/y_test.txt")

# 2.6 Each row identifies the subject who performed the activity for each 
# window sample of the trainings set. Its range is from 1 to 30. 
train_subject_labels <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# 2.7 Training set measurements
train_measurements <- read.table("./UCI HAR Dataset/train/X_train.txt")

# 2.8 Training activity labels
train_activity_labels <- read.table("./UCI HAR Dataset/train/y_train.txt")


# 3. Create a test data set

# 3.1 Add feature list labels to test_measurements
names(test_measurements) <- feature_list$V2

# 3.2 Add test activity_labels and subject labels to test_measurements
names(test_activity_labels) <- "activity_code"
names(test_subject_labels) <- "subject_code"
test_dataset <- cbind(test_activity_labels, test_subject_labels, test_measurements)


# 4. Create a training data set

# 4.1 Add feature list labels to train_measurements
names(train_measurements) <- feature_list$V2

# 4.2 Add test activity_labels and subject labels to test_measurements
names(train_activity_labels) <- "activity_code"
names(train_subject_labels) <- "subject_code"
train_dataset <- cbind(train_activity_labels, train_subject_labels, train_measurements)


# 5. Merge training dataset and test_dataset into one
train_test_dataset <- rbind(test_dataset, train_dataset)


# 6. Select Columns which contain means and standard deviation
train_test_dataset <- train_test_dataset[,1:460]
human_activity_dataset <- select(train_test_dataset, activity_code, subject_code, contains("mean"), contains("std"))

# 7. add verbose activity names
names(activity_labels) <- c("activity_code", "activity")
human_activity_dataset_v <- merge(human_activity_dataset, activity_labels)
human_activity_dataset_v <- select (human_activity_dataset_v, 70, 2:69)


# 8. Names in Datasets should be:
#       - all to lower case
#       - descriptive
#       - Not duplicated
#       - Not have underscores, dots or white spaces
names(human_activity_dataset_v) <- tolower(names(human_activity_dataset_v))
names(human_activity_dataset_v)[2] <- "subjectcode"
names(human_activity_dataset_v) <- gsub("\\(\\)", "",names(human_activity_dataset_v))
names(human_activity_dataset_v) <- gsub("std", "standard-deviation",names(human_activity_dataset_v))

# 9. Create a tidy data set with the average of each variable for each activity and each subject.

# 9.1 group human_activity_dataset_df by activity and subject
human_activity_dataset_df <- tbl_df(human_activity_dataset_v)
human_activity_dataset_df <- group_by(human_activity_dataset_df, activity,subjectcode)

# 9.2 calculate mean by activity and subject
human_activity_dataset_summary <- summarize_at(human_activity_dataset_df, vars(3:67), mean)

#9.3 Split table by activity
human_activity_dataset_summary_list <- split(human_activity_dataset_summary, human_activity_dataset_summary$activity)



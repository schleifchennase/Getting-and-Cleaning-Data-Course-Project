# Getting-and-Cleaning-Data-Course-Project
R Script to clean the Human Activity Recognition Using Smartphones Data Set 

## Scope
This repository contains a R script to prepare a tidy data set from data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description of the data is available at the site where the data was obtained:

[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones]

The raw data can be downloaded via the following link.

[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip]

## Prerequisites
To run the R script you should
* have installed R
* have downloaded and unzipped the files from [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip] and added the folder to your working directory for R
* have installed the dplyr package for R

## Approach

1. Merge the training and the test sets to create one data set.
        
        1.1 Read files from the unzipped folder "UCI HAR" Dataset in your current working directory.
        1.2 Create a test data set
                1.2.1 Add feature list labels to test_measurements
                1.2.2 Add test activity_labels and subject labels to test_measurements
        1.3 Create a training data set
                1.3.1 Add feature list labels to train_measurements
                1.3.2 Add test activity_labels and subject labels to test_measurements
        1.4 Merge both datasets
                
2. Extracts only the measurements on the mean and standard deviation for each measurement.
        
        2.1 Merge training dataset and test_dataset into one
        2.2 Select Columns which contain "mean" and "std" in their names to get only data with means and standard deviation
        
3. Uses descriptive activity names to name the activities in the data set
        
        3.1 add verbose activity names
        
4. Appropriately labels the data set with descriptive variable names.
        4.1 Names in Datasets should be:
        
                * all to lower case -> names changed to lower case
                * descriptive -> codes replaced by labels
                * Not duplicated -> no duplicates exist
                * Not have underscores, dots or white spaces -> underscores, dots, white spaces and brackets removed and "-" removed
                
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

        5.1 group dataset by activity and subject
        5.2 calculate mean by activity and subject
        5.3 Split table by activity

Hadley Wickham describes messy data as: 

       "        * Column headers are values, not variable names.
                * Multiple variables are stored in one column.
                * Variables are stored in both rows and columns.
                * Multiple types of observational units are stored in the same table.
                * A single observational unit is stored in multiple tables."
                
Therefore column headers have been made descriptive all variables are stored in their own column, variables are stored only in columns. The dataset has been splitted by activity to multiple tables stored in a list not to have multiple types of observational units stored in one table.

## Result

A file named human_activity_dataset_summary is stored in the working directory and can be read into R by read.table("./human_activity_dataset_summary", header=TRUE)

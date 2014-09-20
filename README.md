# README
ammadrigal  
20 September 2014  

## Getting and Cleaning Data Course Project
This file gives a description of the run_analysis.R script: the tasks it performs and how to run it.

It provides all elements necessary (input & output data, scripts) to meet assignment requirements:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

To get the presented outputs you need to use the run_analysis.R script in the following way.

- First, unzip the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and rename the folder with "UCIHARDataset".
- Make sure the folder "UCIHARDataset" and the run_analysis.R script are both in the current working directory.
- Next, run or source the file "run_analysis.R" in R / RStudio.
- You will find two output files are generated in the current working directory:
    1. merged_data.txt (8.3 Mb): it contains a data set with 10299*69 dimension. With all individual for both test and training set; with all activities per subject.
    2. data_with_means.txt (225 KB): it contains a data set with 180*69 dimension. This contains the average of all measurements on the mean and standard deviation for each measurement for each activity and each subject. There are 6 activities in total and 30 subjects in total. So this has 180 rows for each of the 66 features. The first three columns contain the Group , Activity and Subject IDs.
- This text files can be accessed independently. For example, you can use data <- read.table("./tidyData_with_means.txt",header=TRUE) command in R/ RStudio to read the second file. 




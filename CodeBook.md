# CodeBook
ammadrigal  
20 September 2014  
## Getting and Cleaning Data Course Project CodeBook

This code book describes the variables, the data, and any transformations or work that was performed to clean up the data.

### Input Data
- The site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
- The data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### Data Reading / Preparation  / transformations.

The run_analysis.R script performs the following steps to prepare and clean the data:

#### Reading data.

- Read X_train.txt, y_train.txt and subject_train.txt from the "./train" folder.

- Read X_test.txt, y_test.txt and subject_test.txt from the "./test" folder.

      - The X files have the information for the different features of the study.
      - The Y files have the information about the Activities performed.
      - The subject files have the recording of the ID of the subject performing the activity.
      - The _train files contain data from the training group.
      - The _test files contain data from the test group.

- Read the features.txt file which contains the labels of the features contained in the X files.

- Read the activity_labels.txt file which contains the labels of the 6 activities.

#### Prepare Data

- The training and test data are r-binded, to have all information in the same data. An identifier for "Group" is added to the data with values "train" and "test"
- The features.txt is used to identify and only extract the measurements on the mean and standard deviation which results in 66 corresponding columns. The labels in "features" are also manipulated to make the Variable naming tidier. Then these are used to named the final data sets.
- Clean the activity names in the second column of the activity_labels. We remove the underscore and capitalize the letter immediately after the underscore.
 - A variable with the activityLabel is added into the main data frame.
 - A variable with the Subject ID is also appended into the main data frame.

 - data.table() package is used to summarise in one step the merged data frame into a tidy and smaller one that contains the averages of the measurements for the 66 variables of interest by Activity and Subject ID.
 
### Output data

- There are two output files are generated in the current working directory:
    1. merged_data.txt: contains a data set with all individual detail for both test and training set; with all activities per subject, for all subjects.
    2. tidyData_with_means.txt contains a data set with the average of all measurements on the mean and standard deviation for each measurement for each activity and each subject. There are 6 activities in total and 30 subjects in total. So this has 180 rows for each of the 66 features. 
    
#### Variable Description

    Both data sets contain 69 variables. The first three columns contain the Group, Activity and Subject IDs. The next 66 contain the  average values for the features in the data.

- Group has two values and identifies whether the subject belonged to either test or train group.
- SubjectID identifies one of 30 subjects. It is therefore an integer class variable that ranges from 1 to 30.
- Activity identifies one of 6 possible activites identified in the experimental design.
    - standing 
    - sitting  
    - laying
    - walking 
    - walkingDownstairs
    - walkingUpstairs  

- The next 66 columns relate to the features in the data set. The naming is a combination of:
1. the actual features values: 
       [1] fBodyAcc             fBodyAccJerk         fBodyAccMag         
       [4] fBodyBodyAccJerkMag  fBodyBodyGyroJerkMag fBodyBodyGyroMag    
       [7] fBodyGyro            tBodyAcc             tBodyAccJerk        
      [10] tBodyAccJerkMag      tBodyAccMag          tBodyGyro           
      [13] tBodyGyroJerk        tBodyGyroJerkMag     tBodyGyroMag        
      [16] tGravityAcc          tGravityAccMag 

2. "Mean" stating that its value corresponds to the average of all mean scores for each feature.

3. "Std" stating that its value corresponds to the average of all standard deviations of the scores for each feature.



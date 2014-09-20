# Step1. Merges the training and the test sets to create one data set.
# setwd("/Users/ammadrigal/Documents/datasciencecoursera/CleaningData/ProjectAssesment")

## DATA
trainData <- read.table("./UCIHARDataset/train/X_train.txt")
dim(trainData) # 7352*561
head(trainData)

##  6 activities
trainAct <- read.table("./UCIHARDataset/train/y_train.txt")
table(trainAct)
  
## 30 subjects
trainSubject <- read.table("./UCIHARDataset/train/subject_train.txt")

#TEST DATA
testData <- read.table("./UCIHARDataset/test/X_test.txt")
dim(testData) # 2947*561
  
testAct <- read.table("./UCIHARDataset/test/y_test.txt") 
table(testAct)
str(testAct)

testSubject <- read.table("./UCIHARDataset/test/subject_test.txt")
str(testSubject)

dim(trainData); tail(names(trainData))
dim(testData); tail(names(testData))

all.equal(names(trainData),names(testData))

#row.names(testData)<-(dim(trainData)[1]+1):(dim(trainData)[1]+dim(testData)[1])

# joinData
joinData <- rbind(trainData, testData)
dim(joinData) # 10299*561

joinData$Group<-c(rep("train",dim(trainData)[1]),rep("test",dim(testData)[1]))
joinData$ActivityID<-c(trainAct[,1],testAct[,1])
joinData$SubjectID<-c(trainSubject[,1],testSubject[,1])



# Step2. Extracts only the measurements on the mean and standard 
# deviation for each measurement. 
features <- read.table("./UCIHARDataset/features.txt")
dim(features)  # 561*2
str(features)
meanStdIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
length(meanStdIndices) # 66
joinDataMSd <- joinData[, meanStdIndices]

#cleaning names
names(joinDataMSd) <- gsub("\\(\\)", "", features[meanStdIndices, 2]) # remove "()"
names(joinDataMSd) <- gsub("mean", "Mean", names(joinDataMSd)) # capitalize M
names(joinDataMSd) <- gsub("std", "Std", names(joinDataMSd)) # capitalize S
names(joinDataMSd) <- gsub("-", "", names(joinDataMSd)) # remove "-" in column names 
IDsIndices<-c("Group","ActivityID","SubjectID")
joinDataMSd<-cbind(joinDataMSd,joinData[, IDsIndices])
dim(joinDataMSd) # 10299*69

# Step3. Uses descriptive activity names to name the activities in the data set
# Step4. Appropriately labels the data set with descriptive activity names
activity <- read.table("./UCIHARDataset/activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))

joinDataMSd$activityLabel<-activity[joinDataMSd$ActivityID,2]
joinDataMSd$ActivityID<-NULL

cleanedData <- joinDataMSd
dim(cleanedData) # 10299*69
write.table(cleanedData, "merged_data.txt",row.name=FALSE) # write out the 1st dataset

# Step5. Creates a second, independent tidy data set with the average of 
# each variable for each activity and each subject. 
#cleanedData$Group<-NULL
cleanedDT<-data.table(cleanedData)
resultData<-cleanedDT[,lapply(.SD,mean),by=c("activityLabel","SubjectID","Group")]
head(resultData)
write.table(resultData, "tidyData_with_means.txt",row.name=FALSE) # write out the 2nd dataset

# data <- read.table("./tidyData_with_means.txt",header=TRUE)
# dim(data); data[1:12, 1:3]

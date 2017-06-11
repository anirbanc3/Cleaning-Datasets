##########################################################################################################

## Coursera Getting and Cleaning Data Course Project
## Anirban Chakraborty
## 2017-06-11

# run_analysis.r File Description:

# This script will perform the following steps on the UCI HAR Dataset downloaded from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Labels the data set with descriptive activity names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

##########################################################################################################

rm(list = ls())     #clears working environment variables
library(dplyr)

filename <- "dataset.zip"

#if the file does not exist already then download the file and unzip it
if(!file.exists(filename)){
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, filename)
}
if(!file.exists("UCI HAR Dataset")){
  unzip(filename)
}

#import activity labels and features
activityLabels     <- read.table("./UCI HAR Dataset/activity_labels.txt")
colnames(activityLabels) <- c("Id", "Activity")
features           <- read.table("./UCI HAR Dataset/features.txt")
featuresList       <- as.character(features[,2])

#import training sets
subTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
xTrain   <- read.table("./UCI HAR Dataset/train/X_train.txt")
yTrain   <- read.table("./UCI HAR Dataset/train/y_train.txt")

#import test sets
subTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
xTest   <- read.table("./UCI HAR Dataset/test/X_test.txt")
yTest   <- read.table("./UCI HAR Dataset/test/y_test.txt")

#1. Merge the training and the test sets to create one data set.
trainData <- cbind(subTrain,yTrain,xTrain)
testData  <- cbind(subTest,yTest,xTest)
allMerged <- rbind(trainData,testData)

#4. Appropriately labels the data set with descriptive variable names.
colnames(allMerged) <- c("Subject","Id",featuresList)

#2. Extract only the measurements on the mean and standard deviation for each measurement.
varNames <- featuresList[grep(".*mean.*|.*std.*",featuresList)]
reqdData <- cbind(allMerged[,c(1,2)],allMerged[,varNames])


#3. Uses descriptive activity names to name the activities in the data set
activityMerge <- merge(activityLabels, reqdData, by = "Id" )
activityMerge <- activityMerge[,-1, drop = FALSE]

#5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.
if(all(!is.na(activityMerge)) == TRUE) {
  avgData <- activityMerge %>% group_by(Activity,Subject) %>% summarize_each(funs(mean))
  write.table(avgData, file = "tidyData.txt", row.names = FALSE, quote = FALSE)
}

tidsy <- read.table("tidyData.txt", header = TRUE)










# Getting_and_Cleaning_Data/Week_3
# Date: 05/24/2015

# filename: run_analysis.R

# setwd("D:/02_H-K/21_Learning/21_03_Getting_and_Cleaning_Data/Week_3/data/UCI_HAR_Dataset")

## relevant libraries
library(data.table)
library(dplyr)

## Read Meta data
featNames <- read.table("./features.txt")
actLabels <- read.table("./activity_labels.txt")

## Read the test data
subjTest <- read.table("./test/subject_test.txt", header=FALSE)
actTest  <- read.table("./test/y_test.txt", header=FALSE)
featTest <- read.table("./test/X_test.txt", header=FALSE)

## Read the training data
subjTrain <- read.table("./train/subject_train.txt", header=FALSE)
actTrain  <- read.table("./train/y_train.txt", header=FALSE)
featTrain <- read.table("./train/X_train.txt", header=FALSE)

## 1. Merge the training and the test sets to create one data set.
## 1-1) Combine same type of tables, respectively
subject  <- rbind(subjTest, subjTrain)
activity <- rbind(actTest,  actTrain)
features <- rbind(featTest, featTrain)
## 1-2) Add the column names
colnames(subject)  <- "Subject"
colnames(activity) <- "Activity"
colnames(features) <- t(featNames[2])
## 1-3) Join three (subject, activity, features) tables
mergeData <- cbind(subject, activity, features)
dim(mergeData)

## 2. Extract only the measurements on the mean and standard deviation for each measurement. 
## 2-1) Grep the list of columns whose name including 'mean' or 'std' (case-insensitive)
colsMeanSTD <- grep(".*mean.*|.*std.*", names(mergeData), ignore.case=T)
## 2-2) Combine the Subject and Activity column number to the list of Mean_STD columns
colsExtracted <- c(1,2, colsMeanSTD)
## 2-3) Extract the relevant columns from the data set
extractData <- mergeData[, colsExtracted]
dim(extractData)


## 3. Use descriptive activity names to name the activities in the data set
extractData$Activity[extractData$Activity == 1] <- "Walking"
extractData$Activity[extractData$Activity == 2] <- "Walking Upstairs"
extractData$Activity[extractData$Activity == 3] <- "Walking Downstairs"
extractData$Activity[extractData$Activity == 4] <- "Sitting"
extractData$Activity[extractData$Activity == 5] <- "Staning"
extractData$Activity[extractData$Activity == 6] <- "Laying"


## 4. Appropriately label the data set with descriptive variable names.
names(extractData) <- gsub( "^t", "time", names(extractData))
names(extractData) <- gsub( "^f", "freq", names(extractData))
names(extractData) <- gsub( "Acc", "Accelerometer", names(extractData))
names(extractData) <- gsub( "Gyro", "Gyroscope", names(extractData))
names(extractData) <- gsub( "Mag", "Magnetometer", names(extractData))
names(extractData) <- gsub( "BodyBody", "Body", names(extractData))
names(extractData) <- gsub( "tBody", "timeBody", names(extractData))
names(extractData) <- gsub( "),", ",", names(extractData))


## 5. From the data set in step 4, create a second, independent 
##    tidy data set with the average of each variable for each 
##    activity and each subject.
extractData <- data.table(extractData)
tidyData <- aggregate(. ~ Subject + Activity, extractData, mean)
tidyData <- tidyData[order(tidyData$Subject, tidyData$Activity),]
write.table(tidyData, file="tidyData.txt", row.name=FALSE)

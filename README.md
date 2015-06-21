# Getting_and_Cleaning_Data (week3 peer assessments)

The purpose of this project is to demonstrate the learner's ability to collect, work with, 
and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 
The following should be submitted: 

     1) a tidy data set as described below,
     2) a link to a Github repository with the script (run_analysis.R) for performing the 
        analysis,
     3) CodeBook.md that describes the variables, the data, and any transformations or 
        work to clean up the data, and
     4) the current readme.md that explains how all of the scripts work and how they are 
        connected. 

Here are the data for the project:

  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The R script called "run_analysis.R" does the following:

     1) Merges the training and the test sets to create one data set.
     2) Extracts only the measurements on the mean and standard deviation for each 
        measurement.
     3) Uses descriptive activity names to name the activities in the data set
     4) Appropriately labels the data set with descriptive variable names.
     5) From the data set in step 4, creates a second, independent tidy data set with the 
        average of each variable for each activity and each subject.

The following are tips to peform this project:

     0) Two libraries 'data.table' and 'dplyr' are needed; use 'read.table' in reading files.
     1) a. Combine same type of tables under /test and /train sub-folders using rbind() 
           unction.
        b. Add the column names. The list of "feature.txt" can be names for Features.
        c. Join Subject, Activity, and Features columns using cbind() function.
     2) Use 'grep()' function to extract only columns whos name including 'mean' or 'std'.
     3) Confer 'activity_labels.txt' to make descriptive activiy names.
     4) In order to give descriptive feature variable names, replace 't' w/ 'time', 'f' w/ 
        'freq', 'Acc' w/ 'Accelerometer', 'Gyro' w/ 'Gyroscope', 'Mag' w/ 'Magnetometer', 
        'BodyBody' w/ 'Body', etc.
     5) a. To creata a tidy data, use 'data.table()' and aggregate() functions.
        b. To upload the tidy data set as a text file, use 'write.table()' function with 
          row.name=FALSE.

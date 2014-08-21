Analysis of Human Activity Recognition Using Smartphones Dataset
======================

Analysis Execution Progress
------------------------------
These are the steps which I've implemented in R Language (the whole code is in file run_analysis.R):

**Reading measurment data (test dataset)**

- Reading X data ("test/X_test.txt")
- Reading Y data ("test/Y_test.txt")
- Reading Subjects data ("test/subject_test.txt")
- Binding columns of X, Y, and Subject dataset

>Note: I used scan function too read the X files because it's more faster and memory-efficient than other read functions.


**Reading measurment data (train dataset)**
- Reading X data ("train/X_train.txt")
- Reading Y data ("train/Y_train.txt")
- Reading Subjects data ("train/subject_train.txt")
- Binding columns of X, Y, and Subject dataset

**Combine all together**
- Binding test and train dataset by rows
- Fetching Activities definition from seperate file ("activity_labels.txt")
- Joining the main dataset with activities to set the ActivityName: main dataset contains a column with the name ActivityId
- Grouping the main dataset based on Subject and Activity columns to calculate average of all measurements

**Correction**
- Extracting mentioned columns which their name contains "mean" or "std"
- Remove unused columns from main dataset
- Changing column names to be more readable

**Saving and returning data**
- Saving result using write.table
- Return the result

How to run
------------------
- Download the data from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
- Extract in your computer in a folder <MyFolder>
- Download "run_analysis.R" from this Repo in <MyFolder>
- Open "run_analysis.R" with R-Studio
- Set the working directory to <MyFolder> using setwd() function (ie: setwd("c:/UserData/MyData/"))
- Load the script using source("run_analysis.R")
- Call main() function to get the result
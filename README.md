Getting and Cleaning Data Course Project
======================

Analysis Execution Progress
------------------------------
These are the steps which I've implemented in R Language (the whole code is in file run_analysis.R):

**Reading measurment data (test dataset)**

- Reading X data ("test/X_test.txt")
- Reading Y data ("test/Y_test.txt")
- Reading Subjects data ("test/subject_test.txt")
- Binding columns of X, Y, and Subject dataset using `cbind()` function

>Note: I used `scan()` function to read the X files because it's more faster and memory-efficient than other functions like `read.csv()` or `read.tale()`.


**Reading measurement data (train dataset)**
- Reading X data ("train/X_train.txt")
- Reading Y data ("train/Y_train.txt")
- Reading Subjects data ("train/subject_train.txt")
- Binding columns of X, Y, and Subject dataset using `cbind()` function

**Combine all together**
- Binding test and train dataset by rows  using `rbind()` function
- Fetching Activities definition from separate file ("activity_labels.txt")
- Joining the main dataset with activities to set the ActivityName: main dataset contains a column with the name ActivityId (using `merge()` function). I name it main-dataset.

** Calculate average of all measurements**
- Grouping the main-dataset based on Subject and Activity columns to calculate average of all measurements using `aggregate()` function



**Correction**
- Extracting main-dataset columns which the name contains "mean" or "std"
- Remove unused columns from main-dataset
- Changing column names to be more readable

>Note: In the last step I have replaced some abbreviations with their complete work. The function `correct_column_names()` also remove unnecessary letters like parentheses, dashes,...

**Saving and returning data**
- Saving result using write.table
- Return the result

How to run
------------------
- Download the data from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

- Extract in your computer in a folder <MyFolder>
- Download "run_analysis.R" from this Repo in <MyFolder>
- Open "run_analysis.R" with R-Studio
- Set the working directory to <MyFolder> using setwd() function 
- Load the script in the environment
- Call `main()` function to get the result

Replace <MyFolder> with you folder full path and execute this script 
```sh
setwd("<MyFolder>")
source("run_analysis.R")
result <- main()
```

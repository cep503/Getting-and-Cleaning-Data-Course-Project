# Getting & Cleaning Data - Course Project. 
#
# You should create one R script called run_analysis.R that does the following. 
# A - Merges the training and the test sets to create one data set.
# B - Extracts only the measurements on the mean and standard deviation for each measurement. 
# C - Uses descriptive activity names to name the activities in the data set
# D - Appropriately labels the data set with descriptive variable names. 
# E - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# 
# You will be required to submit: 
# 1) a tidy data set as described below, 
# 2) a link to a Github repository with your script for performing the analysis, and
# 3) a code book that describes the variables, the data, and any transformations or work 
# that you performed to clean up the data called CodeBook.md. 
# You should also include a README.md in the repo with your scripts. 
# This repo explains how all of the scripts work and how they are connected.  
# 
# 
#----------------------------------------------------------------------------------------------------
# 0. First, download the data.
 
#Print message to user.
print("First, we are going to download the data. Please wait while the program works its magic.")

# File URL to download
DataFileURL <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip' 

# Local data file
DataFileZIP <- "./getdata-projectfiles-UCI-HAR-Dataset.zip"

# Directory
DirFile <- "./UCI HAR Dataset"

# Directory and filename (txt or csv) of the clean/tidy data:
tidyDataFile <- "./tidy-UCI-HAR-dataset.txt"

# tidyDataFileAVG <- "./tidy-UCI-HAR-dataset-AVG.csv"

# Directory and filename (.txt) of the clean/tidy data
tidyDataFileAVGtxt <- "./tidy-UCI-HAR-dataset-AVG.txt"

# Download the dataset (. ZIP), which does not exist
if (file.exists(DataFileZIP) == FALSE) {
  download.file(DataFileURL, DestFile = DataFileZIP)
}

# Uncompress data file
if (file.exists(DirFile) == FALSE) {
  unzip(DataFileZIP)
}

print("All good. Everything has been downloaded and the real work will now begin.")
print("...")
#----------------------------------------------------------------------------------------------------
# A. Merge the training and the test sets to create one data set:
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)

# Add column name for subject files
names(subject_train) <- "SubjectID"
names(subject_test) <- "SubjectID"

# Add column name for label files - in y
names(y_train) <- "Activity_Label"
names(y_test) <- "Activity_Label"

# Read features labels from the "features.txt" file. 
# Recall this file is a list of 561 variables, numberered 1 through 561.
features <- read.table("./UCI HAR Dataset/features.txt")
# Friendly names to features column 
#Transpose the second column in the features file to become the header of each "X" file - both test and train
names(X_train) <- features$V2
names(X_test) <- features$V2

# Combines data table by rows... represents x / y / subject is both training and test.
train <- cbind(subject_train, y_train, X_train)
test <- cbind(subject_test, y_test, X_test)
combined <- rbind(train, test)

print("Steps A complete; We have now merged the data sets, and included descriptive headers. Training is in: 'train'. Test data is in: 'test'. Both Test and Training data is in: 'combined'")
print("...")
#---------------------------------------------------------------------------------------------------------
# B. Extract only the measurements on the mean and standard deviation for each measurement.

# Determine which columns contain "mean()" or "std()"
meanstd_cols <- grepl("mean\\(\\)", names(combined)) |
  grepl("std\\(\\)", names(combined))

# Keep the subjectID and activity columns
meanstd_cols[1:2] <- TRUE

# Create a clean 'combined' file that removes unnecessary columns
combined <- combined[, meanstd_cols]

print("Step B is complete.")
print("The mean and standard deviation columns are now the only ones left in the 'combined' file.") 
print("...")
#---------------------------------------------------------------------------------------------------------
# C. Use descriptive activity names to name the activities in the data set:
# and D. Appropriately label the data set with descriptive activity names:

# convert the activity column from integer to factor
combined$Activity_Label <- factor(combined$Activity_Label, 
                            labels=c("Walking","Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying"))

print("Step C+D is complete and descriptive activity labels have been added.")
print("...") 
#---------------------------------------------------------------------------------------------------------
# E. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject:

#
p <- combined[, 3:dim(combined)[2]] 
tidyDataAVGSet <- aggregate(p,list(combined$SubjectID, combined$Activity_Label), mean)

#---------------------------------------------------------------------------------------------------------
# Create (tidy data set)and save the file
write.table(combined, "tidyDataFile.csv", row.names=FALSE)
# Created csv (tidy data set AVG) in diretory
write.csv(tidyDataAVGSet, "tidyDataAVGSet.csv", row.names=FALSE)
# Created txt (tidy data set AVG) in diretory
write.table(tidyDataAVGSet, "tidyDataAVGSet.txt", sep="\t", row.names=FALSE, col.names=FALSE)

print("Step E is complete.")
print("A new file 'TidyDataAVGSet' has been created in the root folder.") 

#---------------------------------------------------------------------------------------------------------
# Sample output of this "run_analysis.R" file:
#[1] "First, we are going to download the data. Please wait while the program works its magic."
#[1] "All good. Everything has been downloaded and the real work will now begin."
#[1] "..."
#[1] "Steps A complete; We have now merged the data sets, and included descriptive headers. Training is in: 'train'. Test data is in: 'test'. Both Test and Training data is in: 'combined'"
#[1] "..."
#[1] "Step B is complete."
#[1] "The mean and standard deviation columns are now the only ones left in the 'combined' file."
#[1] "..."
#[1] "The mean and standard deviation columns are now the only ones left in the 'combined' file."
#[1] "..."
#[1] "Step C+D is complete and descriptive activity labels have been added."
#[1] "..."
#[1] "Step E is complete."
#[1] "A new file 'TidyDataAVGSet' has been created in the root folder."

# NOTE:
# The tidy data averages file that is created dshould have dimensions of 180 observations and 68 variables
# The file should list be grouped by subject, then activity, and then produce the average of the given variable
# 

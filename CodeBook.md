# CodeBook Description
Contains information describes the variables, the data, and any transformations or work performed to clean up the data for the course project.
 
#Original Data
Original data comes from the smartphone accelerometer and gyroscope 3-axial raw signals, processed using various signal processing techniques to measurement vector consisting of 561 features. For detailed description of the original dataset, please see http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  

# Activity Labels
1. WALKING, 
2. WALKING_UPSTAIRS, 
3. WALKING_DOWNSTAIRS, 
4. SITTING, 
5. STANDING, 
6. LAYING

# Values in run_analysis.R:
* DataFileURL: used to reference the URL from which info was downloaded
* DataFileZIP: used to reference the downloaded zip file
* DirFile: used to reference the downloaded data set
* meanstd_cols: used to remove the unnecessary non mean or stf columns
* tidyDataFile: file that combines all the test adn train data
* tidyDataFileAVG.csv: file created as output

# Data in run_analysis.R - Data Descriptions:
* x_test: data frame captured from download of x_test data (2947 obsx 561 var)
* x_train: data frame captured from download of x_train data (7352 obs x 561 var)
* y_test: data frame captured from download of y_test data (2947 obs x 1 var)
* y_train: data frame captured from download of y_train data (7352 obs x 1 var)
* subject_test: data frame captured from download of subject_test data (2947 obs x 1 var)
* subject_train: data frame captured from download of subject_train data (7352 obs x 1 var)
* test: data frame that combines all test data (2947 obs x 563 var)
* train: data frame that combines all train data (7352 obs x 563 var)
* features: data frame that has the labels for the x test and train data (561 obs x 2 var)
* combined: data frame that combines all test and train data (10299 obs x 68 var)
* p: data frame used to consolidate the averages for the combined file (10299 obs x 66 var)
* tidyDataAVGSet: contains the averages of the mean/std columns - grouped as an average by subject and activity (180 obs x 68 var)

# Calculations in run_analysis.R:
* A - Merges the training and the test sets to create one data set.
* B - Extracts only the measurements on the mean and standard deviation for each measurement. 
* C - Uses descriptive activity names to name the activities in the data set
* D - Appropriately labels the data set with descriptive variable names. 
* E - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


# Script Output: Tidy Data Set
* Tidy data set contains the averages for standard deviation and mean values of the raw dataset. This data set has 180 rows and 68 variables. The rows consist of averages for 30 subjects, each of whom performed the 6 activities labeled above. Thus (30x6=180) total rows for which the column variables are averaged. The file is organized with the subjects 1 through 30, then the average for the activity <1>; then subjects 1 - 30, average for activity <2>, etc.

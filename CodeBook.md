# Codebook

##Original Dataset Description

The features in the original dataset come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ  
tGravityAcc-XYZ  
tBodyAccJerk-XYZ  
tBodyGyro-XYZ  
tBodyGyroJerk-XYZ  
tBodyAccMag  
tGravityAccMag  
tBodyAccJerkMag  
tBodyGyroMag  
tBodyGyroJerkMag  
fBodyAcc-XYZ  
fBodyAccJerk-XYZ  
fBodyGyro-XYZ  
fBodyAccMag  
fBodyAccJerkMag  
fBodyGyroMag  
fBodyGyroJerkMag  

The set of variables that were estimated from these signals are: 
*  mean(): Mean value
*  std(): Standard deviation
*  mad(): Median absolute deviation 
*  max(): Largest value in array
*  min(): Smallest value in array
*  sma(): Signal magnitude area
*  energy(): Energy measure. Sum of the squares divided by the number of values. 
*  iqr(): Interquartile range 
*  entropy(): Signal entropy
*  arCoeff(): Autorregresion coefficients with Burg order equal to 4
*  correlation(): correlation coefficient between two signals
*  maxInds(): index of the frequency component with largest magnitude
*  meanFreq(): Weighted average of the frequency components to obtain a mean frequency
*  skewness(): skewness of the frequency domain signal 
*  kurtosis(): kurtosis of the frequency domain signal 
*  bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
*  angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:
*  gravityMean
*  tBodyAccMean
*  tBodyAccJerkMean
*  tBodyGyroMean
*  tBodyGyroJerkMean

##Process Followed to Generate Final Output
The original data contained both training and test datasets.  There datasets were stored in multiple files:
*  A file with the observations and readings for each of 561 variables
*  A file with the subject id for each observation 
*  A file with the activity id for each observation
In addtion to the experimental data, there were the following descriptive files:
*  A file containing the variable names associated with the variables in the observations
*  A file containing a cross reference between the activity id's and the activity descriptions

Steps  

1. Assign descritive column names to both the training and test datasets using the file containing the variable names.
2. Create datasets that are a subset of each of the training and test datasets containing only the variables associated with mean and standard deviation.
+ Using the grep command with regular expressions provided an easy way to search the descriptive column names to select any column whose name contained the either the text mean() or std().
+ The grep command was chosen over the select command in the dplyr package because there were duplicate column names and the select command did not easily handle that situation
3. Append the activity id and subject id data to the dataset from step 2 to create a complete dataset with the variables, subject id and activity id for each observation.
4. Combine the test and training datasets from step 3 into a single dataset.
5. Add the activity labels to the data set in step 4.  This adds a descriptive, categorical attribute to each observation to make it easier to understand what activity that observation is for.
+ This was done using the merge command from the dplyr package.
+ This was applied after creating the final dataset because the merge command re-orders the data set.  The original datasets are all in the same order which allows them to be combined cleanly.  If the application of the activity labels was done using merge prior to combining all of the subject and activity data to the variables, they would not be combined accurately.
6. The activity id column was then removed from the dataset, leaving a clean dataset containing only the subject id, activity description and mean/std variables.
7. The average of each variable in the dataset from step 6 was calculated grouped by each unique combination of subject id and activity description resulting in a dataset that contained the following:
+One row for every combination of subject id and activity
+One column for the average of observations for each of the original variables for that subject id and activity
8. In order to make this data "tidy" and easy to use for analysis, I chose to reshape the wide dataset into a narrow dataset using the melt command from the reshape2 package.   
The final, tidy dataset contains the following attributes:
*  Subject ID
*  ActivityDescription
*  Variable - containes the name of the variable observed
*Value - contains the value of the average of the variable in the "Variable" column for that subject and activity

The final dataset adheres to the general principals of "tidy" data as follows:
*  Each observation is in a single row - the average of the original observations of the variable in the variable column for the subject and activity in the row  
*  Each column has descriptive label names
*  The rows have descriptive Activity descriptions making it easy to know what activity and variable it is for
*  Each column only contains one single type of data
*  The data is structured in a way that is easy to understand and use for analysis

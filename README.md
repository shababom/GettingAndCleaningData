# Getting and Cleaning Data Course Project 
Coursera, Johns Hopkins    
May 24, 2015   
Instructor - Jeff Leek   

#Overview
This repo is the output of an assigned project from the Getting and Cleaning Data course offered by Johns Hopkins via Coursera.  The project details and repo information are below.

##Instructions given for Project
One of the most exciting areas in all of data science right now is wearable computing - see for example [this article](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/) . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

Here are the data for the project:

[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

If you want to understand the data used in this project better download the dataset. The data file contains documentation that describes the experiment and the datasets.

You should create one R script called run_analysis.R that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##This project repo includes the following files:
*  README.md
*  Codebook.md - Codebook for the project 
*  run_analysis.R - script used to generate the final output - this can be downloaded and executed to reproduce the output
*  tidy_summarized_data - the final output geneerated by applying the run_analysis.R script to the original data set


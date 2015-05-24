install.packages("dplyr")
library("dplyr")
library("reshape2")

#load the test and training data set into data.frames
testdata <- read.table("./test/x_test.txt")
trainingdata <- read.table("./train/x_train.txt")

#load file with feature labels into a data.frame
featurelabels <- read.table("./features.txt")

#extract the label names from the data.frame into a factor variable and assign
#them to the test and training data to give the data meaningful column names
#the labels are in the same order as the data set
labels <- featurelabels[,2]

colnames(testdata) <- labels
colnames(trainingdata) <- labels

#create dataframe that is a subset of the complete dataset that only contains
#the columns that have mean or standard deviation by searching the columns names
#using grep and regular expressions to search for the text pattern of mean() or std()
mean_std_testdata <- testdata[,grep("mean()|std()", colnames(testdata))]
mean_std_traindata <- trainingdata[,grep("mean()|std()", colnames(trainingdata))]

#Read in Activity data - this file has the list of activity id's for each observation 
# in the test/train data set
testactivity <- read.table("./test/y_test.txt")
trainactivity <- read.table("./train/y_train.txt")

#load subject data for test and train datasets - this file has the subject id for
#each observation in the test/train data set
testsubjects <- read.table("./test/subject_test.txt")
trainsubjects <- read.table("./train/subject_train.txt")

#combine all data into a single dataset - create a single data set that has the 
# subject, activity id, results - the order of each file is the same
combinedTestData <- cbind(testactivity, testsubjects, mean_std_testdata)
combinedTrainData <- cbind(trainactivity, trainsubjects, mean_std_traindata)

#combine the test and train datasets into a single dataset by
#appending the train data to the bottom of the test data set
combinedAllData <- rbind(combinedTestData, combinedTrainData)

#ensure that all columns have business meangingful column names
colnames(combinedAllData) <- c("Activity", "Subject", colnames(mean_std_testdata))

#load activity labels lookup file - contains the cross reference of the activity numbers
#to the activity descriptions
activityLabels <- read.table("./activity_labels.txt")

#Add Activity Description to Activity Data by using the merge function from the dplyr package
#this function performs a join between the two files joining on the activity id in both
#files.  all=TRUE means a full outer join
mergeActivity <- merge(activityLabels, combinedAllData, by.x="V1", by.y="Activity", all=TRUE)

#drop the Activity ID column from the dataset
final_dataset <- mergeActivity[,2:82]

#Add the meaningful column name for the Activity description
colnames(final_dataset) <- c("ActivityDescription", colnames(final_dataset[,2:81]))

#create a dataset with the average of each variable (column) for each activity and each subject combination
#should have one row for every activity/subject combination with the average of each 
#variable in the original dataset for that combination
summarized_data <- final_dataset %>% group_by(Subject, ActivityDescription) %>% summarise_each(funs(mean))

#Transpose summarized data to create a row for each subject, activity and variable combination
tidy_summarized_data <- melt(summarized_data, id=c("Subject", "ActivityDescription"))

#write the final summarized dataset to a file
write.table(tidy_summarized_data, file="./tidy_summarized_data.txt", sep="\t", row.names=FALSE)

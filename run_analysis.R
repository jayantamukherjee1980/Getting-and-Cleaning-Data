#Download end extract the files for analysis
#setwd("E:/studymaterials/DataScience/Course3/w4/Assignment")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile="Dataset.zip")
unzip(zipfile="Dataset.zip",exdir="./data")
#list.files("./data", recursive=TRUE)

#read all relevant files into tables
xtrain = read.table("./data/UCI HAR Dataset/train/X_train.txt",header = FALSE)
ytrain  = read.table("./data/UCI HAR Dataset/train/Y_train.txt",header = FALSE)
subject_train  = read.table("./data/UCI HAR Dataset/train/subject_train.txt",header = FALSE)
xtest = read.table("./data/UCI HAR Dataset/test/X_test.txt",header = FALSE)
ytest = read.table("./data/UCI HAR Dataset/test/y_test.txt",header = FALSE)
subject_test = read.table("./data/UCI HAR Dataset/test/subject_test.txt",header = FALSE)
features = read.table("./data/UCI HAR Dataset/features.txt",header = FALSE)
activityLabels = read.table("./data/UCI HAR Dataset/activity_labels.txt",header = FALSE)

#adding suitable column names
#(Point 4)
colnames(xtrain) = features[,2]
colnames(ytrain) = "activityId"
colnames(subject_train) = "subjectId"
colnames(xtest) = features[,2]
colnames(ytest) = "activityId"
colnames(subject_test) = "subjectId"
colnames(activityLabels) <- c('activityId','activityType')

#(Point 1)
#Merging of the training and the test sets to create one data set
merged_train = cbind(ytrain, subject_train, xtrain)
merged_test = cbind(ytest, subject_test, xtest)

oneDataSet = rbind(merged_train, merged_test)
#oneDataSet

#(Point 2)
#extract mean and standard deviation measurements
allcolNames = colnames(oneDataSet)
filter_mean_std_colls = (grepl("activityId" , allcolNames) | grepl("subjectId" , allcolNames) | grepl("mean.." , allcolNames) | grepl("std.." , allcolNames))
meanStdSet <- oneDataSet[ , filter_mean_std_colls == TRUE]
#meanStdSet

#(Point 3)
#Adding descriptive activity names to name the activities in the data set
descriptiveActivitySet = merge(meanStdSet, activityLabels, by='activityId', all.x=TRUE)
#descriptiveActivitySet

#(Point 5)
#independent tidy data set with the average of each variable for each activity and each subject 
tidyDataSet <- aggregate(. ~subjectId + activityId, descriptiveActivitySet, mean)
#tidyDataSet
write.table(tidyDataSet, "tidyDataSet.txt", row.name=FALSE)

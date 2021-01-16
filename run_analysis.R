###################################
# Getting and Cleaning Data Course Project

## Install readr package
install.packages("dplyr")
library(dplyr)

install.packages("tidyr")
library(tidyr)

# Download data 
download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile="accelerometerdata.zip")

# Unzip data
unzip(zipfile="accelerometerdata.zip")

##### unzipped data is placed in a folder called "UCI HAR Dataset"

# load labels and features into R
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")

# load train files
# x train contains the recorded data from the accelerometer and gyroscope
xtrain <- read.table("UCI HAR Dataset/train/X_train.txt")
# y train contains the activity done (sitting, walking, etc)
ytrain <- read.table("UCI HAR Dataset/train/y_train.txt")
# subject train contains the subject who had data collected on them (of the 30 subjects)
subjecttrain <- read.table("UCI HAR Dataset/train/subject_train.txt")


# load test files
# x test contains the recorded data from the accelerometer and gyroscope
xtest <- read.table("UCI HAR Dataset/test/X_test.txt")
# y test contains the activity done (sitting, walking, etc)
ytest <- read.table("UCI HAR Dataset/test/y_test.txt")
# subject test contains the subject who had data collected on them (of the 30 subjects)
subjecttest <- read.table("UCI HAR Dataset/test/subject_test.txt")


##### Combine data
# change ytrain and subjecttraincolname
ytrain <- rename(ytrain, "activity" = V1)
subjecttrain <- rename(subjecttrain, "subject" = V1)
# merge train datasets
trainmerge <- cbind(subjecttrain, ytrain, xtrain)
  
##### Combine data
# change ytest and subjecttest colname
ytest <- rename(ytest, "activity" = V1)
subjecttest <- rename(subjecttest, "subject" = V1)
# merge train datasets
testmerge <- cbind(subjecttest, ytest, xtest)

# rbind testmerge and trainmerge to get one big dataset
alldata <- rbind(trainmerge, testmerge)

##### change colnames in alldata to match features.txt
# turn features into a vector of values
featuresvector <- as.vector(features[,2])
# remove () and make lowercase
featuresvector <- tolower(featuresvector)
featuresvector <- gsub("\\()", "", featuresvector)
#combine with "activity"
allcols <- c("subject", "activity", featuresvector)

#rename colnames
alldata <- alldata %>% setNames(allcols)

### change Activity to actual names
alldata$activity <- factor(alldata$activity, levels = activityLabels[,1], labels = activityLabels[,2])
# turn column contents to lowercase instead of all caps
alldata$activity <- tolower(alldata$activity)

### only select columns with stdev and mean in names
#search colnames using grep for mean
meancols <- grep("mean", colnames(alldata))
stdcols <- grep("std", colnames(alldata))  
keepercols <- c(1, 2,meancols, stdcols)  
# select columns from the keepercols
alldata <- select(alldata, all_of(keepercols))


####################
## Create new dataset with avg col value for each subject
newdataset <- alldata
newdataset <- newdataset %>%
  group_by(subject, activity) %>%
  summarize_all(mean)

#save data to a table (make sure working directory is correctly set up)
write.table(newdataset, file="tidydata.txt", row.names = FALSE)
newdata <- read.table(file="tidydata.txt")
  
  
  
  
  






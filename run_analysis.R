library(dplyr)
library(dplyr)



fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="~/coursera_ref/test/getting-and-cleaning-data/zipdata.zip")
unzip("zipdata.zip")

## Merges the training and the test sets to create one data set

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("labels", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "labels")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "labels")

head(features)
head(activity_labels)
head(subject_test)
head(subject_train)
head(x_test)
head(y_test)
head(x_train)
head(y_train)


names(features)
names(activity_labels)
names(subject_test)
names(subject_train)
names(x_test)
names(y_test)
names(x_train)
names(y_train)

class(features)
class(activity_labels)
class(subject_test)
class(subject_train)
class(x_test)
class(y_test)
class(y_train)

dim(features)
dim(activity_labels)
dim(subject_test)
dim(subject_train)
dim(x_test)
dim(y_test)
dim(x_train)
dim(y_train)

x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
merged_data <- cbind(subject, y, x)

head(x)
head(y)
head(subject)
head(merged_data)

names(x)
names(y)
names(subject)
names(merged_data)

dim(x)
dim(y)
dim(subject)
dim(merged_data)

## Extracts only the measurements on the mean and standard deviation for each measurement.

data <- merged_data %>% select(subject, labels, contains("mean"), contains("std"))

head(data)

## Uses descriptive activity names to name the activities in the data set.
data$label <- activities[data$label, 2]


head(data)
names(data)[2] = "activity"
names(data)<-gsub("Acc", "Accelerometer", names(data))
names(data)<-gsub("Gyro", "Gyroscope", names(data))
names(data)<-gsub("BodyBody", "Body", names(data))
names(data)<-gsub("Mag", "Magnitude", names(data))
names(data)<-gsub("^t", "time", names(data))
names(data)<-gsub("^f", "frequency", names(data))
names(data)<-gsub("tBody", "TimeBody", names(data))
names(data)<-gsub("-mean()", "Mean", names(data), ignore.case = TRUE)
names(data)<-gsub("-std()", "STD", names(data), ignore.case = TRUE)
names(data)<-gsub("-freq()", "Frequency", names(data), ignore.case = TRUE)
names(data)<-gsub("angle", "Angle", names(data))
names(data)<-gsub("gravity", "Gravity", names(data))
names(data)

## creates a second, independent tidy data set with the average of each variable for each activity and each subject.

summarydata <- data %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(summarydata, "summarydata.txt", row.name=FALSE)
class(summarydata)
names(summarydata)
head(summarydata)

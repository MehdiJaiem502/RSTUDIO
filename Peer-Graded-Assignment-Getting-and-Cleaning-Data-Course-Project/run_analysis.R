#0. Downloading and unzipping dataset

if(!file.exists("./data")){dir.create("./data")}
#Downloading the required data for this project:
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(URL,destfile="./data/Dataset.zip")

# Unzip dataSet in the created or already existing "data" directory.
unzip(zipfile="./data/Dataset.zip",exdir="./data")

#The following steps correspond to the ones in the description on assignement website


#1.Merges the training and the test sets to create one data set.


# 1.1 Reading files

# 1.1.1  Reading the trainings tables:

x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

# 1.1.2 Reading the testing tables:
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

# 1.1.3 Reading the features vector:
features <- read.table('./data/UCI HAR Dataset/features.txt')

# 1.1.4 Reading activity labels:
activityLabels = read.table('./data/UCI HAR Dataset/activity_labels.txt')

# 1.2 Column names assignement:

ColumNames(x_train) <- features[,2]
ColumNames(y_train) <-"activityId"
ColumNames(subject_train) <- "subjectId"

ColumNames(x_test) <- features[,2] 
ColumNames(y_test) <- "activityId"
ColumNames(subject_test) <- "subjectId"

ColumNames(activityLabels) <- c('activityId','activityType')

#1.3 Creation of a one set through the data Merge:

#binding the corresponding columns
MergeTrain <- cbind(y_train, subject_train, x_train)
MergeTest <- cbind(y_test, subject_test, x_test)
FinalMerge <- rbind(MergeTrain, MergeTest)


#Step 2.-Extracts only the measurements on the mean and standard deviation for each measurement.


#2.1 Reading column names:

ColumNames <- ColumNames(FinalMerge)

#2.2 Create vector for defining ID, mean and standard deviation:

MeanStd <- FinalMerge %>% select(subject, code, contains("mean"), contains("std"))

#2.3 Making necessary subset from FinalMerge:

subMeanStd <- FinalMerge[ , MeanStd == TRUE]


# 3. Uses descriptive activity names to name the activities in the data set


ModifyActivityNames <- merge(subMeanStd, activityLabels,
                              by='activityId',
                              all.x=TRUE)


# 4. Appropriately labels the data set with descriptive variable names.

names(MeanStd)[2] = "activity"
names(MeanStd)<-gsub("gravity", "Gravity", names(MeanStd))
names(MeanStd)<-gsub("-freq()", "Frequency", names(MeanStd), ignore.case = TRUE)
names(MeanStd)<-gsub("Gyro", "Gyroscope", names(MeanStd))
names(MeanStd)<-gsub("BodyBody", "Body", names(MeanStd))
names(MeanStd)<-gsub("Mag", "Magnitude", names(MeanStd))
names(MeanStd)<-gsub("tBody", "TimeBody", names(MeanStd))
names(MeanStd)<-gsub("Acc", "Accelerometer", names(MeanStd))
names(MeanStd)<-gsub("-mean()", "Mean", names(MeanStd), ignore.case = TRUE)
names(MeanStd)<-gsub("-std()", "STD", names(MeanStd), ignore.case = TRUE)
names(MeanStd)<-gsub("-freq()", "Frequency", names(MeanStd), ignore.case = TRUE)
names(MeanStd)<-gsub("angle", "Angle", names(MeanStd))
names(MeanStd)<-gsub("^t", "Time", names(MeanStd))
names(MeanStd)<-gsub("gravity", "Gravity", names(MeanStd))
names(MeanStd)<-gsub("^f", "Frequency", names(MeanStd))

#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


#5.1 Creation of a second tidy data set

MeanStdSet2 <- aggregate(. ~subjectId + activityId, ModifyActivityNames, mean)
MeanStdSet2 <- MeanStdSet2[order(MeanStdSet2$subjectId, MeanStdSet2$activityId),]

#5.2 Writing second tidy data set in txt file

write.table(MeanStdSet2, "MeanStdSet2.txt",quote = FALSE, row.names = FALSE)
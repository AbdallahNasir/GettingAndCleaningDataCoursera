# Merging the training data set and the testing data set
trainData <- read.table("UCI HAR Dataset//train//X_train.txt",header = F)
testData <- read.table("UCI HAR Dataset//test//X_test.txt", header = F)
trainy <- read.table("UCI HAR Dataset//train//y_train.txt",header = F)
testy <- read.table("UCI HAR Dataset//test//y_test.txt", header = F)
subjectTrain <- read.table("UCI HAR Dataset//train//subject_train.txt", header = F)
subjectTest <- read.table("UCI HAR Dataset//test//subject_test.txt", header = F)
yAll <- rbind(trainy,testy)
subjectAll <- rbind(subjectTrain, subjectTest)
dataAll <- rbind(trainData,testData)
dataAll <- cbind(dataAll,yAll,subjectAll)
# Freeing Memory
rm(trainData,testData,yAll,trainy,testy, subjectAll,subjectTrain, subjectTest)

desiredFeaturesIds <- c(1, 2, 3, 4, 5, 6, 41, 42, 43, 44
                       , 45, 46, 81, 82, 83, 84, 85, 86
                       , 121, 122, 123, 124, 125, 126, 161
                       , 162, 163, 164, 165, 166, 201, 202
                       , 214, 215, 227, 228, 240, 241, 253
                       , 254, 266, 267, 268, 269, 270, 271
                       , 294, 295, 296, 345, 346, 347, 348
                       , 349, 350, 373, 374, 375, 424, 425
                       , 426, 427, 428, 429, 452, 453, 454
                       , 503, 504, 513, 516, 517, 526, 529
                       , 530, 539, 542, 543, 562, 563)

desiredData <- dataAll[,desiredFeaturesIds]
rm(dataAll,desiredFeaturesIds)
desiredFeaturesNames <- c('tBodyAcc-mean()-X' ,
                          'tBodyAcc-mean()-Y' ,
                          'tBodyAcc-mean()-Z' ,
                          'tBodyAcc-std()-X' ,
                          'tBodyAcc-std()-Y' ,
                          'tBodyAcc-std()-Z' ,
                          'tGravityAcc-mean()-X' ,
                          'tGravityAcc-mean()-Y' ,
                          'tGravityAcc-mean()-Z' ,
                          'tGravityAcc-std()-X' ,
                          'tGravityAcc-std()-Y' ,
                          'tGravityAcc-std()-Z' ,
                          'tBodyAccJerk-mean()-X' ,
                          'tBodyAccJerk-mean()-Y' ,
                          'tBodyAccJerk-mean()-Z' ,
                          'tBodyAccJerk-std()-X' ,
                          'tBodyAccJerk-std()-Y' ,
                          'tBodyAccJerk-std()-Z' ,
                          'tBodyGyro-mean()-X' ,
                          'tBodyGyro-mean()-Y' ,
                          'tBodyGyro-mean()-Z' ,
                          'tBodyGyro-std()-X' ,
                          'tBodyGyro-std()-Y' ,
                          'tBodyGyro-std()-Z' ,
                          'tBodyGyroJerk-mean()-X' ,
                          'tBodyGyroJerk-mean()-Y' ,
                          'tBodyGyroJerk-mean()-Z' ,
                          'tBodyGyroJerk-std()-X' ,
                          'tBodyGyroJerk-std()-Y' ,
                          'tBodyGyroJerk-std()-Z' ,
                          'tBodyAccMag-mean()' ,
                          'tBodyAccMag-std()' ,
                          'tGravityAccMag-mean()' ,
                          'tGravityAccMag-std()' ,
                          'tBodyAccJerkMag-mean()' ,
                          'tBodyAccJerkMag-std()' ,
                          'tBodyGyroMag-mean()' ,
                          'tBodyGyroMag-std()' ,
                          'tBodyGyroJerkMag-mean()' ,
                          'tBodyGyroJerkMag-std()' ,
                          'fBodyAcc-mean()-X' ,
                          'fBodyAcc-mean()-Y' ,
                          'fBodyAcc-mean()-Z' ,
                          'fBodyAcc-std()-X' ,
                          'fBodyAcc-std()-Y' ,
                          'fBodyAcc-std()-Z' ,
                          'fBodyAcc-meanFreq()-X' ,
                          'fBodyAcc-meanFreq()-Y' ,
                          'fBodyAcc-meanFreq()-Z' ,
                          'fBodyAccJerk-mean()-X' ,
                          'fBodyAccJerk-mean()-Y' ,
                          'fBodyAccJerk-mean()-Z' ,
                          'fBodyAccJerk-std()-X' ,
                          'fBodyAccJerk-std()-Y' ,
                          'fBodyAccJerk-std()-Z' ,
                          'fBodyAccJerk-meanFreq()-X' ,
                          'fBodyAccJerk-meanFreq()-Y' ,
                          'fBodyAccJerk-meanFreq()-Z' ,
                          'fBodyGyro-mean()-X' ,
                          'fBodyGyro-mean()-Y' ,
                          'fBodyGyro-mean()-Z' ,
                          'fBodyGyro-std()-X' ,
                          'fBodyGyro-std()-Y' ,
                          'fBodyGyro-std()-Z' ,
                          'fBodyGyro-meanFreq()-X' ,
                          'fBodyGyro-meanFreq()-Y' ,
                          'fBodyGyro-meanFreq()-Z' ,
                          'fBodyAccMag-mean()' ,
                          'fBodyAccMag-std()' ,
                          'fBodyAccMag-meanFreq()' ,
                          'fBodyBodyAccJerkMag-mean()',
                          'fBodyBodyAccJerkMag-std()',
                          'fBodyBodyAccJerkMag-meanFreq()',
                          'fBodyBodyGyroMag-mean()',
                          'fBodyBodyGyroMag-std()',
                          'fBodyBodyGyroMag-meanFreq()',
                          'fBodyBodyGyroJerkMag-mean()',
                          'fBodyBodyGyroJerkMag-std()',
                          'activity',
                          'subject')
colnames(desiredData) <- desiredFeaturesNames

desiredData$activity <- factor(desiredData$activity,
                           levels= c(1,2,3,4,5,6),
                           labels=c("WALKING",
                                    "WALKING_UPSTAIRS",
                                    "WALKING_DOWNSTAIRS",
                                    "SITTING",
                                    "STANDING",
                                    "LAYING"))

tempData <- split(desiredData[,1:78],list(desiredData$subject,desiredData$activity))
newData <- data.frame(t(sapply(tempData,colMeans)))
colnames(newData) <- desiredFeaturesNames[1:78]
rm(tempData)
write.table(newData,file = "tidyData.txt",row.names = F)
# Cleaning Memory
rm(desiredData,newData,desiredFeaturesNames)
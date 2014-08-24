
##***************************************************************/
## SET WORKING DIRECTORY
## TEST AND TRAIN FILES HAVE BEEN COPIED TO THE WORKING DIRECTORY
##***************************************************************/

setwd("H:/My Documents/Coursera/Getting and Cleaning Data/Project/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset")

##***************************************************************/
##READ IN TEST FILES AND ADD COLUMN NAMES TO THE SUBJECT AND TASK FILES
##BIND THE THREE FILES INTO ONE FILE
##***************************************************************/

subject_test <- read.table("subject_test.txt")
colnames(subject_test) <- c("Subject")

x_test <- read.table("X_test.txt")

y_test <- read.table("y_test.txt")
colnames(y_test) <- c("Task")

dim(subject_test)
dim(x_test)
dim(y_test)

test_data <- cbind(subject_test, y_test, x_test)

##***************************************************************/
##READ IN TRAIN FILES AND ADD COLUMN NAMES TO THE SUBJECT AND TASK FILES
##BIND THE THREE FILES INTO ONE FILE
##***************************************************************/
        
subject_train <- read.table("subject_train.txt")
colnames(subject_train) <- c("Subject")

x_train <- read.table("X_train.txt")

y_train <- read.table("y_train.txt")
colnames(y_train) <- c("Task")

dim(subject_train)
dim(x_train)
dim(y_train)

train_data <- cbind(subject_train, y_train, x_train)

##***************************************************************/
##BIND THE TEST AND TRAIN FILES INTO ONE FILE
##ADD DESCRIPTIVE NAMES FOR THE TASKS
##***************************************************************/
        
all_data <- rbind(test_data, train_data)

all_data$Task <- as.character(all_data$Task)
all_data$Task[all_data$Task == "1"] <- "Walking"
all_data$Task[all_data$Task == "2"] <- "Walking Upstairs"
all_data$Task[all_data$Task == "3"] <- "Walking Downstairs"
all_data$Task[all_data$Task == "4"] <- "Sitting"
all_data$Task[all_data$Task == "5"] <- "Standing"
all_data$Task[all_data$Task == "6"] <- "Laying"

##***************************************************************/
##KEEP ONLLY THE ANALYSIS FIELDS THAT HAVE MEAN() OR STD() AT THE END OF THE FILED NAME 
##ADD DESCRIPTIVE NAMES FOR THE ANALYSIS VARIABLES
##***************************************************************/

all_data1 <- all_data[c(1, 2, 3, 4, 5, 6, 7, 8, 43, 44, 45, 46, 47, 48, 83, 84, 85, 86, 87, 88, 123, 124, 125, 
                        126, 127, 128, 163, 164, 165, 166, 167, 168, 203, 204, 216, 217, 229, 230, 242, 243, 255,
                        256, 268, 269, 270, 271, 272, 273, 347, 348, 349, 350, 351, 352, 426, 427, 428, 429,
                        430, 431, 505, 506)]


colnames(all_data1) <- c("Subject",
                         "Activity",
                         "Mean Time Body Acceleration in X Direction",
                         "Mean Time Body Acceleration in Y Direction",
                         "Mean Time Body Acceleration in Z Direction",
                         "Standard Deviation Time Body Acceleration in X Direction",
                         "Standard Deviation Time Body Acceleration in Y Direction",
                         "Standard Deviation Time Body Acceleration in Z Direction",
                         "Mean Time Gravity Acceleration in X Direction",
                         "Mean Time Gravity Acceleration in Y Direction",
                         "Mean Time Gravity Acceleration in Z Direction",
                         "Standard Deviation Time Gravity Acceleration in X Direction",
                         "Standard Deviation Time Gravity Acceleration in Y Direction",
                         "Standard Deviation Time Gravity Acceleration in Z Direction",
                         "Mean Time Body Linear Jerk Acceleration in X Direction",
                         "Mean Time Body Linear Jerk Acceleration in Y Direction",
                         "Mean Time Body Linear Jerk Acceleration in Z Direction",
                         "Standard Deviation Time Body Linear Jerk Acceleration in X Direction",
                         "Standard Deviation Time Body Linear Jerk Acceleration in Y Direction",
                         "Standard Deviation Time Body Linear Jerk Acceleration in Z Direction",
                         "Mean Time Body Gyroscope in X Direction",
                         "Mean Time Body Gyroscope in Y Direction",
                         "Mean Time Body Gyroscope in Z Direction",
                         "Standard Deviation Time Body Gyroscope in X Direction",
                         "Standard Deviation Time Body Gyroscope in Y Direction",
                         "Standard Deviation Time Body Gyroscope in Z Direction",
                         "Mean Time Body Gyroscope Jerk in X Direction",
                         "Mean Time Body Gyroscope Jerk in Y Direction",
                         "Mean Time Body Gyroscope Jerk in Z Direction",
                         "Standard Deviation Time Body Gyroscope Jerk in X Direction",
                         "Standard Deviation Time Body Gyroscope Jerk in Y Direction",
                         "Standard Deviation Time Body Gyroscope Jerk in Z Direction",
                         "Mean Time Body Acceleration Magnitude",
                         "Standard Deviation Time Body Acceleration Magnitude",
                         "Mean Time Gravity Acceleration Magnitude",
                         "Standard Deviation Time Gravity Acceleration Magnitude",
                         "Mean Time Body Linear Jerk Acceleration Magnitude",
                         "Standard Deviation Time Body Linear Jerk Acceleration Magnitude",
                         "Mean Time Body Gyroscope in X Direction Magnitude",
                         "Standard Deviation Time Body Gyroscope Magnitude",
                         "Mean Time Body Gyroscope Jerk Magnitude",
                         "Standard Deviation Time Body Gyroscope Jerk Magnitude",
                         "Mean Frequency FFT Body Acceleration in X Direction",
                         "Mean Frequency FFT Body Acceleration in Y Direction",
                         "Mean Frequency FFT Body Acceleration in Z Direction",
                         "Standard Deviation Frequency FFT Body Acceleration in X Direction",
                         "Standard Deviation Frequency FFT Body Acceleration in Y Direction",
                         "Standard Deviation Frequency FFT Body Acceleration in Z Direction",
                         "Mean Frequency Body Linear Jerk Acceleration in X Direction",
                         "Mean Frequency Body Linear Jerk Acceleration in Y Direction",
                         "Mean Frequency Body Linear Jerk Acceleration in Z Direction",
                         "Standard Deviation Frequency Body Linear Jerk Acceleration in X Direction",
                         "Standard Deviation Frequency Body Linear Jerk Acceleration in Y Direction",
                         "Standard Deviation Frequency Body Linear Jerk Acceleration in Z Direction",
                         "Mean Frequency Body Gyroscope in X Direction",
                         "Mean Frequency Body Gyroscope in Y Direction",
                         "Mean Frequency Body Gyroscope in Z Direction",
                         "Standard Deviation Frequency Body Gyroscope in X Direction",
                         "Standard Deviation Frequency Body Gyroscope in Y Direction",
                         "Standard Deviation Frequency Body Gyroscope in Z Direction",
                         "Mean Frequency Body Acceleration Magnitude",
                         "Standard Deviation Frequency Body Acceleration Magnitude")

##***************************************************************/
##RESHAPE THE DATA AND SEPAARTE ID VARIABLES FROM ANALYSIS VARIABLES
##***************************************************************/
library(reshape2)
melted <- melt(all_data1, id.vars = c("Subject", "Activity"))

##***************************************************************/
##USE THE PLYR PACVKAGE TO SUMMARIZE THE ANALYSIS VARIABLES
##***************************************************************/
library(plyr)
tidy <- ddply(melted, c("Subject", "Activity", "variable"), summarise, mean = mean(value))

##***************************************************************/
##WRITE OUT THE TIDY DATASET TO THE WORKING DIRECTORY
##***************************************************************/
write.table(tidy, file="H:/My Documents/Coursera/Getting and Cleaning Data/Project/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/tidy.txt",row.name=FALSE)

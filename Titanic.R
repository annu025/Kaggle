# Clear environment variables
rm(list = ls())

# Load packages
library('ggplot2') # visualization
library('ggthemes') # visualization
library('scales') # visualization
library('dplyr') # data manipulation
library('mice') # imputation
library('randomForest') # classification algorithm

# Read train and test datasets
train <- read.csv('train.csv', stringsAsFactors = FALSE, header = TRUE)
test  <- read.csv('test.csv', stringsAsFactors = FALSE, header = TRUE)

# set isTrainSet variable to TRUE for train and FALSE for test
train$isTrain <- TRUE
test$isTrain <- FALSE

# set Survived attribute to NA for test dataset before combining the two datasets
test$Survived <- NA

# Compare the attributes in train and test
names(train)
names(test)

# bind train & test datasets
full  <- bind_rows(train, test) 

# check data
str(full)

# verify the rbind
table(full$isTrain)
table(full$Embarked)

# Clean full dataset
full[full$Embarked == '', "Embarked"] <- 'S'

# Check is Age has 'NA' values
table(is.na(full$Age))

# take a median of age and replace it for any 'na' values
age.median <- median(full$Age, na.rm = TRUE)

# replace NA with median of age
full[is.na(full$Age), "Age"] <- age.median

# Check Fare attribute to see if there are any NA values
# If so, then replace it with median of Fare
table(is.na(full$Fare))
fare.median <- median(full$Fare, na.rm = TRUE)
full[is.na(full$Fare), "Fare"] <- fare.median

# Now, splitting back the data into train and test after data cleaning and preparation


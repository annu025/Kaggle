rm(list = ls())

library(data.table)
library(Matrix)
library(xgboost)
library(Metrics)
library(maps)
library(ggplot2)
library(viridis)
library(plotly)

train = fread("../input/train.csv", showProgress = F)
test = fread("../input/test.csv", showProgress = F)

train[, loss:=log(loss)]
test[, loss:=0]
train_ids <- train$id; test_ids <- test$id;
y_train <- train$loss
##
## Remote Server Processing 
##

## Libraries I Need ##
library(caret)
library(tidyverse)
library(aod)

## Reading in Data ##
CompNews <- vroom::vroom("./CompNews.csv")

##############q#####
## Model Testing ##
###################

#nrounds <- 1000

## New, Tuned Grid
#tune_grid <- expand.grid(
#  nrounds = 600,
# eta = 0.1,
# max_depth = c(6, 7, 8, 9, 10),
#  gamma = 0,
#  colsample_bytree = c(1,2,3),
 # min_child_weight = c(1,2,3),
#  subsample = 1
#)

# Tuning 
#tune_control <- caret::trainControl(
#  method = "cv", # cross-validation
#  number = 3, # with n folds 
#  verboseIter = FALSE, # no training log
#  allowParallel = TRUE # FALSE for reproducible results 
#)

#xgb_tune <- caret::train(form=as.factor(isFake)~.,
#                         data=CompNews %>% 
#                           filter(Set == "train") %>%
#                           select(-Id, -Set, -language.x),
#                         method="xgbTree",
#                         verbose = TRUE,
#                       trControl = tune_control,
#                         tuneGrid = tune_grid
#)

#save(xgb_tune, file="model2.Rdata")

# Load the model from server 
#load("/Users/LysLysenko/Desktop/Kaggle/FakeNews/model2.Rdata")

#xgb_tune$bestTune

#grid_tune2 <- expand.grid(
#  nrounds = 600,
#  max_depth = 8,
#  eta = 0.1,
 # gamma = 0,
#  colsample_bytree = 1,
#  min_child_weight = 2,
#  subsample = 1
#)
#
#train_control <- caret::trainControl(
#  method = "none",
#  verboseIter = FALSE, # no training log
#  allowParallel = TRUE # FALSE for reproducible results 
#)

#xgb_tune2 <- caret::train(form=as.factor(isFake)~.,
#                          data=CompNews %>% 
#                            filter(Set == 'train') %>%
#                            select(-Id, -Set, -language.x),
#                          method="xgbTree",
#                          trControl = train_control,
#                         tuneGrid = grid_tune2,
#                          verbose = TRUE
#)

#########################
## Logistic Regression ##
#########################

mylogit <- glm(isFake ~ TitleLength + TextLength + language.x, data = CompNews %>% filter(Set == 'train') %>% select(-Id, -Set), family = "binomial")
logodds <- predict(mylogit, newdata = CompNews %>% filter(Set == 'test') %>% select(-Id, -Set), type = 'response')
logpreds <- numeric(length(logodds))
for(i in 1:length(logodds)){
  if(logodds[i] >=0.5 ){
    logpreds[i] <- 1
  }
  else logpreds[i] <- 0
}









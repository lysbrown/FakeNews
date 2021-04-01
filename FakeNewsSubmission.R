##
## Fake News Submission
##

###############
## Libraries ##
###############

library(tidyverse)
library(caret)

##########
## Data ##
##########
CompNews <- vroom::vroom("/Users/LysLysenko/Desktop/Kaggle/FakeNews/CompNews.csv")

#############
## Default ##
#############

## Grid Defaults
grid_default <- expand.grid(
  nrounds = 100,
  max_depth = 6,
  eta = 0.3,
  gamma = 0,
  colsample_bytree = 1,
  min_child_weight = 1,
  subsample = 1
)

## Train Control
train_control <- caret::trainControl(
  method = "none",
  verboseIter = FALSE, # no training log
  allowParallel = TRUE # FALSE for reproducible results 
)

## XGBoost Creation
xgb_base <- caret::train(form=as.factor(isFake)~.,
                         data=CompNews %>%
                           filter(Set == 'train') %>% 
                           select(-Id, -Set, -language.x),
                         method="xgbTree",
                         trControl = train_control,
                         tuneGrid = grid_default,
                         verbose = TRUE
)

base_preds <- predict(xgb_base,CompNews %>% filter(Set == 'test') %>% select(-Id, -Set, -language.x))

########################
## Best Tunes Round 1 ##
########################

grid_tune1 <- expand.grid(
  nrounds = 600,
  max_depth = 6,
  eta = 0.1,
  gamma = 0,
  colsample_bytree = 1,
  min_child_weight = 1,
  subsample = 1
)

train_control <- caret::trainControl(
  method = "none",
  verboseIter = FALSE, # no training log
  allowParallel = TRUE # FALSE for reproducible results 
)

xgb_tune1 <- caret::train(form=as.factor(isFake)~.,
                         data=CompNews %>% 
                           filter(Set == 'train') %>%
                           select(-Id, -Set, -language.x),
                         method="xgbTree",
                         trControl = train_control,
                         tuneGrid = grid_tune1,
                         verbose = TRUE
)

tune1_preds <- predict(xgb_tune1,CompNews %>% filter(Set == 'test') %>% select(-Id, -Set, -language.x))

########################
## Best Tunes Round 2 ##
########################

grid_tune2 <- expand.grid(
  nrounds = 600,
  max_depth = 8,
  eta = 0.1,
  gamma = 0,
  colsample_bytree = 1,
  min_child_weight = 2,
  subsample = 1
)

train_control <- caret::trainControl(
  method = "none",
  verboseIter = FALSE, # no training log
  allowParallel = TRUE # FALSE for reproducible results 
)

xgb_tune2 <- caret::train(form=as.factor(isFake)~.,
                          data=CompNews %>% 
                            filter(Set == 'train') %>%
                            select(-Id, -Set, -language.x),
                          method="xgbTree",
                          trControl = train_control,
                          tuneGrid = grid_tune2,
                          verbose = TRUE
)

tune2_preds <- predict(xgb_tune2,CompNews %>% filter(Set == 'test') %>% select(-Id, -Set, -language.x))

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

submission <- cbind(CompNews %>% filter(Set == 'test') %>% select(Id), label = logpreds) %>% as.data.frame()
write_csv(submission, "/Users/LysLysenko/Desktop/Kaggle/FakeNews/Submission4.csv")

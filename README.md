## CODE AND PROJECT GUIDE

### OVERALL PURPOSE OF PROJECT

Using the data from the kaggle competition, Fake News, I attempted to construct a model that could feasibly predict whether an article was misleading based on the content of the article, its title, and its author. 

### FILES

FakeNewsDataCleaning.R checks for missing variables as well as begins feature engineering into creating the tf-idf ratio variables upon which my models depend. A language variable was also feature engineered in this file. The overall structure of the dataset was changed in order to accomodate tf-idf ratios for every non-stop word within the articles. 

FakeNewsFeatureEngineering.R binds the dataset created in FakeNewsDataCleaning.R with variables I wanted to explore that were in the original dataset, including author and title. I took time to explore the dataset more using the xtab() function in preparation for creating a logistic regression. I feature engineered the TextLength and TitleLength variables in this file. 

FakeNewsRemoteServer.R was the file I used to evaluate and tune my extreme gradient boosting model on a remote server. 

FakeNewsSubmission.R includes the final code that was used to create the submissions for the kaggle competition.


### METHODS FOR CLEANING & FEATURE ENGINEERING
Using the library tidytext, stopwords, and textcat we feature engineered the tf-idf ratios, barring stopwords, and created a new variable for the language of the article. The textcat library was not able to identify every language of every article and others were so infrequent that it warranted them being clumped together. The entire dataset was reformatted from a long to a wide format so that the tf-idf ratios could be used as explanatory variables. All NA's created by the process of determining tf-idf ratios were converted to 0's. We kept the tf-idf for the highest 50% of common non-stop words. We made this limitation as to avoid overfitting and creating a dataset too large. According to the plots, this was a good cutoff point in order to keep much of the variability. We also determined the length of the articles and the length of the titles using the ngram library. 

### GENERATING PREDICTIONS
The majority of my predictions were generated using the caret package's xgboost. Using extreme gradient boosting I was able to create a model that predicted correctly 97.6% of the time. This model was evaluated using the bestTune method also part of the caret package. The modeling and tuning took place predominantly on remote servers because of the number of explanatory variables. In the meantime, included in these files is a beginning attempt for a logistic regression, using a few variables. This simple logistic regression predicted correctly 72.5% of the time. 

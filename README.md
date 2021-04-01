### CODE AND PROJECT GUIDE

#### OVERALL PURPOSE OF PROJECT
Using the data from the kaggle competition, Fake News, I attempted to construct a model that could feasibly predict whether an article was misleading based on the content of the article, its title, and its author. 

#### FILES
FakeNewsDataCleaning.R checks for missing variables as well as begins feature engineering into creating the tf-idf ratio variables upon which my models depend. A language variable was also feature engineered in this file. The overall structure of the dataset was changed in order to accomodate tf-idf ratios for every non-stop word within the articles. 
FakeNewsFeatureEngineering.R binds the dataset created in FakeNewsDataCleaning.R with variables I wanted to explore that were in the original dataset, including author and title. I took time to explore the dataset more using the xtab() function in preparation for creating a logistic regression. I feature engineered the TextLength and TitleLength variables in this file. 

### METHODS FOR CLEANING & FEATURE ENGINEERING
c.	What methods did you use to clean the data or do feature engineering?

### GENERATING PREDICTIONS
d.	What methods did you use to generate predictions?

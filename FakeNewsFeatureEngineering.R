##
## Feature Engineering for Fake News Data
##

## Libraries
library(ngram)
library(tidyverse)
library(vroom)
library(aod)

## Read in the Data 
fakeNews.train <- read_csv("/Users/LysLysenko/Desktop/Kaggle/FakeNews/train.csv")
fakeNews.test <- read_csv("/Users/LysLysenko/Desktop/Kaggle/FakeNews/test.csv")
fakeNews <- bind_rows(train=fakeNews.train, test=fakeNews.test,
                      .id="Set")
CleanNews <- vroom::vroom("/Users/LysLysenko/Desktop/Kaggle/FakeNews/CleanFakeNews.csv")

###############
## Exploring ##
###############

mean(fakeNews.train$label)
xtabs(data = CompNews, ~isFake + language.x)

################
## Formatting ##
################

fakeNews <- fakeNews %>%
  mutate(Id = id) %>%
  select(-id)
CleanNews$isFake <- as.factor(CleanNews$isFake)

############################################
## Create a Text & Title Length Variables ##
############################################

for(i in 1:nrow(fakeNews)) {
  fakeNews$TextLength[i] <- ngram::wordcount(x = fakeNews$text[i], sep = " ", count.function = sum)
  fakeNews$TitleLength[i] <- ngram::wordcount(x = fakeNews$title[i], sep = " ", count.function = sum)
}

##############################
## Combine Needed Variables ##
##############################

CleanNews <- left_join(CleanNews, fakeNews %>% select(Id, TextLength, TitleLength, author), by="Id")
write_csv(CleanNews, "/Users/LysLysenko/Desktop/Kaggle/FakeNews/CompNews.csv")










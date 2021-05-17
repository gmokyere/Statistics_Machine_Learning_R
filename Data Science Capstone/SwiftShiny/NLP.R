
## Text cleaning
library(stringr)
library("tidytext")

## For messy data cleaning
library(dplyr)
library(tidyverse)
## Visualization
library(ggplot2)
library("wordcloud") # word-cloud generator 
library(plotly)

######################################################## Data

bigram_50 <- readRDS("bi_words.rds")
trigram_50 <- readRDS("tri_words.rds")
quadgram_50 <- readRDS("quad_words.rds")

######################################################## Prediction
bigram_pred<- function(input_words){
   num <- length(input_words)
   filter(bigram_50, 
          word1==input_words[num]) %>% 
      top_n(1, n) %>%
      filter(row_number() == 1L) %>%
      select(num_range("word", 2)) %>%
      as.character() -> out
   ifelse(out =="character(0)", "Check spelling (invalid)", return(out))
}

trigram_pred <- function(input_words){
   num <- length(input_words)
   filter(trigram_50, 
          word1==input_words[num-1], 
          word2==input_words[num])  %>% 
      top_n(1, n) %>%
      filter(row_number() == 1L) %>%
      select(num_range("word", 3)) %>%
      as.character() -> out
   ifelse(out=="character(0)", bigram_pred(input_words), return(out))
}

quadgram_pred <- function(input_words){
   num <- length(input_words)
   filter(quadgram_50, 
          word1==input_words[num-2], 
          word2==input_words[num-1], 
          word3==input_words[num])  %>% 
      top_n(1, n) %>%
      filter(row_number() == 1L) %>%
      select(num_range("word", 4)) %>%
      as.character() -> out
   ifelse(out=="character(0)", trigram_pred(input_words), return(out))
}

#------------------------------------------------------------
ngrams <- function(input){
   # Create a dataframe
   input <- data.frame(text = input)
   # Clean the Inpput
   replace_reg <- "[^[:alpha:][:space:]]*"
   input <- input %>%
      mutate(text = str_replace_all(text, replace_reg, ""))
   # Find word count, separate words, lower case
   input_count <- str_count(input, boundary("word"))
   input_words <- unlist(str_split(input, boundary("word")))
   input_words <- tolower(input_words)
   # Call the matching functions
   out <- ifelse(input_count == 1, bigram_pred(input_words), 
                 ifelse (input_count == 2, trigram_pred(input_words), quadgram_pred(input_words)))
   # Output
   return(out)
}

## Put separated columns into one word using "unite" function in dplyr
topn <- 20
top_10_bigrams <- bigram_50 %>% filter(n > n[topn]) %>%
                   unite(word, c(word1, word2), sep = " ") %>%
                  mutate(word = reorder(word, n))

top_n_trigrams <- trigram_50 %>% filter(n > n[topn], n < n[1]) %>%
   unite(word, c(word1, word2, word3), sep = " ") %>%
   mutate(word = reorder(word, n))




### GGplot of bigram top20
gg1 <- ggplot(top_10_bigrams) +
   aes(x = word, fill = n, weight = n) +
   geom_bar() +
   scale_fill_gradient() +
   labs(x = "Words", y = "Counts", title = "Most Frequent words in bigram") +
   coord_flip() +
   theme_dark() 
gg1

gg2 <- ggplot(top_n_trigrams) +
   aes(x = word, fill = n, weight = n) +
   geom_bar() + coord_flip() +
   scale_fill_distiller(palette = "PRGn") +
   labs(x = "Words", y = "Counts", title = "Most Frequent words in Tri-gram") +
   theme_gray()

gg2

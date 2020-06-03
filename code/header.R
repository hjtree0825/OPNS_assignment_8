#options(error=utils::recover)

my.library <- '/Users/swnam/Google Drive/code/R/library'
.libPaths(my.library)

library('tidyverse')
c('reshape2', 'stringr', 'magrittr', 'doParallel') %>%
  walk(~library(., character.only=TRUE))

setwd('/Volumes/GoogleDrive/My Drive/Kellogg/02. Second year/2020-Spring/523-0. Estimation of Dynamic programs/HW07/code/')

dir('modules') %>% 
  walk(~source(paste('./modules/', ., sep="")))

registerDoParallel(cores=28)
library(tidyverse)

data <- read_csv("data/merged.csv")
library(boot)

getmatmeddiff <- function(data, indices) {
  sample_data <- data[indices, ]
  group_meds <- tapply(sample_data$maternalMor, sample_data$conflict, FUN = function(x) median(x,na.rm=TRUE))
  meddiff <- group_meds[2] - group_meds[1]
  return(meddiff)
}

getinfmeddiff <- function(data, indices) {
  sample_data <- data[indices, ]
  group_meds <- tapply(sample_data$infantMor, sample_data$conflict, FUN = function(x) median(x,na.rm=TRUE))
  meddiff <- group_meds[2] - group_meds[1]
  return(meddiff)
}

getun5meddiff <- function(data, indices) {
  sample_data <- data[indices, ]
  group_meds <- tapply(sample_data$under5Mor, sample_data$conflict, FUN = function(x) median(x,na.rm=TRUE))
  meddiff <- group_meds[2] - group_meds[1]
  return(meddiff)
}

getneomeddiff <- function(data, indices) {
  sample_data <- data[indices, ]
  group_meds <- tapply(sample_data$neonatalMor, sample_data$conflict, FUN = function(x) median(x,na.rm=TRUE))
  meddiff <- group_meds[2] - group_meds[1]
  return(meddiff)
}

data %>% filter(year==2017)->data2017

set.seed(1)
matbootout <- boot(data2017, statistic = getmatmeddiff, strata = data2017$conflict, R = 1000)
infbootout <- boot(data2017, statistic = getinfmeddiff, strata = data2017$conflict, R = 1000)
un5bootout <- boot(data2017, statistic = getun5meddiff, strata = data2017$conflict, R = 1000)
neobootout <- boot(data2017, statistic = getneomeddiff, strata = data2017$conflict, R = 1000)

boot.ci(boot.out = matbootout, conf = 0.95, type = c("basic", "perc", "bca"))
boot.ci(boot.out = infbootout, conf = 0.95, type = c("basic", "perc", "bca"))
boot.ci(boot.out = un5bootout, conf = 0.95, type = c("basic", "perc", "bca"))
boot.ci(boot.out = neobootout, conf = 0.95, type = c("basic", "perc", "bca"))

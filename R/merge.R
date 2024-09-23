library(tidyverse)
covariates <- read_csv("original/covariates.csv")
source("R/mortality.R",TRUE)
source("R/disaster.R",TRUE)
source("R/conflict.R",TRUE)
colnames(covariates)[4] <- "Year"
merged <- reduce(list(allmor,disaster,conflict,covariates),full_join,by=c("Year","ISO"))
write_csv(merged,"data/merged.csv")

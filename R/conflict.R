library(tidyverse)
conflict <- read_csv("original/conflictdata.csv")
conflict$conflict <- ifelse(is.na(conflict$conflict_id), 0,1)
conflict %>% select(-conflict_id) %>% group_by(year,ISO) %>% 
  summarize(have_conflict = max(conflict)) -> conflict
conflict$year <- conflict$year + 1
colnames(conflict)[1] <- "Year"
write_csv(conflict, "data/conflict.csv")

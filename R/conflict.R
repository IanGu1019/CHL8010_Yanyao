library(tidyverse)
conflict <- read_csv("original/conflictdata.csv")
conflict <- conflict %>% group_by(ISO,year) %>% 
  summarize(death = sum(best)) %>% 
  mutate(conflict = ifelse(death < 25, 0, 1)) %>% mutate(year = year + 1)
write_csv(conflict, "data/conflict.csv")

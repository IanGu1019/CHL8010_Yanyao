library(tidyverse)
disaster <- read_csv("original/disaster.csv")
disaster %>% filter(Year>=2000 & Year<=2019) %>% 
  filter(`Disaster Type`=="Earthquake" |`Disaster Type`=="Drought") %>% 
  select(Year,ISO,`Disaster Type`) -> disaster
disaster$drought <- ifelse(disaster$`Disaster Type`=="Drought",1,0)
disaster$earthquake <- ifelse(disaster$`Disaster Type`=="Earthquake",1,0)
disaster %>% group_by(Year,ISO) %>% summarize(drought=max(drought),earthquake=max(earthquake))->disaster
write_csv(disaster,"data/disaster.csv")

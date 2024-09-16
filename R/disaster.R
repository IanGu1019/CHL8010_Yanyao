library(tidyverse)
disaster <- read_csv("original/disaster.csv")
disaster %>% filter(Year>=2000 & Year<=2019) %>% 
  filter(`Disaster Type`=="Earthquake" |`Disaster Type`=="Drought") %>% 
  select(Year,ISO,`Disaster Type`) -> data
data$drought <- ifelse(data$`Disaster Type`=="Drought",1,0)
data$earthquake <- ifelse(data$`Disaster Type`=="Earthquake",1,0)
data %>% group_by(Year,ISO) %>% summarize(drought=max(drought),earthquake=max(earthquake))->data1
write_csv(data1,"data/disaster_processed")

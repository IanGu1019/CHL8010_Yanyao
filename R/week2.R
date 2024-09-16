library(readr)
library(tidyverse)
data <- read_csv("original/maternalmortality.csv")
data %>% 
  select(Country.Name,X2000:X2019) %>% 
  pivot_longer(X2000:X2019,names_prefix = "X",names_to = "Year",
               values_to = "MatMor") -> data1
data1$Year <- as.numeric(data1$Year)
write_csv(data1,"data/data.csv")

library(usethis)
usethis::use_git_config(user.name = "IanGu1019", user.email = "yanyaogu@gmail.com")
use_github()

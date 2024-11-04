library(tidyverse)
covariates <- read_csv("original/covariates.csv")
source("R/mortality.R",TRUE)
source("R/disaster.R",TRUE)
source("R/conflict.R",TRUE)

merged <- reduce(list(conflict, allmor, disaster),
                 full_join,by=c("ISO", "year"))
merged <- left_join(covariates, merged, by = c("ISO", "year"))
merged %>% mutate(conflict = replace_na(conflict, 0),
                  drought = replace_na(drought, 0),
                  earthquake = replace_na(earthquake, 0),
                  death = replace_na(death, 0),
                  lgdp1000 = log(gdp1000)) -> merged
write_csv(merged,"data/merged.csv")

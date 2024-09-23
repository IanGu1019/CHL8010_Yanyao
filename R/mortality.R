library(readr)
library(tidyverse)
maternal <- read_csv("original/maternalmortality.csv")
infant <- read_csv("original/infantmortality.csv")
neonatal <- read_csv("original/neonatalmortality.csv")
under5 <- read_csv("original/under5mortality.csv")

modifydata <- function(x){
  name <- deparse(substitute(x))
  x %>% select(`Country Name`, "2000":"2019") %>% 
    pivot_longer("2000":"2019",names_to = "Year", 
                 values_to = paste0(name,"Mor")) -> x
  x$Year <- as.numeric(x$Year)
  return(x)
}

maternal_mod <- modifydata(maternal)
infant_mod <- modifydata(infant)
neonatal_mod <- modifydata(neonatal)
under5_mod <- modifydata(under5)

allmor <- reduce(list(maternal_mod, infant_mod, neonatal_mod, under5_mod), 
                 full_join, by = c("Country Name", "Year"))

library(countrycode)
allmor$ISO <- countrycode(allmor$`Country Name`,
                          origin = "country.name",
                          destination = "iso3c")
allmor <- select(allmor, -`Country Name`)
write_csv(allmor,"data/allmortality.csv")

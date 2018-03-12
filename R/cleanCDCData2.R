
library(tidyverse)
library
proj_path <- "/Users/tomharned/DeathsInTheUSA"

importCDC <- function(file_path, out_dir){
  #insert functions here
}

cleanCDC <- function(df, ...){
  names(df) <- gsub(" ", "_", names(df))
    df %>%
    filter(is.na(Notes) == T) %>% 
    select(-Notes) %>%
    mutate(Population = as.numeric(Population),
           # Create a seperate Race Category for Hispanics
           Race = ifelse(Hispanic_Origin == "Hispanic or Latino", "Hispanic", Race)) %>%
    group_by_(.dots = lazyeval::lazy_dots(...)) %>% 
    summarize(Deaths = sum(Deaths, na.rm=T),
              Population = sum(Population, na.rm=T))
}



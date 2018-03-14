
require(tidyverse)


importCDC <- function(){
  list_of_files <- list.files('./Input Data/', include.dirs = F, pattern = "\\.txt$")
  list_of_dfs <- purrr::map(.x = paste0('Input Data/', list_of_files), .f = ~read_tsv(.x))
  names(list_of_dfs) <- c("ByGender", "ByState", "ByRace")
  list_of_dfs
  list2env(list_of_dfs, .GlobalEnv)
}


cleanCDC <- function(df, ...){
  names(df) <- gsub(" |-", "_", names(df))
    
  df <- df %>%
    filter(is.na(Notes) == T) %>% 
    select(-Notes) %>%
    mutate(Population = as.numeric(Population)) 
    
    if("Race" %in% names(df)){
     df$Race <-  ifelse(df$Hispanic_Origin == "Hispanic or Latino", 
                        "Hispanic or Latino", df$Race)
    } 
    
    df %>%
    group_by_(.dots = lazyeval::lazy_dots(...)) %>% 
    summarize(Deaths = sum(Deaths, na.rm=T),
              Population = sum(Population, na.rm=T))
}

outputCleanFile <- function(df, out_file_name){
                      write.csv(df, 
                      file = paste0('./Input Data/derived_data/', out_file_name, '.csv'),
                      row.names = F)
}

##### Execute Functions #####
importCDC()

ByGender %>% 
  cleanCDC(Year, Gender, Race) %>% outputCleanFile(out_file_name = "ByGender")

 
ByRace %>% 
  cleanCDC(Year, Ten_Year_Age_Groups, Race) %>% 
  outputCleanFile(out_file_name = "ByRace")


ByState %>% 
  cleanCDC(State, `2013_Urbanization`, Year) %>% 
  outputCleanFile(out_file_name = "ByState")

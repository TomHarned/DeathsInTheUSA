
library(tidyverse)

proj_path <- "/Users/tomharned/DeathsInTheUSA"

all_gen_file <- 'Input Data/DataSet1_SuicideByYearByGenderByRace.txt'



all_gen_df <- read_tsv(all_gen_file)

names(all_gen_df) <- gsub(" ", "_", names(all_gen_df))

# Isolate the source notes
notes_all_gen <- all_gen_df %>% filter(is.na(Notes) == F & Notes != 'Total') %>% select(Notes)

# Isolate Just the data
all_gen_data <- all_gen_df %>% filter(is.na(Notes) == T) %>% select(-Notes)

save(all.)

plot_by_year <-   all_gen_data %>% 
                  select(Year, Deaths, Gender) %>%
                  group_by(Year, Gender) %>%
                  summarize(Deaths = sum(Deaths, na.rm=T)) %>%
                  ggplot(., aes(x=Year, y=Deaths, color=Gender)) +
                  #geom_line() +
                  geom_point()
print(plot_by_year)

options("device")

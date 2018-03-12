install.packages("devtools")
library(devtools)
install_github("socdataR/wonderapi")
devtools::install_github("socdataR/wonderapi", build_vignettes = TRUE)

# Quick start guide here: https://rdrr.io/github/socdataR/wonderapi/f/README.md#overview
library(dplyr)
library(ggplot2)
library(tidyr)
library(wonderapi)

mylist <- list(list("B_1", "Gender"), 
               list("V22", 2))

mydata0 <- getData(TRUE, "Detailed Mortality", mylist)
mydata0 %>% head()


mylist2 <- list(list("Month", "2"))
getData(TRUE, "D66", mylist2)

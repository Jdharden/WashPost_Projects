library (tidyverse)
library (ggplot2)
library (tidyr)
library (dplyr)
library (readr) 

dc_rats <- read.csv ("2018_311 Rodent Calls.csv", stringsAsFactors=FALSE, na.strings="#VALUE!", header = TRUE)

head(dc_rats)
summary(dc_rats)
str(dc_rats)

ggplot ( data = dc_rats ) + 
geom_point ( mapping = aes ( x = LATITUDE , y = LONGITUDE, color = WARD))
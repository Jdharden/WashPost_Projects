---
title: "HUBZone Code -- Re Run"
author: "John D. Harden"
date: "January 8, 2019"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## R Markdown

Anaylsis of the HUBZone program database for Washington, DC. Data was obtained/scraped from www.fpds.gov, https://usaspending.gov, HUBZone federal office. Data reveals an uneven distribution of dollars throughout the district, a notable finding considering that the point of the program was level the playing field for underserved District communities. 

```{r message=FALSE, warning=FALSE}
#Federal HUBZone Program Analysis
#loading libraries 
library (tidyverse)
library (reshape)
library(knitr)
library(rmarkdown)
library(lubridate)

# loading data
HUBZoneRaw <- read_csv("HUBZone_Raw.csv", 
                       col_types = cols(action_date = col_date(format = "%m/%d/%Y")))
options(stringsAsFactors = FALSE)


```

The sum of all the federal dollars secured in DC since the HUBZone program was implemented. 

```{r dollars, echo=TRUE}
sum(HUBZoneRaw$federal_action_obligation)
```
Analyzing the top 11 firms using parent duns -- names of firms are messy. Top 11 firms secured nearly $800 million over the course of the program.  

```{r top 11, echo=TRUE, warning=FALSE}
# parse year                       
HUBZoneRaw$HUB_Year <- format(as.Date(HUBZoneRaw$action_date), "%Y")     

firms_total <- group_by(HUBZoneRaw, recipient_parent_duns) %>%
  summarise(total_contracts = sum(federal_action_obligation)) %>%
  arrange(desc(total_contracts))

top11 <- head(firms_total, 11)

top11

```

Top 11 firms have secured about 70 percent of the total federal dollars awarded. 

```{r percent, echo=TRUE}
                      
sum(top11$total_contracts) / sum(firms_total$total_contracts)

```

Ward analysis --  Wards one, four, five, seven and eight contain some of the most underserved communities in the nation’s capital, accounting for more than 80 percent of the city’s HUBZones. But those five wards have won less than 30 percent of the federal dollars awarded through HUBZone contracts. 

```{r percent_1, echo=TRUE}
                      
#group by ward
ward_amount <- group_by(HUBZoneRaw, WARD) %>%
  summarise(total_contracts = sum(federal_action_obligation )) %>%
  arrange(desc(total_contracts))

ward_amount

```


```{r percent_2, echo=TRUE}
                      
#percentage of awards by ward

---
output:
  word_document: default
  html_document: default
---
```{r, echo=FALSE}
knitr::opts_chunk$set(error = TRUE)
```

---
title: "HUBZone report"
author: "John D. Harden"
date: "11/8/2018"
output:
  html_document: default
  pdf_document: default
---

```{r echo=TRUE}
library (tidyverse)
library (ggplot2)
library (tidyr)
library (dplyr)
library (readr) 
library (reshape)
library(pivottabler)
library(knitr)
library(rmarkdown)

FPDS_HUB_Database <- read.csv("Complete_FPDS_DC_HUB_Database.csv", stringsAsFactors=FALSE, na.strings="#VALUE!", header = TRUE)

```

## R Markdown

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:

```{r echo=TRUE}
head(FPDS_HUB_Database)
str(FPDS_HUB_Database)
summarize(FPDS_HUB_Database)
glimpse(FPDS_HUB_Database)

vendors <- FPDS_HUB_Database %>% group_by(Vendor.Name) %>%
  summarise(
    AvgContract = mean(Action.Obligation...., na.rm = TRUE), 
    MedianContract = median(Action.Obligation...., na.rm = TRUE),
    TotalContract = sum(Action.Obligation...., na.rm = TRUE),
  )  %>%
  top_n(30)

```

```{r echo=TRUE}

str(vendors) 
```



## Including Plots

```{r echo=TRUE}
library(ggplot2)

Table <- ggplot(vendors, aes(x = TotalContract, y = reorder(Vendor.Name, TotalContract)  )) +
  geom_point() +
  labs( x = "Contract Amounts", y = "Vendors")
```



```{r echo=TRUE}
Table
```{r echo=TRUE}

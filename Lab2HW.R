library(tidyverse)
library(tidyr)

#load data

coverage<-read.csv("~/Downloads/coverage2.csv", skip = 2, header = TRUE,stringsAsFactors = FALSE)
expenditure<-read.csv("~/Downloads/expenditures02.csv",skip = 2, header = TRUE, stringsAsFactors = FALSE)

coverage<-coverage[1:52]
coverage<-coverage[1:52]

#tidy coverage data

coverage_cleaned<-coverage %>%
  gather(key=location,value=case,index = 2:29,na.rm=TRUE) %>%
  separate(location,into=c("Year","Cases"),sep="__",convert=TRUE) %>%
  arrange(Year,Cases)

for (i in 1:1580){
  coverage_cleaned$Year[i] = substr(coverage_cleaned$Year[i], 2,5)
}

names(coverage_cleaned) <- c("Location", "Year", "Type", "Value")

#tidy expenditure data

expenditure_cleaned<-expenditure %>%
  gather(key=location,value=cases,index = 2:25,na.rm=TRUE) %>%
  separate(location,into=c("Year","Cases"),sep="__") %>%
  arrange(Year,Cases)

for (i in 1:1248){
  expenditure_cleaned$Year[i] = substr(expenditure_cleaned$Year[i], 2,5)
}

names(expenditure_cleaned) <- c("Location", "Year", "Type", "Value")

## MERGE DATA

HealthCare <- rbind(coverage_cleaned,expenditure_cleaned,by=c("Location","Year"))
HealthCare$Year <- as.numeric(HealthCare$Year)
HealthCareSub <- subset(HealthCare,Year>=2013)

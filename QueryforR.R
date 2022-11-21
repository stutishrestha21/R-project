library(dplyr)
library(tidyverse)
library(readxl)
library(lubridate)

rm(list = ls())

setwd("~/Desktop/Data 331/QueryForR")


course<- read_excel('Course.xlsx',.name_repair = "universal")
registration <- read_excel('Registration.xlsx',.name_repair = "universal")
student<- read_excel('Student.xlsx',.name_repair = "universal")

#make all data in the same table
all_df<- student %>%
  left_join(registration, by = c("Student.ID"))%>% #using foreign keys
  left_join(course, by = c("Instance.ID"))

compSciStudent <- all_df%>%
  dplyr::filter(Title == "Computer Science")

PaymentPlans <-all_df%>%
  dplyr::filter(Payment.Plan == "TRUE")

FirstQuarterClass <- all_df%>%
  dplyr::filter(Start.Date>= "2021-08-01" & End.Date<="2021-12-29")

TotalBalanceByPlan <- all_df%>%
  dplyr::filter(Payment.Plan == "TRUE")%>%
  dplyr::group_by(Payment.Plan)%>% #we want payment plan colum
  dplyr::summarise(Balance.Due = sum(Balance.Due))# sum in the end by balance

TotalCostByMajor <- all_df%>%
  dplyr::group_by(Title)%>% #we want title column
  dplyr::summarise(Total.Cost = sum(Total.Cost)) #we want to summarise by the total cost


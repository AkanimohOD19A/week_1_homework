## Load Dependencies
library(tidyverse)
library(data.table)

## Wrangle
setwd("C:/Users/buasc/OneDrive/Documents/temp_deng_homework")

df <- read.csv("green_tripdata_2019-09.csv")
dir_df <- read.csv("green_taxi_dir.csv")

hw_1 <- df %>% 
  mutate_at(vars(lpep_pickup_datetime, lpep_dropoff_datetime), as.Date) %>% 
  filter(lpep_pickup_datetime == '2019-09-18' & lpep_dropoff_datetime == '2019-09-18') %>% 
  group_by(lpep_pickup_datetime, lpep_dropoff_datetime) %>% 
  summarise(count = n())

##>    lpep_pickup_datetime lpep_dropoff_datetime count
# <date>               <date>                <int>
#   1 2019-09-18           2019-09-18            15612

hw_2 <- df %>% 
  mutate_at(vars(lpep_pickup_datetime, lpep_dropoff_datetime), as.Date) %>% 
  group_by(lpep_pickup_datetime) %>% 
  summarise(td_sum = sum(trip_distance)) %>% 
  arrange(desc(td_sum)) %>% 
  slice(1)

##> # A tibble: 50 × 2
# lpep_pickup_datetime td_sum
# <date>                <dbl>
#   1 2019-09-26           58760.

hw_4 <- df %>% 
  mutate_at(vars(lpep_pickup_datetime, lpep_dropoff_datetime), as.Date) %>% 
  filter(year(lpep_pickup_datetime) == 2019 & 
           month(lpep_pickup_datetime) == 9 ) %>% 
  group_by(PULocationID,DOLocationID) %>% 
  summarise(tas = sum(tip_amount)) %>% 
  arrange(desc(tas)) %>% 
  filter(PULocationID == 7)
  
  

## Export
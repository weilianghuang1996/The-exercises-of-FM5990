## Load all the libraries that you will need.
library(readr)
library(dplyr)
library(arules)

## Read in the data from CSVs.
df_occ <- readr::read_csv("data_occ_201808.csv")
df_etf <- readr::read_csv("data_etf_list.csv")
View(df_etf)
View(df_occ)

## Create a monthly volume report.
df_monthly_volume <- df_occ %>% group_by(underlying) %>% 
  summarise(monthly_volume = sum(quantity)) %>% 
  arrange(desc(monthly_volume))


## Look at df_etfs and examine the segment column. 

## Look for clues about whether the fund is volatility related.
 dplyr::filter(df_etf, segment %pin% c("volatility"))
# dplyr::filter(df_occ, underlying %in% c("SPY", "QQQ", "IWM", "DIA"))
# subset(df_etf, segment %pin% c("volatility"))
# dplyr::filter(df_etf, grep("volatility", df_etf$segment, value=T))
# subset(df_etf$segment, grepl("volatility"))
df_vol_etfs <- filter(df_etf, str_detect(df_etf$segment, "volatility"))

## Convert segment column of df_etfs to all lowercase letters.
df_etf$segment <- base::tolower(df_etf$segment)


## Isolate volatility etfs into a dataframe called df_vol_etfs.
df_vol_etfs <- filter(df_etf, str_detect(df_etf$segment, "volatility"))

## Create a list of top 100 most liquid non-volatility ETFs.
## Call it df_top_100.
df_top_100 <- df_etf %>% arrange(spread) %>% filter(!(segment %in% df_vol_etfs$segment) & between(row_number(), 1, 100)) 



## Create a dataframe consisting of the distinct by the df_top_100 symbols?
grouped <- df_top_100 %>% distinct(segment)
  



## Come up with a meaningful grouping of these segments.
class(df_etf$expense_ratio)
lapply(df_top_100$expense_ratio, function(x) as.numeric(sub("%", "", x))/100)


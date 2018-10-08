library(dplyr)
library(readr)

#Read in this data set using readr::read_csv(). Load it into a dataframe called df_options_intro.
df_options_intro <- readr::read_csv("G:/FM5990/data_options_intro.csv")
# Prove to yourself that this code will work weather you use readr::read_csv() or simply read_csv(). Why might you want to use one versus the other?
# 
df_options_intro1 <- read_csv("G:/FM5990/data_options_intro.csv")
#   Use $ notation to grab the strike column and print it to the console. Do the same for implied_vol as well as ask_price.
print(df_options_intro$strike)
print(df_options_intro$implied_vol)
print(df_options_intro$ask)

# Use nrow() to determine how many rows are in df_options_intro.
nrow(df_options_intro)
# Take a look at df_options_intro using View(). Confirm that nrow() produced the correct value.
View(df_options_intro)
# What is the expiration date of all the options? Which date are these prices from?
df_options_intro$expiration
#   Use dplyr::distinct() to determine how many different underlyings are represented in the data. What are they?
df_options_intro %>% dplyr::distinct(underlying)

#   Use dplyr::filter() along with variable assignment <- to create four sub-dataframes, each of which consists of all of the options for one underlying. Call these dataframes df_SPY, df_QQQ, df_IWM, df_DIA. (For each iteration, type out the code from scratch. This will be good typing practice that will make you more efficient in the future.)
df_SPY <- dplyr::filter(df_options_intro, underlying == 'SPY')
df_QQQ <- dplyr::filter(df_options_intro, underlying == 'QQQ')
df_IWM <- dplyr::filter(df_options_intro, underlying == 'IWM')
df_DIA <- dplyr::filter(df_options_intro, underlying == 'DIA')
# For each of the underlyings, use ggplot2::qplot() to create a line graph with strike on the x-axis and implied_vol on the y-axis.
df_options_intro %>% ggplot2::qplot(strike,implied_vol)
qplot(strike, implied_vol, data=df_options_intro)

help(qplot)
library(ggplot2)
View(df_options_intro)
ggplot2::qplot(strike, )

ggplot2::qplot(df_options_intro$strike,df_options_intro$implied_vol)
# What is the relationship between strike and implied_vol for these underlyings?
#   
#   Let’s break down df_SPY a little further. Using dplyr::filter() create two sub-dataframes, one consisting of all the puts and one consisting of all the calls. Label them df_SPY_puts and df_SPY_calls, respectively.
df_SPY_puts <- dplyr::filter(df_SPY, type == 'put')
df_SPY_calls <- dplyr::filter(df_SPY, type == 'call')

# How many puts are there? How many calls are there? What are there so many more puts? (Hint: remember that options are insurance contracts and that SPY is an ETF that tracks the S&P 500.)
nrow(df_SPY_calls)
nrow(df_SPY_puts)

# For both df_SPY_calls and df_SPY_puts create a graph with strike on x-axis and bid_price.
ggplot2::qplot(df_SPY_calls$strike,df_SPY_calls$bid)
ggplot2::qplot(df_SPY_puts$strike,df_SPY_puts$bid)
# Based on the graphs you created above: for puts, what is the relationship between strike and price, assuming we hold the price of the underlying fixed? How about for calls?

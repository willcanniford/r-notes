Betting Simulations
================

Load the relevant packages that I will be using during these simple
simulations.

``` r
library(tidyverse)
library(reshape2)
```

There are a lot of systems out there for trying to make betting a
consistent and reliable process. Something that is, inherently, neither
of those things.

Below I define a simulator function that defines a number of basic
parameters that can start you off in simulating how betting methods
would work if applied over a number of individual bets.

``` r
simulator <- function(starting_bank = 10, 
                      n_bet = 20, 
                      stake_proportion = 0.25, 
                      odds_range = c(1.6, 1.8), 
                      win_perc = 50){
  # Loop through n_bet and simulate the result
  bank = starting_bank;
  bank_tracker = c(bank)
  
  for(i in 1:n_bet) {
    # Pick a random odd between the range defined
    odds <- sample(seq(odds_range[1], odds_range[2], 0.01), 1)
    chance <- sample(1:100, 1)
    
    # Did they win that particular bet? 
    if(chance <= win_perc){
      bank = round((bank * (1 - stake_proportion)) + (bank * stake_proportion * odds), 2)
      stake <- bank * stake_proportion
      winnings <- (bank * stake_proportion * odds)
      print(paste("Won bet ", i, ": ", bank, sep = "" ))
    } else {
      bank = round(bank * (1 - stake_proportion), 2)
      print(paste("Lost bet ", i, ": ", bank, sep = "" ))
    }
    bank_tracker = c(bank_tracker,  bank)
  }
  return(bank_tracker)
}
```

*starting\_bank*: the amount of money that you are starting with.  
*n\_bet*: the number of bets you would like to simulate.  
*stake\_proportion*: the proportion of your bank you’re staking on each
bet (constant).  
*odds\_range*: the range of odds that you’re betting on.  
*win\_perc*: the average win percentage within the odds range.

``` r
set.seed(100)
simulator()
```

    ## [1] "Won bet 1: 11.65"
    ## [1] "Won bet 2: 13.72"
    ## [1] "Won bet 3: 16.09"
    ## [1] "Won bet 4: 19.19"
    ## [1] "Won bet 5: 22.6"
    ## [1] "Lost bet 6: 16.95"
    ## [1] "Won bet 7: 19.7"
    ## [1] "Lost bet 8: 14.77"
    ## [1] "Won bet 9: 17.13"
    ## [1] "Lost bet 10: 12.85"
    ## [1] "Lost bet 11: 9.64"
    ## [1] "Lost bet 12: 7.23"
    ## [1] "Won bet 13: 8.46"
    ## [1] "Lost bet 14: 6.35"
    ## [1] "Won bet 15: 7.48"
    ## [1] "Lost bet 16: 5.61"
    ## [1] "Lost bet 17: 4.21"
    ## [1] "Lost bet 18: 3.16"
    ## [1] "Lost bet 19: 2.37"
    ## [1] "Won bet 20: 2.84"

    ##  [1] 10.00 11.65 13.72 16.09 19.19 22.60 16.95 19.70 14.77 17.13 12.85
    ## [12]  9.64  7.23  8.46  6.35  7.48  5.61  4.21  3.16  2.37  2.84

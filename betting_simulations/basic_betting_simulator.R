# Load in the relevant packages
library(tidyverse)
library(reshape2)

simulator <- function(starting_bank = 10, n_bet, stake_proportion, odds_range = c(1.6, 1.8), win_perc) {
  # Loop through n_bet and simulate the result
  bank = starting_bank;
  bank_tracker = c(bank)
  
  for(i in 1:n_bet) {
    odds <- sample(seq(odds_range[1], odds_range[2], 0.01), 1)
    chance <- sample(1:100, 1)
    if(chance <= win_perc){
      bank = round((bank * (1 - stake_proportion)) + (bank * stake_proportion * odds), 2)
      stake <- bank * stake_proportion
      winnings <- (bank * stake_proportion * odds)
      print(paste("Won bet ", i, ": ", bank, sep = "" ))
    } else {
      bank = round(bank * 0.75)
      print(paste("Lost bet ", i, ": ", bank, sep = "" ))
    }
    bank_tracker = c(bank_tracker,  bank)
  }
  return(bank_tracker)

}


# Set up multiple trials 
perms <- 30
trials <- 25
results_frame <- matrix(ncol = trials, nrow = (perms + 1))

for(i in 1:trials){
  results <- unlist(simulator(starting_bank = 25, n_bet = perms, stake_proportion = 0.20, odds_range = c(1.4, 1.6), win_perc = 70))
  results_frame[,i] <- results
}
results_frame

new_results <- as.data.frame(results_frame)
new_results[,"count"] <- seq(1:(perms+1))

ggplot(data = new_results, aes(x=count)) + geom_line(aes(y=V1)) + geom_line(aes(y=V2)) + geom_line(aes(y=V3)) + geom_line(aes(y=V4)) + geom_line(aes(y=V5)) + geom_line(aes(y=V6)) + geom_line(aes(y=V7)) + geom_line(aes(y=V8)) + geom_line(aes(y=V9)) + geom_line(aes(y=V10)) + 
  geom_hline(yintercept = 25, colour = "red")
new_results[,1]
p <- ggplot()
for(i in 1:25){
  results <- new_results[,i]
  p <- p + geom_line(data = new_results, aes(x = count, y=results))
}
p


long_results <- melt(new_results, id.vars = "count")


profitable <- long_results %>% filter(count == 31) %>% mutate(profit = value > 25) %>% filter(profit == TRUE) %>% select(variable)
test_results <- long_results %>% mutate(profit = variable %in% profitable$variable)

ggplot(data = test_results) + geom_line(aes(x=count, y=value, group=variable, colour=profit))

outcomes <- c("Win", "Lose")
sample(outcomes, replace = TRUE, prob = c(.7, .3), size = 25)

probability_matrix = data.frame(EVENT = c("Win", "Lose"), PROBABILITY = c(.7,.3), PAYOUT = c(1.5, 0))
simulate <- rmultinom(prob = probability_matrix$PROBABILITY, n = 1000, size = 10)*probability_matrix$PAYOUT
table(apply(simulate, sum, MARGIN = 2) > 10)
hist(simulate[1,])

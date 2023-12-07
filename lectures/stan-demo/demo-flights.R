library(rjson)
library(rstan)
library(lubridate)
library(ggplot2)
options(mc.cores = parallel::detectCores())

setwd("~/Teaching/bsda/lectures/stan-demo")

# Read in data
flights = read.csv('flights.csv')
flights_arrived <- c(flights$arr)
res <- hm(flights_arrived)
arrival_minutes <- hour(res) * 60 + minute(res)

# Format data correctly for stan
train_dat <- list(y_hours=hour(res), y_minutes=minute(res), N=length(minute(res)),
                  nominal_hours=9, nominal_minutes=15)
train_dat

# Sample from posterior
fit1 <- stan(file = "flights.stan", data=train_dat, chains=16)
fit1


# Extract samples
samples <- extract(fit1)

# Calculate predictive interval
interval_size <- 0.9
predictive_interval <- quantile(samples$y_sim, c((1-interval_size)/2, 1-(1-interval_size)/2))
predictive_interval
lower <- predictive_interval[1]
upper <- predictive_interval[2]

# Format as hours and minutes
sprintf("Lower %s:%02d", floor(lower), floor((lower - floor(lower))*60) )
sprintf("Upper %s:%02d", floor(upper), floor((upper - floor(upper))*60) )


# Plot predictive histogram
df <- data.frame(samples)
ggplot(df, aes(x = y_sim)) +
  geom_histogram(aes(y = ..density..),
                 colour = 1, fill = "white") +
  geom_density(lwd = 1, colour = 4,
               fill = 4, alpha = 0.25) +
  xlim(c(lower-1, upper + 1))



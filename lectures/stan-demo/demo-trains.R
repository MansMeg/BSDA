library(rjson)
library(rstan)
library(lubridate)
library(ggplot2)
options(mc.cores = parallel::detectCores())

setwd("~/Teaching/bsda-with-solutions/lectures/stan-demo")

# Read in data
trains = read.csv('trains.csv')
trains_duration <- c(trains$duration)
res <- hm(trains_duration)

# Format data correctly for stan
data <- list(y_hours=hour(res), y_minutes=minute(res), N=length(minute(res)),
                  seminar_hours=10, seminar_minutes=00, departure_hours=8, departure_minutes=15)
data

# Sample from posterior
fit1 <- stan(file = "trains.stan", data=data, iter=4000, chains=4)
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



library(rjson)
library(rstan)
library(lubridate)
library(ggplot2)
options(mc.cores = parallel::detectCores())

setwd("~/Teaching/bsda/lectures/stan-demo")

# Format data correctly for stan
train_dat <- list(n1=674-39,m1=39, n2=680-22, m2=22)
train_dat

# Sample from posterior
fit1 <- stan(file = "binomial.stan", data=train_dat, chains=8, iter=16000)
fit1

# Extract samples
samples <- extract(fit1)

# Calculate predictive interval
interval_size <- 0.95
credible_interval <- quantile(samples$ratio, c((1-interval_size)/2, 1-(1-interval_size)/2))
credible_interval
lower <- credible_interval[1]
upper <- credible_interval[2]

# Format as hours and minutes
sprintf("mu %.3f", mean(samples$ratio))
sprintf("CI [%.3f , %.3f]", lower, upper)
ratio_stdev <-  sqrt(var(samples$ratio))

# Plot theta1
df <- data.frame(samples)
ggplot(df, aes(x = ratio)) +
  geom_histogram(aes(y = ..density..),
                 colour = 1, fill = "white") +
  geom_density(lwd = 1, colour = 4,
               fill = 4, alpha = 0.25) +
  xlim(c(lower-ratio_stdev, upper+ratio_stdev))

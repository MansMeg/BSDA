library(rjson)
library(rstan)
library(lubridate)
library(ggplot2)
options(mc.cores = parallel::detectCores())

setwd("~/Teaching/bsda/lectures/stan-demo")

# Format data correctly for stan
steps <- c(5498,6596, 6951,6347)

train_dat <- list(y=steps, N=length(steps))
train_dat

# Sample from posterior
fit1 <- stan(file = "normal.stan", data=train_dat, chains=16, iter=8000)
fit1

# Extract samples
samples <- extract(fit1)

# Calculate predictive interval
interval_size <- 0.9
credible_interval <- quantile(samples$mu, c((1-interval_size)/2, 1-(1-interval_size)/2))
credible_interval
lower <- credible_interval[1]
upper <- credible_interval[2]

# Format as hours and minutes
sprintf("mu %.1f", mean(samples$mu))
sprintf("CI [%.1f , %.1f]", lower, upper)


# Plot mu
stdev <- mean(samples$sigma)
df <- data.frame(samples)
ggplot(df, aes(x = mu)) +
  geom_histogram(aes(y = ..density..),
                 colour = 1, fill = "white") +
  geom_density(lwd = 1, colour = 4,
               fill = 4, alpha = 0.25) +
  xlim(c(lower-stdev, upper + stdev))

# Plot sigma
upper_sigma <- quantile(samples$sigma, 0.98)
ggplot(df, aes(x = sigma)) +
  geom_histogram(aes(y = ..density..),
                 colour = 1, fill = "white") +
  geom_density(lwd = 1, colour = 2,
               fill = 2, alpha = 0.25) +
  xlim(c(0, upper_sigma))

# Heatmap
ggplot(df, aes(x = mu, y=sigma)) +
  stat_density_2d(aes(fill = stat(density)), geom = 'raster', contour = FALSE) +
  scale_fill_viridis_c() +
  coord_cartesian(expand = FALSE) +
  xlim(c(lower-stdev, upper + stdev)) + ylim(c(0, upper_sigma))


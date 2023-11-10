library(rstanarm); library(loo); library(tidyverse)


#### Preparing data and models ####

music <- read.csv("music.csv")                      # Imports data
df <- music[1:1000, -c(3, 5, 7, 8, 9, 13, 22, 34)]  # Removing weird/categorical variables


y <- df |> select(song.hotttnesss)  # Outcome variable
x <- df |> select(-song.hotttnesss) # Regressors

# For simplicty, I just sample 5 candidate models, all using 7 covariates. This is not recommended,
# and in practice you should choose relevant candidates. You can use the model comparison tools
# taught during the course to find a set of good models to combine.
candidates <- lapply(X = 1:5, FUN = function(x){sample(1:26, size = 7, replace = FALSE) |> sort()})

#### Fitting the model ####

mod_fit <- function(candidate, y, x){ # Function for fitting candidate models
  reg_dat <- cbind(y, x[, candidate]) # Data frame on the form needed by formula()
  stan_glm(formula(reg_dat), data = reg_dat, refresh = 0) # Fits the linear model
}

fitted_candidates <- lapply(X = candidates, FUN = mod_fit, # Fits all five candidates
                            y = y, x = x) 

#### Performing cross-validation and estimating weights ####
cv <- lapply(X = fitted_candidates, FUN = loo)             # LOO-CV approximation for candidates
lpd_point <- sapply(X = cv, FUN = function(x){x$pointwise[,"elpd_loo"]}) # Pointwise LOO ELPD

weights <- stacking_weights(lpd_point) # Estimates the (log-score) weights


#### Sampling from the stacked posterior ####

# Test data
df_eval <- music[1001:1100, -c(3, 5, 7, 8, 9, 13, 22, 34)]  # Removing weird/categorical variables
y_eval <- df_eval |> pull(song.hotttnesss)    # Outcome variable
x_eval <- df_eval |> select(-song.hotttnesss) # Regressors

# Samples models using weights as probabilities
sample_index <- sample(x = 1:5, size = 4000, replace = TRUE, prob = weights)

# Samples from the posterior predictive
post_sample <- sapply(X = sample_index, FUN = function(x, cand, x_eval){
  y_pred <- posterior_predict(cand[[x]], x_eval, draws = 1)},
  cand = fitted_candidates, x_eval = x_eval)

# Histogram of stacked posterior predictive of two observations
post_sample |> t() |> as.tibble() |> ggplot() +
  geom_density(mapping = aes(x = V1), col = "red", linewidth = 1) +
  geom_density(mapping = aes(x = V3), col = "forestgreen", linewidth = 1) +
  theme_bw()

# Stacked posterior means and evaluation
stacked_predictions <- rowMeans(post_sample)
((y_eval - stacked_predictions)^2) |> mean() |> sqrt()


# Evaluates the candidate models
sapply(X = fitted_candidates, FUN = function(x, x_eval, y_eval){
  y_pred <- posterior_predict(x, x_eval, draws = 1) |> rowMeans()
  ((y_eval - y_pred)^2) |> mean() |> sqrt()},
  x_eval = x_eval, y_eval = y_eval)





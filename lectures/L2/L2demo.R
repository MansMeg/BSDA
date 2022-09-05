#' ---
#' title: "Bayesian data analysis  - L2 demo"
#' author: "Mans Magnusson"
#' date: "`r format(Sys.Date())`"
#' ---
library(ggplot2)
theme_set(bayesplot::theme_default(base_family = "sans", base_size=16))

#' # Binomial model, Beta posterior
logit <- function(x) log(x/(1-x))

x <- rbeta(100000, 6 + 1, 10 - 6 + 1)
qplot(x)
qplot(logit(x))
mean(x)
mean(x < 0.5)
pbeta(0.5, 6 + 1, 10 - 6 + 1)


x <- rbeta(100000, 438, 544)
qplot(x)
mean(x < 0.485)

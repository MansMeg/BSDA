#' ---
#' title: "Bayesian data analysis - L4"
#' author: "Mans Magnusson"
#' date: "`r format(Sys.Date())`"
#' ---
library(ggplot2)
theme_set(bayesplot::theme_default(base_family = "sans", base_size=16))

#' # Underflow

x <- rnorm(600)
qplot(x)
prod(dnorm(x)) # 0 due to underflow
sum(dnorm(x, log = TRUE))

pbeta(0.5, 241945, 251527)
pbeta(0.5, 241945, 251527, log.p = TRUE)



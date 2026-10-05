# Run from lectures/L7 to regenerate the corrected rat comparison figures.
# Model and data: BDA3, Section 5.3; Aki Vehtari's BDA demo 5.1:
# https://avehtari.github.io/BDA_R_demos/demos_ch5/demo5_1.html
library(ggplot2)

y <- c(0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,
       2,1,5,2,5,3,2,7,7,3,3,2,9,10,4,4,4,4,4,4,4,10,4,4,4,5,11,12,
       5,5,6,5,6,6,6,6,16,15,15,9,4)
n <- c(20,20,20,20,20,20,20,19,19,19,19,18,18,17,20,20,20,20,19,19,18,18,
       25,24,23,20,20,20,20,20,20,10,49,19,46,27,17,49,47,20,20,13,48,50,
       20,20,20,20,20,20,20,48,19,19,19,22,46,49,20,20,23,19,22,20,20,20,
       52,46,47,24,14)
highlight <- 71L
selected <- c(seq(7L, 70L, by = 7L), highlight)
stopifnot(length(y) == 71L, length(n) == 71L, all(y <= n),
          y[highlight] == 4L, n[highlight] == 14L,
          highlight %in% selected)

hyperposterior_grid <- function(n_mean, n_concentration, max_concentration) {
  grid <- expand.grid(
    logit_mean = seq(-5, 0, length.out = n_mean),
    log_concentration = seq(log(0.05), log(max_concentration),
                            length.out = n_concentration)
  )
  concentration <- exp(grid$log_concentration)
  a <- plogis(grid$logit_mean) * concentration
  b <- (1 - plogis(grid$logit_mean)) * concentration

  # Include the Jacobian alpha * beta for this transformed integration grid.
  log_density <- -2.5 * grid$log_concentration + log(a) + log(b)
  for (j in seq_along(y)) {
    log_density <- log_density + lbeta(a + y[j], b + n[j] - y[j]) - lbeta(a, b)
  }
  weights <- exp(log_density - max(log_density))
  weights <- weights / sum(weights)
  keep <- weights > 1e-12
  stopifnot(sum(weights[!keep]) < 1e-7)
  data.frame(a = a[keep], b = b[keep], w = weights[keep] / sum(weights[keep]))
}

hyper <- hyperposterior_grid(181L, 241L, 1e5)
check_grid <- hyperposterior_grid(271L, 361L, 1e6)
posterior_means <- function(grid) {
  c(new_group = sum(grid$w * grid$a / (grid$a + grid$b)),
    experiment_71 = sum(grid$w * (grid$a + y[highlight]) /
                          (grid$a + grid$b + n[highlight])))
}
stopifnot(max(abs(posterior_means(hyper) - posterior_means(check_grid))) < 1e-4)

theta <- seq(1e-5, 1 - 1e-5, length.out = 1001L)
mixture_density <- function(successes, trials) {
  vapply(theta, function(value) {
    sum(hyper$w * dbeta(value, hyper$a + successes, hyper$b + trials - successes))
  }, numeric(1))
}
separate <- vapply(seq_along(y), function(j) {
  dbeta(theta, y[j] + 1, n[j] - y[j] + 1)
}, numeric(length(theta)))
hierarchical <- vapply(selected, function(j) mixture_density(y[j], n[j]),
                       numeric(length(theta)))
new_group <- mixture_density(0, 0)

trapezoid <- function(values) sum(diff(theta) *
                                  (head(values, -1) + tail(values, -1)) / 2)
stopifnot(abs(trapezoid(new_group) - 1) < 0.005,
          max(abs(apply(hierarchical, 2, trapezoid) - 1)) < 0.005,
          abs(trapezoid(theta * new_group) - posterior_means(hyper)[1]) < 1e-4,
          abs(trapezoid(theta * hierarchical[, ncol(hierarchical)]) -
                posterior_means(hyper)[2]) < 1e-4)

plot_theme <- theme_classic(base_size = 16) +
  theme(axis.line.y = element_blank(), axis.ticks.y = element_blank(),
        plot.title = element_text(size = 18),
        plot.subtitle = element_text(size = 13),
        plot.margin = margin(8, 10, 4, 8))

comparison_plot <- function(densities, groups, title, ymax) {
  data <- data.frame(theta = rep(theta, length(groups)),
                     density = as.vector(densities),
                     experiment = rep(groups, each = length(theta)))
  ggplot(data, aes(theta, density, group = experiment)) +
    geom_line(data = subset(data, experiment != highlight),
              colour = "blue", alpha = 0.6, linewidth = 0.45) +
    geom_line(data = subset(data, experiment == highlight),
              colour = "red", linewidth = 0.75) +
    annotate("text", x = 0.99, y = Inf, hjust = 1, vjust = 1.2,
             label = "Experiment 71 (4/14)", colour = "red", size = 4.2) +
    annotate("text", x = 0.99, y = Inf, hjust = 1, vjust = 2.8,
             label = "Other experiments", colour = "blue", size = 4.2) +
    labs(title = title, subtitle = "Existing-group posteriors",
         x = expression(theta[j]), y = NULL) +
    scale_x_continuous(limits = c(0, 1), breaks = seq(0, 1, by = 0.25)) +
    scale_y_continuous(limits = c(0, ymax), breaks = NULL,
                       expand = expansion(mult = c(0, 0.12))) +
    plot_theme
}

shared_ymax <- max(separate[, selected], hierarchical)
ggsave("figs/rats_separate.pdf",
       comparison_plot(separate, seq_along(y), "Separate model", max(separate)),
       width = 6, height = 4, useDingbats = FALSE)
ggsave("figs/rats_separate_less.pdf",
       comparison_plot(separate[, selected], selected, "Separate model", shared_ymax),
       width = 6, height = 3, useDingbats = FALSE)
ggsave("figs/rats_hier_less.pdf",
       comparison_plot(hierarchical, selected, "Hierarchical model", shared_ymax),
       width = 6, height = 3, useDingbats = FALSE)

predictive_plot <- ggplot(data.frame(theta, density = new_group), aes(theta, density)) +
  geom_line(colour = "forestgreen", linewidth = 0.75) +
  labs(title = "New group's probability",
       subtitle = expression("Posterior predictive " ~ p(theta[new] ~ "|" ~ y)),
       x = expression(theta[new]), y = NULL) +
  scale_x_continuous(limits = c(0, 1), breaks = seq(0, 1, by = 0.25)) +
  scale_y_continuous(breaks = NULL, expand = expansion(mult = c(0, 0.12))) +
  plot_theme
# Retain the existing asset name; this is posterior predictive, not a prior.
ggsave("figs/rats_hierprior.pdf", predictive_plot,
       width = 6, height = 3, useDingbats = FALSE)

print(posterior_means(hyper))
cat("Validated grid refinement, density normalization, and experiment 71 highlighting.\n")

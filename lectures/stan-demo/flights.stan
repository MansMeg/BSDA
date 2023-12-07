
data {
  // Data on arrival time
  int<lower=0> N;
  vector[N] y_hours;
  vector[N] y_minutes;
  
  // Planned arrival
  real nominal_hours;
  real nominal_minutes;
}

// Convert time to real number
transformed data {
  vector[N] y = y_hours * 60.0 + y_minutes;
}

parameters {
  // mean in minutes
  real mu;
  real<lower=0> sigma;
}


transformed parameters {
  // mean in hours
  real mu_hours = mu / 60.0;
}

model {
  y ~ normal(mu, sigma);
}

// posterior predictive ~y
generated quantities {
  real y_sim;
  int on_time_to_lecture;
  y_sim = normal_rng(mu, sigma) / 60;
  on_time_to_lecture = y_sim < 9.5;
}

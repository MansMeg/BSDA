
data {
  // Data on arrival time
  int<lower=0> N;
  vector[N] y_hours;
  vector[N] y_minutes;
  
  // Planned arrival
  real departure_hours;
  real departure_minutes;

  real seminar_hours;
  real seminar_minutes;
}

// Convert time to real number
transformed data {
  vector[N] y = y_hours + y_minutes / 60.0;
}

parameters {
  // mean in minutes
  real mu;
  real<lower=0> sigma;
}

model {
  mu ~ normal(1.0, 2.0);
  sigma ~ exponential(0.5);
  y ~ lognormal(mu, sigma);
}


// posterior predictive ~y
generated quantities {
  real y_sim;
  real y_sim_minutes;
  int on_time_to_seminar;

  real arrival_sim;
  y_sim = lognormal_rng(mu, sigma);
  y_sim_minutes = y_sim * 60;

  arrival_sim = departure_hours + departure_minutes / 60.0 + y_sim;
  on_time_to_seminar = arrival_sim < seminar_hours + seminar_minutes / 60.0;
}

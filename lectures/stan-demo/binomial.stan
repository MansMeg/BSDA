data {
  int<lower=0> n1;
  int<lower=0> m1;
  int<lower=0> n2;
  int<lower=0> m2;
}

parameters {
  real<lower=0.0, upper=1.0> theta1;
  real<lower=0.0, upper=1.0> theta2;
}

model {
  theta1 ~ beta(3,1);
  theta2 ~ beta(3,1);
  n1 ~ binomial(n1 + m1, theta1);
  n2 ~ binomial(n2 + m2, theta2);
}


generated quantities {
  real or1 = theta1 / (1 - theta1);
  real or2 = theta2 / (1 - theta2);
  
  real ratio = or1 / or2;
}
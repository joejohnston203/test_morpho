/*
* MC morpho testing model
* -------------------------------------------------------------------
* Author: Mathieu Guigue <mathieu.guigue@pnnl.gov>
*
* Date: March 17 2017
*
* Purpose:
*
* Generic and simple linear model for testing
*
*/

functions{
  real shape3(int x) {return 0.1;}
}

data{
  int Nsignals;
  int signalsLen;
  int boundsLen;
  real signals[Nsignals, signalsLen];
  real bounds[Nsignals, boundsLen];
  int nBins;
  real shape1[nBins];
  vector[nBins] shape2;
  real shape4[nBins];
  int fake_data[nBins];
}

transformed data{}

parameters{
  real<lower=bounds[1][1], upper=bounds[1][2]> sig1;
  real<lower=bounds[2][1], upper=bounds[2][2]> sig2;
  real<lower=bounds[3][1], upper=bounds[3][2]> sig3;
  real<lower=bounds[4][1], upper=bounds[4][2]> sig4;
}

transformed parameters {
  vector[nBins] n_counts_recon;
  for(i in 1:nBins){
    n_counts_recon[i] = sig1*shape1[i] + sig2*shape2[i] + sig3*shape3(i) + sig4*shape4[i];
  }
}


model{
  for(i in 1:nBins){
    target += poisson_lpmf(fake_data[i] | n_counts_recon[i]);
  }
}

generated quantities{}

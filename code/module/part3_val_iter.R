val_update <- function(ccp, param_vec){
  ccp %>%
    mutate(
      prob_1p = prob_1,
      prob_0p = prob_0,
      f = param_vec$theta[1]*s - param_vec$theta[2]*x + param_vec$beta*(log(prob_1) + log((1 - prob_1)))
    )%>%
    group_by(s) %>%
    mutate(
      f = f - f[1],           # normalize by subtracting the first value
      prob_1 = 1/(1+exp(f)),  # calculate CCP's separately
      prob_0 = 1/(1+exp(-f)), # calculate CCP's separately
      delta_p1 = prob_1 - prob_1p, # not used
      delta_p0 = prob_0 - prob_0p  # not used
    )
}

val_iter <- function(ccp, val_tol, param_vec){
  delta <- 100
  while (delta > val_tol){
    ccp <- val_update(ccp, param_vec)
    delta <- max(abs(ccp$prob_1 - ccp$prob_1p))
    ccp <- ccp %>%
      select(s, x, prob_1, prob_0)
  }
  return(ccp) # Just to make sure
}

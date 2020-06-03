#####Notes
#Use %T>% to save intermediary result
#Use sample_n to sample by likelihood: calculate the likelihood only once
#If you simulate each person individually, your code will take hours.
#Sum across mileage levels to express the data in most parsimonious fashion
##########

sim_data <- function(l, num.obs = 10^6) { #Create simulation data
  l %>% 
    calc_value_function %T>% 
    saveRDS('./variables/value_fn.rds') %>% 
    calc_csv(l) %>% 
    calc_log_ccp %>%
    calc_log_duration_prob %>% 
    inner_join(l$intercepts) %>% 
    mutate(prob = pi.s * exp(log.like)) %>% 
    sample_n(
      size = num.obs, 
      weight = prob, 
      replace = TRUE
    ) %>% 
    count(s, x)
}
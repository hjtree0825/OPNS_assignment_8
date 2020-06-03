sumlogccp <- function(df, param_vec, val_tol){
  df %>%
    rbind(c(1, max(filter(., s == 1)$x) + 1, 1)) %>% # add a row for s = 1
    rbind(c(2, max(filter(., s == 2)$x) + 1, 1)) %>% # add a row for s = 2
    group_by(s) %>%
    mutate(
      prop = n/sum(n), # reduced-form of CCP (?)
      prob_1 = cumsum(lag(prop, default = min(prop), order_by = x)), # cumulative prob
      prob_0 = 1 - prob_1
    ) %>%
    ungroup() %>%
    arrange(s,x) %>%
    select(s, x, prob_1, prob_0) %>%
    val_iter(., val_tol, param_vec) %>% # value iteration
    mutate(
      log_ccp1 = log(prob_1),
      log_ccp0 = log(prob_0)
    ) %>% # take the log
    group_by(s) %>% 
    mutate(log.like = log_ccp1 + cumsum(lag(log_ccp0, default = 0, order_by = x))) %>%
    #mutate(sumlogccp_val = sum(log_ccp)) %>% # sum of log(CCP)
    select(s, log.like) %>%
    #select(s, sumlogccp_val) %>%
    distinct() %>%
    ungroup()
}
source('header.R')

# parameters
param_vec <- list(
  theta = c(5, 0.01),
  intercepts = 
    tibble(
      s = c(1, 2),
      pi.s = c(.25, .75)
    ),
  beta = .99
)
val_tol <- 10^(-6)
eps <- 10^(-3)           # not used for this assignment
x_max <- ceiling(1/param_vec$theta[2]*(param_vec$theta[1]*max(param_vec$intercepts$s) - log(1/(1-eps)-1))) # not used for this assignment

param_vec %>% 
  sim_data %T>% 
  saveRDS('../variables/sim_data.rds') %>% 
  sumlogccp(df = ., param_vec = param_vec, val_tol = val_tol)

df <- readRDS("../variables/sim_data.rds")
df %>% 
  sumlogccp(df = ., param_vec = param_vec, val_tol = val_tol) %>% 
  print(., n=nrow(.))

optim(par = c(5, 0.01), fn = sumlogccp, control = list(maxit = 1000), method = "L-BFGS-B", lower = c(0,0))
# We just realized that the "function" in the optim function should
# probably have only one input at the last minute before submission.

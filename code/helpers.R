cv <- function(data, fit, K = nrow(data), rmse.cv = FALSE) {
  
  # assign data to folds
  data$.i <- make_sets(nrow(data), K)

  # compute mse for each fold
  mses <- vector(mode = "numeric", length = K)
  if (rmse.cv) {
    FUN <- rmse
  } else {
    FUN <- mse
  }
  for(k in 1:K) {
    train <- data[data$.i != k, ]
    test <- data[data$.i == k, ]
    temp <- update(fit, data = train)
    mses[k] <- mse(temp, test)
  }
    
  mean(mses, na.rm = TRUE)
}

mse <- function(mod, data = NULL) {
  
  if (is.null(data)) return(mean(resid(mod)^2))
  
  if (is.data.frame(data)) {
    response <- eval(as.list(formula(mod))[[2]], env = data)
  } else if (is.vector(data)) {
    response <- data
  } else stop("data must be a vector or data frame")
  
  sqerror <- (response - predict(mod, data))^2
  if(all(is.na(sqerror))) return(NA)
  mean(sqerror, na.rm = TRUE)
}

rmse <- function(mod, data = NULL) sqrt(mse(mod, data))

make_sets <- function(n , k) {
  if ((k > n) || (k <= 1)) 
        stop("'K' outside allowable range")
  if (k == n)
        return(1:k)
  
  m <- ceiling(n / k)
  sample(rep(1:k, m)[1:n])
}

boot.coef <- function(data, mod, coef.n = 2) {
  n <- nrow(data)
  samp <- data[sample(1:n, n, replace = TRUE), ]
  update(mod, data = samp)$coefficients[coef.n]
}
  
    
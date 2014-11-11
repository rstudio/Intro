## 04-Complex-Relationships
library(ggplot2)
library(dplyr)
library(leaps)
library(mgcv)

cts <- read.csv("data/counties.csv",   
   stringsAsFactors = FALSE)

# Variable selection

# Theory driven

# Data driven

# heights <- read.csv("data/heights.csv")
# hmod <- lm(earn ~ height, data = wages)
AIC(hmod)
BIC(hmod)
summary(hmod)$adj.r.squared

library(leaps)
subs <- regsubsets(earn ~ ., data = wages)

summary(subs)

summary(subs)$adjr2
summary(subs)$cp
summary(subs)$bic

df <- data.frame(
  est = c(summary(subs)$adjr2, summary(subs)$cp, 
    summary(subs)$bic),
  x = rep(1:7, 3),
  type = rep(c("adjr2", "cp", "bic"), each = 7)
)

qplot(x, est, data = df, geom = "line") + 
  theme_bw() + facet_grid(type ~ ., scales = "free_y")

coef(subs, 3)

# Your Turn
# ----------------------------------
regsubsets(crime ~ ., data = cts)
# ----------------------------------

start.mod <- lm(earn ~ height, data = wages)
empty.mod <- lm(earn ~ 1, data = wages)
full.mod <- lm(earn ~ ., data = wages)

step(start.mod, 
  scope = list(upper = full.mod,
               lower = empty.mod),
  direction = "forward")

# Your Turn
# ----------------------------------
cts2 <- select(cts, -state, -county) 
start <- lm(crime ~ pop, data = cts2)
full <- lm(crime ~ ., data = cts2)
empty <- lm(crime ~ 1, data = cts2)
bounds <- list(upper = full, lower = empty)

step(start, bounds,  direction = "forward")
step(start, bounds,  direction = "backward")
step(start, bounds,  direction = "both")
# ----------------------------------

cts3 <- cts2[1:110, ] 
start <- full <- lm(crime ~ pop, data = cts3)
full <- lm(crime ~ ., data = cts3)
empty <- lm(crime ~ 1, data = cts3)
bounds <- list(upper = full, lower = empty)

step(start, bounds,  direction = "forward")
step(start, bounds,  direction = "backward")
step(start, bounds,  direction = "both")


# Penalized regression

# Variable Selection Recap

# Non-linear relationships

# Transformations

qplot(carat, price, data = diamonds)

qplot(log(carat), log(price), data = diamonds)

# Your Turn
# ---------------------------------
mod <- lm(log(price) ~ log(carat), data = diamonds)
summary(mod)
# ---------------------------------

qplot(age, earn, data = wages) + geom_smooth() + coord_cartesian(ylim = c(0, 75000))

# Polynomials 

mod <- lm(earn ~ poly(age, 3), data = wages)

summary(mod)

qplot(age, earn, data = wages) + 
  geom_smooth(method = lm, formula = y ~ poly(x, 3)) +   
  coord_cartesian(ylim = c(0, 75000))

mod1 <- lm(earn ~ age, data = wages)
mod2 <- lm(earn ~ poly(age, 2), data = wages)
mod3 <- lm(earn ~ poly(age, 3), data = wages)
anova(mod1, mod2, mod3)

# Splines

library(splines)
mod <- lm(earn ~ ns(age, knots = c(40, 60)), 
  data = wages)

mod <- lm(earn ~ ns(age, df = 4), 
  data = wages)

# Your Turn
# -----------------------------------------
lm(earn ~ ns(age, df = 6), data = wages)

qplot(age, earn, data = wages) + 
  geom_smooth(method = lm, formula = y ~ ns(x, df = 6)) +  
  coord_cartesian(ylim = c(0, 75000))
# -----------------------------------------

# Smoothing functions

# Your Turn
# -----------------------------------------
library(mgcv)
gmod <- gam(earn ~ s(height), data = wages)
# -----------------------------------------


# Logistic Regression

titanic3 <- read.csv("data/titanic3.csv", stringsAsFactors = FALSE)
View(titanic3)

qplot(age, survived, data = titanic3) + geom_smooth(se = FALSE)

# Your Turn
# ---------------------------------------------
options(na.action = "na.exclude")
gmod <- gam(survived ~ s(age), data = titanic3, 
  family = binomial)
summary(gmod)
# ---------------------------------------------

predict(gmod)
predict(gmod, type = "link")
fitted(gmod)
predict(gmod, type = "response")

# Your Turn
# ----------------------------------
qplot(age, survived, data = titanic3) +
  geom_smooth(se = FALSE) +
  geom_line(aes(y = fitted(gmod)), color = "red")
# -----------------------------------

resid(g)
resid(gmod, type = "deviance")
resid(gmod, type = "pearson")
## 03-Linear Models
library(ggplot2)
library(dplyr)

options(stringsAsFactors = FALSE)
wages <- read.csv("data/wages.csv")
crime <- read.csv("data/crime.csv")

# Estimating a function

mod <- lm(tc2009 ~ low, data = crime)

tc2009 ~ low
class(tc2009 ~ low)

mod

names(mod)

summary(mod)
predict(mod)
resid(mod)

coef(mod)
coefficients(mod)

qplot(low, predict(mod), data = crime, geom = "line")

qplot(low, tc2009, data = crime) + 
  geom_smooth(method = lm)

qplot(low, tc2009, data = crime) +
  geom_smooth(se = FALSE, method = lm)

lm(tc2009 ~ 1 + low, data = crime)
lm(tc2009 ~ low, data = crime)
lm(tc2009 ~ low - 1, data = crime)
lm(tc2009 ~ 0 + low, data = crime)

# Your Turn
# ---------------------------------------
hmod <- lm(earn ~ height, data = wages)
coef(hmod)
# ---------------------------------------

qplot(height, earn, data = wages, alpha = I(1/4)) +
  geom_smooth(se = FALSE, method = lm) + theme_bw()

earn ~ heights
mod <- lm(earn ~ heights, data = wages)
summary(mod)
plot(mod)

# Model Inference

w1 <- read.csv("data/w1.csv")
qplot(height, earn, data = w1) +
  geom_smooth(method = lm, se = F)

# Parametric

summary(hmod)

confint(hmod, level = 0.95)

# Your Turn
# ---------------------------------------
mod <- lm(tc2009 ~ low, data = crime)
summary(mod)
# ---------------------------------------

qplot(low, tc2009, data = crime)
qplot(height, earn, data = wages)

plot(mod)

# Comparing multiple groups

# Your Turn
# ---------------------------------------
rmod <- lm(earn ~ race, data = wages)
coef(rmod)
# ---------------------------------------

wages$race <- factor(wages$race, 
  levels = c("hispanic", "white", "black", "other"))
rmod2 <- lm(earn ~ race, data = wages)
coef(rmod2)

anova(rmod2)

# Your Turn
# ---------------------------------------
smod <- lm(earn ~ sex, data = wages)
coef(smod)

wages$sex <- factor(wages$sex, 
  levels = c("male", "female"))
smod <- lm(earn ~ sex, data = wages)
coef(smod)
anova(smod)
# ---------------------------------------

qplot(earn, data = wages, geom = "density", color = sex) + theme_bw()

qplot(earn, data = wages, geom = "density", color = race) + theme_bw()


# Estimating multivariate functions

m1 <- lm(earn ~ height, data = wages)
m2 <- lm(earn ~ height + sex, data = wages)

coef(m1)
coef(m2)

qplot(height, earn, data = wages, alpha = I(1/10), color = sex) + theme_bw() + geom_line(aes(y = predict(m2)))

# Your Turn
# ---------------------------------------
diamonds$cut <- as.character(diamonds$cut)

d1 <- lm(price ~ cut, data = diamonds)
coef(d1)
d2 <- lm(price ~ cut + carat, data = diamonds)
coef(d2)
# ---------------------------------------

qplot(carat, predict(mod.a), data = diamonds, 
  color = cut, geom = "line")

# Your Turn
# ---------------------------------------
m3 <- lm(earn ~ height + sex + race + ed + age, 
  data = wages)
coef(m3)
# ---------------------------------------

lm(earn ~ ., data = wages)

lm(earn ~ height + sex + race + ed + age, data = wages)
lm(earn ~ ., data = wages)

lm(earn ~ height + sex + race + ed, data = wages)
lm(earn ~ . - age, data = wages)


# Interaction terms

m4 <- lm(earn ~ height + sex + height:sex, 
   data = wages)

coef(m4)

lm(earn ~ height + sex + height:sex, data = wages)
lm(earn ~ height * sex, data = wages)

# Your Turn
# ---------------------------------------
mod.a <- lm(price ~ carat + cut, data = diamonds)
summary(mod.a)
mod.b <- lm(price ~ carat * cut, data = diamonds)
summary(mod.b)
# ---------------------------------------

qplot(carat, predict(mod.a), data = diamonds, color = cut, geom = "line")

qplot(carat, predict(mod.b), data = diamonds, color = cut, geom = "line")

lm(earn ~ height + sex + height:sex, data = w1)
lm(earn ~ height * sex, data = w1)
lm(earn ~ (height + sex)^2, data = w1)

lm(earn ~ (height + sex + race)^3, data = w1)

# Inference for multivariate regression

cor(wages$height, wages$ed)
cor(wages$height, wages$age)
cor(wages$height, as.numeric(wages$sex))

summary(m4)

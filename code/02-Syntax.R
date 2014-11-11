## 02-Syntax.R
# Code from 02-subsetting
# library(ggplot2)

x <- c(0, 0, 0, 0, 1, 0 ,0)
y <- x
y

# Subsetting

vec <- c(6, 1, 3, 6, 10, 5)
df <- data.frame(
  name = c("John", "Paul", "George", "Ringo"),
  birth = c(1940, 1942, 1943, 1940), 
  instrument = c("guitar", "bass", "guitar", "drums")
)

df[2,3]
df[c(2,4),c(2,3)]
df[c(2,4),3]

1:4 
df[1:4, 1:2]
df[c(1,1,1,2,2), 1:3]

vec[0]
df[1:2, 0]

vec[c(5, 6)]
vec[-c(5, 6)]

df[c(2:4), 2:3]
df[-c(2:4), 2:3]
df[-c(2:4),-(2:3)]

vec(1:4)
vec[-1:4]
df[c(1,2)]

vec[ ]
df[1, ]
df[ ,2]

names(vec) <- c("a","b","c","d","e","f")
vec[c("a","b","d")]
vec[c("a","c","f")]

df[ ,"birth"]
df[ ,c("name","birth")]

vec[c(FALSE,TRUE,FALSE,TRUE,TRUE,FALSE)]

df[c(FALSE,TRUE,TRUE,FALSE), ]

# Your Turn
# ---------------------------------------
df[1, 1]
df[1, "name"]
df[1, -(2:3)]
df[1, c(TRUE, FALSE, FALSE)]
df[-(2:4), 1]
df[-(2:4), "name"]
df[-(2:4), -(2:3)]
df[-(2:4), c(TRUE, FALSE, FALSE)]
df[c(TRUE, FALSE, FALSE, FALSE), 1]
df[c(TRUE, FALSE, FALSE, FALSE), "name"]
df[c(TRUE, FALSE, FALSE, FALSE), -(2:3)]
df[c(T, F, F, F), c(T, F, F)]
# ---------------------------------------

# Your Turn
# ---------------------------------------
lst <- list(c(1, 2), TRUE, c("a", "b", "c"))
sum(c(1,2,3))
# sum(lst[1])
# ---------------------------------------

lst[c(1,2)]
lst[1]
lst[[1]]

lst[[1]][2]

names(lst) <- c("alpha", "beta", "gamma")
lst$alpha

df$birth

# Your turn
# --------------------------
# install.packages(c("ggplot2", "hexbin", "maps", "mapproj","RColorBrewer", "scales"))
library("ggplot2")
library("hexbin")
library("maps")
library("mapproj")
library("RColorBrewer")
library("scales")
# --------------------------


# Diamonds

# Your turn
# --------------------------
diamonds[1:6, ]
nrow(diamonds)
diamonds[53935:53940, ]
# --------------------------

head(diamonds)
tail(diamonds)

View(diamonds)

?diamonds

qplot(x, y, data = diamonds)

# Logical tests

1 < 3
1 > 3
c(1, 2, 3, 4, 5) > 3

# Your Turn
# -------------------
x <- c(1, 2, 3, 4, 5)

x > 3
x >= 3
x < 3
x <= 3
x == 3
x != 3
x = 3
# -------------------

1 %in% c(1, 2, 3, 4)
1 %in% c(2, 3, 4)
c(3,4,5,6) %in% c(2, 3, 4) 

1 %in% c(1, 2, 3, 4)
1 %in% c(2, 3, 4)
c(3,4,5,6) %in% c(2, 3, 4)

x > 2 & x < 9

TRUE & TRUE
TRUE & FALSE
FALSE & TRUE
FALSE & FALSE

TRUE | TRUE
TRUE | FALSE
FALSE | TRUE
FALSE | FALSE

xor(TRUE, TRUE)
xor( TRUE, FALSE)
xor( FALSE, TRUE)
xor( FALSE, FALSE)

!(TRUE)
!(FALSE)

any(c(TRUE, FALSE, FALSE)) 
any(c(FALSE, FALSE, FALSE)) 

all(c(TRUE, TRUE, TRUE)) 
all(c(TRUE, FALSE, TRUE)) 

w <- c(-1, 0, 1)
x <- c(5, 15)
y <- "February"
z <- c("Monday", "Tuesday", "Friday")

# Your Turn
# --------------------------------------------
w > 0
10 < x & x < 20
y == "February"
all(z %in% c("Monday", "Tuesday", "Wednesday", 
  "Thursday", "Friday", "Saturday", "Sunday"))
# --------------------------------------------

# Logical subsetting

x_zeroes <- diamonds$x == 0
diamonds[x_zeroes, ]

# Your Turn
# ------------------------------------
equal_dim <- diamonds$x == diamonds$y
equal <- diamonds[equal_dim, ]
diamonds[diamonds$depth >= 55 & diamonds$depth <= 70, ]
diamonds[diamonds$carat < mean(diamonds$carat), ]
diamonds[diamonds$price / diamonds$carat < 10000, ]
diamonds[diamonds$cut > "Good", ] 
diamonds[diamonds$cut %in% 
  c("Very Good", "Premium", "Ideal"), ]
# ------------------------------------

diamonds[diamonds$x > 10, ]
big <- diamonds[diamonds$x > 10, ]
diamonds <- diamonds[diamonds$x < 10,] 

diamonds <- diamonds[1, 1]
diamonds
rm(diamonds)
str(diamonds)

# Missing values

5 + NA
NA / 2
sum(c(5, NA))
mean(c(5, NA))
NA < 3
NA == 3
NA == NA

a <- c(1, NA)
a == NA
is.na(a)

b <- c(1, 2, 3, 4 NA)
sum(b)
sum(b, na.rm = TRUE)

summary(diamonds$x)
diamonds$x[diamonds$x == 0]
diamonds$x[diamonds$x == 0] <- NA
summary(diamonds$x)

summary(diamonds$y)
diamonds$y[diamonds$y == 0] <- NA
y_big <- diamonds$y > 20
diamonds$y[y_big] <- NA
summary(diamonds$y)

qplot(x, y, data = diamonds)


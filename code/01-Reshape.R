### 01-Reshape.R
# install.packages("reshape2")
# library(reshape2)

## Tidy data

# Values in column names 

raw <- read.csv("/Users/doganfamily/Dropbox/Personal/EDL/PhD/INFO 523/Intro/data/pew.csv", check.names = F)

head(raw)

library(reshape2)
library(tidyverse)
tidy <- melt(raw, id = "religion")

head(raw)
head(tidy)
Tidy_temp <- raw %>% pivot_longer(
  cols = c("<$10k","$10-20k","$20-30k","$30-40k","$40-50k","$50-75k","$75-100k","$100-150k",">150k"),
  names_to = "religion",
  values_to= "Money"
)

head(Tidy_temp)
names(tidy) <- c("religion", "income", "n")
tidy <- melt(raw, id = "religion", 
  variable.name = "income", value.name = "n")

# Variable names in cells

raw <- read.delim("data/weather.txt", check.names = F, na.strings = ".")



# Your Turn
# ------------------------------------------
raw <- melt(raw, 
  id = c("year", "month", "element"),
  variable.name = "day", na.rm = TRUE)
raw$day <- as.numeric(as.character(raw$day))
raw <- raw[, c("year", "month", "day", "element", "value")]
# ------------------------------------------

head(raw)

tidy <- dcast(raw, year + month + day ~ element, 
  value.var = "value")

tidy <- dcast(raw, ... ~ element, value.var = "value")

titanic2 <- read.csv("data/titanic2.csv",
  stringsAsFactors = FALSE)

head(titanic2)

# Your Turn
# ------------------------------------------
tidy <- melt(titanic2, id = c("class", "age", "fate"), 
  variable.name = "gender")
head(tidy)
tidy <- dcast(tidy, class + age + gender ~ fate, 
  value.var = "value")
head(tidy)
titanic$rate <- round(titanic$survived / 
  (titanic$survived + titanic$perished), 2)
head(tidy)
# ------------------------------------------

# Data split across many files

df1 <- data.frame(color = "white", value = c(3, 4))
df2 <- data.frame(color = "blue", value = c(3, 4, 5))
rbind(df1, df2)

df1 <- data.frame(color = "white", value = c(1, 2, 3))
df2 <- data.frame(x = c("a", "b", "c"), n = c(3, 4, 5))
cbind(df1, df2)

# Saving Data

write.csv(tidy, file = "tidy.csv", row.names = FALSE)
saveRDS(tidy, "tidy.rds")
tidy2 <- readRDS("tidy.rds")

write.csv(tidy, file = bzfile("tidy.csv.bz2"), row.names = FALSE)
tidy3 <- read.csv("tidy.csv.bz2")
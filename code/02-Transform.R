### 02-Transform.R
# library(dplyr)
# library(ggplot2)
# library(reshape)

## Baby names data

library(ggplot2)
options(stringsAsFactors = FALSE)
bnames <- read.csv("data/bnames.csv.bz2")
births <- read.csv("data/births.csv")

head(bnames)
tail(bnames)

# Your Turn
# ----------------------------------------------
garrett <- bnames[bnames$name == "Garrett", ]
qplot(year, prop, data = garrett, geom = "line")
# ----------------------------------------------

michael <- bnames[bnames$name == "Michael", ]
qplot(year, prop, data = michael, geom = "line")
qplot(year, prop, data = michael, geom = "point")
qplot(year, prop, data = michael, geom = "line",
  color = sex)

michaels <- bnames[bnames$name == "Michael" | 
                   bnames$name == "Michelle", ]
qplot(year, prop, data = michaels, geom = "line",
  color = interaction(sex, name))

## dplyr

# install.packages("dplyr")
library(dplyr)

bnames <- tbl_df(bnames)
births <- tbl_df(births)
class(bnames)

tbl_df(diamonds)

## filter select mutate summarise arrange

df <- data.frame(color = c("blue", "black", "blue", "blue", "black"), value = 1:5)
tbl <- tbl_df(df)

filter(tbl, color == "blue")
filter(df, value %in% c(1, 4))

# Your Turn
# --------------------------------
garrett <- filter(bnames, name == "Garrett")
garrett$soundex[1]
filter(bnames, soundex == "G630")
filter(bnames, sex == "girl" & (year == 1900 | year == 2000))
dim(filter(bnames, year > 2000 & prop > 0.01))
# --------------------------------

select(tbl, color)
select(df, -color)

# Your Turn
# --------------------------------
select(bnames, soundex)
select(bnames, starts_with("sound"))
select(bnames, ends_with("ex"))
# --------------------------------

arrange(tbl, color)
arrange(tbl, desc(color))

# Your Turn
# --------------------------------
arrange(bnames, desc(prop)) # John in 1880
arrange(garrett, desc(prop)) # 2000
# --------------------------------

mutate(tbl, double = 2 * value)
mutate(tbl, double = 2 * value, quadruple = 2 * double)

summarise(tbl, total = sum(value))
summarise(tbl, total = sum(value), avg = mean(value))

# Your Turn
# --------------------------------
mutate(garrett, perc = prop * 100)
summarise(garrett, 
  min = min(prop),
  mean = mean(prop),
  max = max(prop))
# --------------------------------

## Joining data sets

births

head(bnames)
head(births)

x <- data.frame(
  name = c("John", "Paul", "George", "Ringo", "Stuart", "Pete"), 
  instrument = c("guitar", "bass", "guitar", "drums", "bass", 
     "drums"))
y <- data.frame(
  name = c("John", "Paul", "George", "Ringo", "Brian"), 
  band = c("TRUE", "TRUE", "TRUE",  "TRUE", "FALSE"))

left_join(x, y, by = "name")
inner_join(x, y, by = "name")
semi_join(x, y, by = "name")
anti_join(x, y, by = "name")

# Your Turn
# ----------------------------------------------------
bnames2 <- left_join(bnames, births, by = c("year", "sex"))
bnames2 <- mutate(bnames2, n = prop * births)
bnames2
bnames2 <- mutate(bnames2, n = round(prop * births))
bnames2
# ----------------------------------------------------

bnames2

# Groupwise operations

# Your Turn
# ----------------------------------------------------
garrett <- filter(bnames2, name == "Garrett")
sum(garrett$n)
summarise(garrett, total = sum(n))
# ----------------------------------------------------

summarise(by_name, total = sum(n))

## group_by

summarise(tbl, total = sum(value))
by_color <- group_by(tbl, color)
summarise(by_color, total = sum(value))

group_by(bnames2, name)
by_name <- group_by(bnames2, name)
totals <- summarise(by_name, total = sum(n)) 
totals

group_by(bnames2, name, sex)
by_name <- group_by(bnames2, name)
group_by(by_name, sex)

name_sex <- group_by(bnames2, name, sex)
totals2 <- summarise(name_sex, total = sum(n)) 
totals2

by_name_sex <- group_by(bnames2, name, sex)
ungroup(by_name_sex)

# Your Turn
# ------------------------------------------------------------
by_soundex <- group_by(bnames2, soundex)
stotals <- summarise(by_soundex, total = sum(n)) 
stotals
arrange(stotals, desc(total)) 
j500 <- filter(bnames, soundex == "J500")
unique(j500$name)

year_sex <- group_by(bnames2, year, sex)
ytotals <- summarise(year_sex, births = sum(n))
ytotals
qplot(year, total, data = ytotals, geom = "line", color = sex)

year_sex <- group_by(bnames2, year, sex)
ranks <- mutate(year_sex, rank = rank(desc(prop))
ranks
garrett <- filter(ranks, name == "Garrett")
qplot(year, -rank, data = garrett, geom = "line")
ones <- filter(ranks, rank == 1)
ones <- select(ones, year, name, gender)
ones
library(reshape2)
dcast(ones, year ~ sex, value = “name”)
# ------------------------------------------------------------

name_sex <- group_by(bnames2, name, sex)
name_sex
summary1 <- summarise(name_sex, total = sum(n))
summary1
summary2 <- summarise(summary1, total = sum(total))
summary2
summary3 <- summarise(summary2, total = sum(total))
summary3


# Where next?

browseVignettes(package = "dplyr")
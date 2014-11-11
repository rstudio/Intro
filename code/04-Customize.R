### 04-Customize.R
# install.packages(c("scales", "maps", "RColorBrewer", "ggthemes"))
library(ggplot2)
# library(maps)
# library(scales)
# library(RColorBrewer)
# library(ggthemes)

# Customizing graphics

texas <- read.csv("data/texas.csv")
View(texas)

head(texas)

qplot(long, lat, data = texas)
qplot(long, lat, data = texas, geom = "polygon", group = group)

head(texas)

texas2 <- texas[sample(nrow(texas)), ]  
qplot(long, lat, data = texas2, geom = "polygon", group = group)

library(maps)
counties <- map_data("county")
qplot(long, lat, data = counties, geom = "polygon",
  group = group, fill = group)
help(package = "maps")


# Your Turn
# ------------------------------------------------------
tx <- qplot(long, lat, data = texas, geom = "polygon", 
  fill = bin, group = group)
tx
# ------------------------------------------------------

# Title

tx + ggtitle("Population of Texas Counties")

tx
tx2 <- tx + ggtitle("Population of Texas Counties")
tx2

# Manipulating plots

cp <- qplot(carat, price, data = diamonds)
class(cp)

str(cp)


# Coordinate systems

cp$coordinates

cp2 <- cp + coord_polar()
cp$coordinates
cp2$coordinates

cp + coord_polar()
cp + coord_flip()
cp + coord_fixed(ratio = 1/10000)
cp + coord_trans(ytrans = "log10")
cp + coord_trans(ytrans = "log10", xtrans = "log10")
cp + coord_cartesian()
cp + coord_cartesian(ylim = c(0,5000), xlim = c(0, 1))

# Your Turn
# ------------------------------
tx + coord_map("mercator")
# -------------------------------

d2 <- subset(diamonds, color == "D")
cc <- qplot(color, data = d2, fill = cut, position = "fill")
cc
cc + coord_polar(theta = "x")


# Scales

hd <- qplot(displ, hwy, data =mpg, color = class, shape = class)

qplot(displ, hwy, data = mpg, color = cty)
qplot(displ, hwy, data = mpg, color = cty) + 
  scale_color_gradient(low = "red", high = "yellow")

qplot(displ, hwy, data = mpg, size = cyl)
qplot(displ, hwy, data = mpg, size = cyl) + 
  scale_size_area()

qplot(displ, hwy, data = mpg, shape = fl)
qplot(displ, hwy, data = mpg, shape = fl) + 
  scale_shape_manual(values = c(0, 15, 1, 16, 3))

r <- qplot(displ, cty, colour = drv, shape = fl, 
  data = mpg) 
r + scale_shape_manual(values = c(0, 15, 1, 16, 3))
?pch
r + scale_shape_manual(values = c(0, 15, 1, 16, 3))


tx + scale_fill_brewer(palette = "Greens")
tx + scale_fill_manual(values = c("red", "orange", "yellow", "green", "blue"))
tx + scale_fill_hue(h = c(150, 300), c = 150, l = 60)

tx + scale_fill_brewer(palette="OrRd")
tx + scale_fill_brewer(palette = "Spectral")

library(RColorBrewer)
display.brewer.all()
tx + scale_fill_brewer(palette="OrRd")

# Your Turn
# ----------------------------------------
display.brewer.all()
tx + scale_fill_brewer(palette = "Blues")
# ----------------------------------------

# Themes

tx + theme_grey()
tx + theme_bw()

tx
tx + theme(panel.border = element_rect(colour = "black", fill = NA))

library(ggthemes)
p <- qplot(color, data = diamonds,  fill = cut, position = "dodge")

p + theme_excel() + scale_fill_excel()
p + theme_economist() + scale_fill_economist()
p + theme_few() + scale_fill_few()
p + theme_few() + scale_fill_few()
p + theme_stata() + scale_fill_stata()
p + theme_tufte() + scale_fill_tableau()
p + theme_gdocs() + scale_fill_gdocs()
p + theme_wsj() + scale_fill_wsj(palette = "black_green")

# Axis labels

p + ylab("Price in Dollars ($)")
p + ylab("")

# Your Turn
# ----------------------------------------
tx + scale_fill_brewer(palette = "Blues") +
  xlab("") + 
  ylab("") +
  theme_bw() +
  coord_map() +
  ggtitle("Population of Texas Counties")
# ----------------------------------------

# Legends

q <- qplot(displ, hwy, data = mpg, color = cty)

q
q + theme(legend.position = "bottom")

q + guides(color = "colorbar")
q + guides(color = "legend")
q + guides(color = "none")

tx + scale_fill_grey(name = "Legend")
tx + scale_fill_grey(name = "Legend", 
  labels = c("label 1", "label 2", "label 3","label 4", "label 5"))

tx + scale_fill_discrete(name = "Legend name")

# Your Turn
# ----------------------------------------
tx + scale_fill_brewer(
  palette = "Blues",
  name = "Population", 
  labels = c("0 - 999", "1,000 - 9,999", 
    "10,000 - 99,999", "100,000 - 999,999", 
    "1,000,000+")) +
  xlab("") + 
  ylab("") +
  theme_bw() +
  coord_map() +
  ggtitle("Population of Texas Counties")
# ----------------------------------------

# Where to go from here

# More useful packages
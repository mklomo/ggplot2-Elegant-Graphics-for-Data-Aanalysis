#Chapter 12: Scales
library(tidyverse)
library(ggplot2)
library(dplyr)
##Types of Scales
#-Position Scales
#-Colour scales
#-Manual scales
#- Identity scales

#Specifying scales
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(colour = class)) +
  scale_x_continuous("An awesome x-axis") +
  scale_y_continuous("An amazing y-axis")

#Note
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(colour = class)) +
  scale_x_log10() +
  scale_color_brewer()

#Convinience functions
#xlim(25, 35) - for continuous scale from 10, 20
#ylim(20, 10) - a reversed continuous scale from 20 to 10
#xlim("a", "b", "c") - a discrete scale
#xlim(as. Date(c("2008-05-01", "2008-08-01"))): a date scale from May 1 to Auguat1 2008

#Three examples
base + xlim(2, 3)
base + xlim(3, 2)
base + lims(x = c(2, 3))


#Visual range expansion
#To set the expansions at limits to ZERO
ggplot(data = faithfuld, aes(x = waiting, y = eruptions)) +
  geom_raster(aes(fill = density))

#Do this
ggplot(data = faithfuld, aes(x = waiting, y = eruptions)) +
  geom_raster(aes(fill = density)) +
  scale_x_continuous(expand = c(0,0)) +
  scale_y_continuous(expand = c(0,0))

#Out of bound values: To ZOOM into an area of interest,
#use the xlim() and ylim() arguments to coord_cartesian() 

#Exercises
library(cowplot)
p1 <- ggplot() + geom_point(data = filter(mpg, drv == "f"), aes(x = displ, y = hwy, colour = class)) 
p2 <- ggplot() +  geom_point(data = filter(mpg, drv == "r"), aes(x = displ, y = hwy, colour = class))
plot_grid(p1, p2, labels = c("Forward", "Reverse"))


#Position Scales
#Convert from fuel economy to fuel consumption
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  scale_y_continuous(trans = "reciprocal")

#Transforming using "trans"
p3 <- ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  scale_y_continuous(trans = "log10")

#Vrs transforming using aes()
p4 <- ggplot(data = mpg, aes(x = displ, y = log10(hwy))) +
  geom_point()
plot_grid(p3, p4) 

#Discrete Position Scales
ggplot(data = mpg, aes(x = hwy, y = class)) +
  geom_point() +
  annotate(geom = "text", x = 5, y = 1:7, label = c("a", "b", "c", "d", "e", "f", "g"))


ggplot(data = mpg, aes(x = hwy, y = class)) +
  geom_count() +
  scale_x_binned(n.breaks = 10)

#12.4 Colour Scales
bars <- ggplot(data = mpg, aes(x = drv, y = hwy, fill = drv)) +
  geom_bar(stat = "identity") +
  scale_colour_hue()


#Instead use scale_fill_brewer with
#palette = "Set1" or "Dark2" for categorical data
ggplot(data = mpg, aes(x = drv, y = hwy, fill = drv)) +
  geom_bar(stat = "identity") +
  scale_fill_brewer(palette = "Set1")

#Or
ggplot(data = mpg, aes(x = drv, y = hwy, fill = drv)) +
  geom_bar(stat = "identity") +
  scale_fill_brewer(palette = "Dark2")

#Lets see how this works with geom_point
ggplot(data = mpg, aes(x = displ, y = hwy, colour = class)) +
  geom_point() +
  scale_color_brewer(palette = "Set1")


ggplot(data = mpg, aes(x = displ, y = hwy, colour = class)) +
  geom_point() +
  scale_color_brewer(palette = "Set2")

ggplot(data = mpg, aes(x = displ, y = hwy, colour = class)) +
  geom_point() +
  scale_color_brewer(palette = "Pastel1")















  
  
  
  
  
  
  



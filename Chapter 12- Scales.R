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












  
  
  
  
  
  
  



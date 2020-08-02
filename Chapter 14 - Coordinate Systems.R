#Linear coordinate systems
library(tidyverse)
library(dplyr)
library(ggplot2)
library(cowplot)
#-ccord_cartesian(): default Cartesian coordinate system
#This has 2 arguments i.e. xlim and ylim
base <- ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth()
##Comparing scale limits to limits using coord()
base + scale_x_continuous(limits = c(5, 7))
#vrs
base + coord_cartesian(xlim = c(5, 7))
#Use of coord_cartesian is a much more efficient code
#than using just xlim(5, 7) or scale_x_continuous(limits = c(5, 7)) 

#-coord_flip(): Cartesian coordinate system with x and y axes flipped
#Compare 1 with 2
#1
p1 <- ggplot(data = mpg, aes(x = cty, y = displ)) +
  geom_point() +
  geom_smooth()

#2
p2 <- ggplot(data = mpg, aes(x = displ, y = cty)) +
  geom_point() +
  geom_smooth() +
  coord_flip()
plot_grid(p1, p2, labels = c("Interchanged x and y", "Use of coord_flip"))
#Always better to use coord_flip than simply interchanging axes



#-coord_fixed(): Cartesian coordinate system with fixed aspect ratio








#Non-linear coordinate systems
#-coord_map()/coord_quickmap()/coord_sf(): Map projections
#-coord_polar(): Polar coordinates
#-coord_trans(): Apply arbitrary transformations to x and y positions
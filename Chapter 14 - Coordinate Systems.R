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

#Chapter 15: Facets
#There are three types of facetting"
#-facet_null(): a simgle plot, the default
#-facet_wrap(): "wraps" a 1d ribbon of panels into 2d
#facet_grid(): produces a 2d grid panels defined by variables which form the rows and columns

#Difference between facet_grid() and facet_wrap()
#facet_grid() is fundamentally 2d, being made up of 2 independent components.
#facet_wrap() is 1d but wrapped into 2d to save space.
mpg_2 <- mpg %>%
  filter(cyl != 5 & drv %in% c("4", "f") & class != "2seater")

base <- ggplot(data = mpg_2, aes(x = displ, y = hwy)) +
  geom_point(aes(colour = drv)) +
  xlab("") +
  ylab("")

#3 columns
base + facet_wrap(~class, ncol = 3)
#top right is the highest when as.table = False. Inverse applies too
base + facet_wrap(~class, ncol = 3, as.table = FALSE)


#3 rows
base +facet_wrap(~class, nrow = 3)
#Controlling the direction of wrap "v" or "h"
base +facet_wrap(~class, dir = "v")


#Facet Grid
#facet_grid() lays out plots in a 2d grid, as defined by a formula
#this spreads the values of cyl across the columns
base + facet_grid(.~cyl)

#the code belw speads the values of cyl across rows
base + facet_grid(cyl ~ .)
#a~b spreads a across columns and b down

#Controlling scales
#facet_wrap() and facet_grid() can control whether the position scales are the same in all panels or
#allowed to vary between panels (free) with scales parameter
#-scales = "fixed": x and y scales are fixed across all panels
#-scales = "free_x": the x scale is free and the y scale is fixed
#-scales = "free_y": the y scale is free, and the x scale is fixed
#-scales="free": s and y scales vary across panels

#fixed scales makes it easier to see patterns across scales
ggplot(data = mpg_2, aes(x = cty, y = hwy)) +
  geom_abline() +
  geom_jitter(width = 0.1, height = 0.1) +
  facet_wrap(~cyl, scales = "fixed") 


#free scales make it easier to see patterns within panels
ggplot(data = mpg_2, aes(x = cty, y = hwy)) +
  geom_abline() +
  geom_jitter(width = 0.1, height = 0.1) +
  facet_wrap(~cyl, scales = "free") 


#Free scales are also useful when we want to display multiple
#time series that were measured on different scales
#To do this we have to change from "wide" to "long" data,
#stacking the separate variables into a single column.
ggplot(data = economics_long, aes(x = date, y = value)) +
  geom_line() +
  facet_wrap(~variable, scales = "free_y", ncol = 1)

#Missing facetting variables
df_1 <- tibble(x = 1:3, y = 10:12, gender = c("f", "f", "m"))
df_2 <- tibble(x = 2, y = 11)

ggplot(data = df_1, aes(x = x, y = y)) +
  geom_point(data = df_2, aes(colour = "red", size = 4), show.legend = FALSE) +
  geom_point() +
  facet_wrap(~gender)
  
 
#Grouping vs. facetting
#With facetting, each group is quite far apart in its own panel,
#and there is no overlap between the groups. This is good if the groups 
#overlap a lot. But it does make small differences hard to see.
df <- tibble(
  x = rnorm(120, c(0,2,4)),
  y = rnorm(120, c(1, 2, 1)),
  z = letters[1:3]
)
  
ggplot(data = df, aes(x = x, y = y)) +
  geom_point() +
  facet_wrap(~z)
  
#Spotting small differences
ggplot(data = df, aes(x = x, y = y)) +
  geom_point(aes(colour = z))

#Comparisons between facets often benefit from some thoughtful
#annotation. For example, showing the mean of each group in every panel.
df_sum <- df %>%
  group_by(z) %>%
  summarise(x = mean(x), y = mean(y)) %>%
  rename(z2 = z)
  

ggplot(data = df, aes(x = x, y = y)) +
  geom_point() +
  geom_point(data = df_sum, aes(x = x, y = y, colour = z2)) +
  facet_wrap(~z)


#Another useful technique is to put all the data in the background
#of each panel
df_2 <- dplyr::select(df, -z)

ggplot(data = df, aes(x = x, y = y)) +
  geom_point(data = df_2, aes(x = x, y = y),colour = "grey70") +
  geom_point(aes(colour = z)) +
  facet_wrap(~z)

#Continuous Variables
#To facet continuous variables, you must first discretise them
#-Divide the data into n bins each of the same length: cut_interval(x, n)
#Six bins of equal length
mpg_2$displ_i <- cut_interval(mpg_2$displ, 6)
ggplot(data = mpg_2, aes(x = cty, y = hwy)) +
  geom_point() +
  facet_wrap(~displ_i)
#-Divide the data into bins of width: cut_width(x, width)
#Bins of width 1
mpg_2$displ_w <- cut_width(mpg_2$displ, 1)
ggplot(data = mpg_2, aes(x = cty, y = hwy)) +
  geom_point() +
  facet_wrap(~displ_w)
#-Divide the data into n bins each containing (approximately) the same number of points cut_number(x, n = 10)
#Six bins containing the same number of points
mpg_2$displ_n <- cut_number(mpg_2$displ, 6)
mpg_2$displ_w <- cut_width(mpg_2$displ, 1)
ggplot(data = mpg_2, aes(x = cty, y = hwy)) +
  geom_point() +
  facet_wrap(~displ_n)

#Exercise 15.7

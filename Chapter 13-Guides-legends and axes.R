#Chapter 13
library(tidyverse)
library(dplyr)
library(ggplot2)

#Scale names
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(colour = drv))+
  scale_color_brewer(palette = "Set1") +
  xlab("DISPL") +
  ylab("HWY")

#Or
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(colour = drv))+
  scale_color_brewer(palette = "Set1") +
  labs(x = "X-axis", y = "Y-axis", colour = "Colour\nlegend")


#Scale Breaks and Labels
#The breaks argument controls which values appear as tick marks on axes
#and keys on legends. If you set labels, you must also set breaks
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(colour = drv))+
  scale_color_brewer(palette = "Set1") +
  scale_y_continuous(labels = scales::unit_format(unit = "mpg"))

#Excercises 13.2.2
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  labs(x = "Displacement", y = quote(Highway (frac(miles, gallon)))) +
  scale_x_continuous(labels = scales::unit_format(unit = "L")) +
  labs(fontsize = 10)

#Dates: A special case
#Relevant conversion of dates using as.Date(), as.POSIXct() or hms::as_hms()
ggplot(data = economics, aes(x = date, y = psavert)) +
  geom_line() +
  scale_x_date(date_labels = c("%b-%Y")) +
  geom_vline(xintercept = as.Date(c("1970-01-01", "1980-01-01", "1990-01-01", "2000-01-01", "2010-01-01")))

#Selecting a date range
ggplot(data = economics, aes(x = date, y = psavert)) +
  geom_line() +
  scale_x_date(limits = as.Date(c("2004-01-01", "2005-01-01")) ,date_labels = c("%d-%b"), date_minor_breaks = "1 month", expand = c(0,0)) +
  scale_y_continuous(expand = c(0,0))

ggplot(data = economics, aes(x = date, y = psavert)) +
  geom_line() +
  scale_x_date(limits = as.Date(c("2004-01-01", "2005-01-01")) ,date_labels = c("%d/%b"), date_minor_breaks = "2 weeks", expand = c(0,0)) +
  scale_y_continuous(expand = c(0,0))


#Legend for multiple layers
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point(size = 4, colour = "grey20", show.legend = TRUE) +
  geom_point(aes(colour = drv)) +
  scale_color_brewer(palette = "Set1")

#Normally, the legend appears for the latter geompoint
#But since the show.legend = TRUE, for the first geom_point,
#the legend captures both geom_points
df <- tibble(x = rnorm(10000), y = rnorm(10000), z = c("a", "b", "c"))
df$z <- cut(df$y, 4, labels = c("a", "b", "c", "d"))

ggplot(data = df, aes(x = x, y = y)) +
  geom_point(aes(colour = z), alpha = 0.1) + 
  #the use of alpha ot prevent overplotting
  scale_color_brewer(palette = "Set1")

#To override the legends display
ggplot(data = df, aes(x = x, y = y)) +
  geom_point(aes(colour = z), alpha = 0.1) + 
  #the use of alpha ot prevent overplotting
  scale_color_brewer(palette = "Set1") +
  guides(colour = guide_legend(override.aes = list(alpha =1)))


#Mapping both colour and shape
ggplot(data = df, aes(x = x, y = y)) +
  geom_point(aes(colour = z, shape = z), alpha = 0.2) +
  guides(colour = guide_legend(override.aes = list(alpha = 1))) +
  scale_color_brewer(palette = "Set1")


#To control th elegend position, use theme(legend.position = )


#Exercises 13.5.3
#2
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(colour = drv, shape = drv)) +
  scale_color_brewer(palette = "Set1") +
  labs(colour = "Drive Train\n", shape = "Drive Train\n")

#3
ggplot(data = mpg, aes(y = hwy, x = displ, class = class)) +
  geom_point(aes(colour = class), show.legend = FALSE) +
  geom_smooth(method = "lm", se = FALSE, aes(colour = class)) +
  theme(legend.position = "bottom")
  


































  
  
  
  
  
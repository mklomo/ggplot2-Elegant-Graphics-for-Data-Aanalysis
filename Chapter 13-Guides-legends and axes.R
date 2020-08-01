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















  
  
  
  
  
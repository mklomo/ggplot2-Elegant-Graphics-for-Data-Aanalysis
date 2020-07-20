#Chaper 2 of ggplot: Elegant Graphics for Data Analysis
library(tidyverse)
library(ggplot2)
head(mpg)
str(mpg)

#Example 1: Plot of engine displacement in litres vs Highway miles pergallon 
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point()

#Exercises 2.3.1
#1. No because this diagram shows that the lower the mpg, the more litres of fuel you use.
ggplot(data = mpg, (aes(x = model,y = manufacturer)))+
  geom_point()
#Modifying data
model_manufacturer <- mpg %>%
  group_by(manufacturer) %>%
  summarise(n_distinct(model))

names(model_manufacturer) <- c("manufacturer", "no_of_models")

ggplot(data = model_manufacturer, aes(x = reorder(manufacturer, no_of_models), y = no_of_models, fill = manufacturer))+
  geom_col()+
  coord_flip()

#2.4 Colour, size, shape and other aestheric attributes
#Color
ggplot(data = mpg, aes(x = displ, y = hwy, colour = class))+
  geom_point()

# Shape
ggplot(data = mpg, aes(x = displ, y = hwy, shape = drv, color = drv))+
  geom_point()

#size
ggplot(data = mpg, aes(x = displ, y = hwy, size = cyl))+
  geom_point()

#Facetting
ggplot(data = mpg, aes(x = displ, y = hwy))+
  geom_point()+
  facet_wrap(~class)

#2.6.1 Adding a smoother to a smoother to a plot
ggplot(mpg, aes(x = displ, y = hwy))+
  geom_point()+
  geom_smooth()

#Fitting a linear model
ggplot(mpg, aes(x = displ, y = hwy))+
  geom_point()+
  geom_smooth(method = "lm")

#Boxplots and Jittered Points
ggplot(data = mpg, aes(x = drv, y = hwy))+
  geom_point()

#Overplotting problem is solved by 
ggplot(data = mpg, aes(x = drv, y = hwy, color = drv))+
  geom_jitter()

#Or
ggplot(data = mpg, aes(x = drv, y = hwy, fill = drv))+
  geom_boxplot()

#Or
ggplot(data = mpg, aes(x = drv, y = hwy, fill = drv))+
  geom_violin()

#Histograms and Frequency Polygons of a SINGLE numeric variable
ggplot(mpg, aes(hwy))+
  geom_histogram()
#Or
ggplot(mpg, aes(hwy))+
  geom_freqpoly()

#It is VERY important to determine the optimal binwidth for your dataset
ggplot(mpg, aes(hwy))+
  geom_freqpoly(binwidth = 1)

ggplot(mpg, aes(hwy))+
  geom_freqpoly(binwidth = 2.5)

#Comparing Distributions of subgroups
ggplot(data = mpg, aes(displ, color = drv))+
  geom_freqpoly(binwidth = 0.5)

#Facetting to compare distributions
ggplot(data = mpg, aes(displ, fill = drv))+
  geom_histogram(binwidth = 0.5)+
  facet_wrap(~drv, ncol = 1)

#Bar charts
ggplot(data = mpg, aes(x = manufacturer))+
  geom_bar()

#Time series with line and path plots
data("economics")
head
head(economics)

#Unemployment rate over time
ggplot(data = economics, aes(x = date, y = unemploy/pop))+
  geom_line()

#Median number of weeks unemployed
ggplot(data = economics, aes(x = date, y = uempmed))+
  geom_line()

#Path Plot
ggplot(economics, aes(x = unemploy/pop, y = uempmed))+
  geom_path()+
  geom_point()

year <- function(x){
  as.POSIXlt(x)$year + 1900
}

ggplot(economics, aes(x = unemploy/pop, y = uempmed))+
  geom_path(color = "grey50")+
  geom_point(aes(color = year(date)))

#Exercises
ggplot(data = mpg, aes(x = cty, y = hwy)) +
  geom_point() +
  geom_smooth(method = "lm")


ggplot(data = mpg, aes(x = reorder(class, hwy), y = hwy, fill = class))+
  geom_boxplot()

data("diamonds")
ggplot(data = diamonds, aes(x = carat)) +
  geom_histogram(binwidth = 0.25)

#Modifying labels with xlab, ylab, xlim and ylim
ggplot(data = mpg, aes(x = cty, y = hwy))+
  geom_point(alpha = 1/3)+
  xlab("city driving (mpg)")+
  ylab("highway driving (mpg)")

ggplot(data = mpg, aes(x = drv, y = hwy))+
  geom_jitter(width = 0.25) +
  xlim("4", "r") +
  ylim(10, 30) +
  xlab(NULL) +
  ylab(NULL)







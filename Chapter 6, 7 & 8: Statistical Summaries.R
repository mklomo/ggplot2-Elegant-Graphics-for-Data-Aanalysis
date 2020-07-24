#Chapter 6: Statistical Summaries
#Discrete x, range: geom_errorbar & geom_linerange
#Discrete x, range & center: geom_crossbar & geom_pointrange
#Continuous x, range: geom_ribbon
#Continuous x, range & center: geom_smooth(stat = "identity")
#These assume, we are interested in the distribution of y conditional on x
library(tidyverse)
library(dplyr)
library(ggplot2)
y <- c(18, 11, 16)
df <- data.frame(x = 1:3, y = y, se = c(1.2, 0.5, 1.0))
base <- ggplot(data = df, aes(x = x, y = y, ymin = y - se, ymax = y + se))

#Geom_Crossbar
base + geom_crossbar()

#Geom_Pointrange
base + geom_pointrange()

#Geom_Smooth
base + geom_smooth(stat = "identity")

#Geom_errorbar
base + geom_errorbar()

#Geom_linerange
base + geom_linerange()

#Geom_ribbon
base + geom_ribbon()


#Weighted Data
data("midwest")

#Unweighted
ggplot(data = midwest, aes(x = percwhite, y = percbelowpoverty)) +
  geom_point()

#Weight by population
ggplot(data = midwest, aes(x = percwhite, y = percbelowpoverty)) +
  geom_point(aes(size = poptotal/1e6)) +
  scale_size_area("Population\n(millions)", breaks = c(0.5, 1, 2, 4))

#Unweighted
ggplot(data = midwest, aes(x = percwhite, y = percbelowpoverty)) +
  geom_point() +
  geom_smooth(method = "lm", size = 2)

#Weighted by Population
ggplot(data = midwest, aes(x = percwhite, y = percbelowpoverty)) +
  geom_point(aes(size = poptotal/1e6)) +
  geom_smooth(aes(weight = poptotal), method = "lm", size = 1) +
  scale_size_area(guide = "none")

#Histogram unweighted
ggplot(data = midwest, aes(percbelowpoverty)) +
  geom_histogram(binwidth = 1) +
  ylab("Counties")


#Histogram weighted by pop
ggplot(data = midwest, aes(percbelowpoverty)) +
  geom_histogram(aes(weight = poptotal), binwidth = 1) +
  ylab("Population (1000s")


#Diamonds Data
data("diamonds")
head(diamonds)
#1D Continuous Distributions
ggplot(data = diamonds, aes(x = depth)) +
  geom_histogram(binwidth = 0.25) +
  xlim(50, 70) +
  labs(title = "Distribution of Diamond Depth", caption = "binwidth = 0.25")

#If you want to compare the distribution b/n groups, the options are:
#-Show small multiples of the histogram using facet_wrap(~var)
#- Use color and a frequency polygon, geom_freqpoly()
#- Use a "Conditional Density Density Plot", geom_histogram(position = "fill")

ggplot(data = diamonds, aes(x = depth)) +
  geom_histogram(aes(fill = cut), binwidth = 0.5) +
  facet_wrap(~cut) +
  xlim(50, 70)

ggplot(data = diamonds, aes(depth)) +
  geom_freqpoly(aes(color = cut), binwidth = 0.1, na.rm = TRUE) +
  xlim(58, 68) +
  theme(legend.position = "none")

ggplot(data = diamonds, aes(depth)) +
  geom_histogram(aes(fill = cut), binwidth = 0.1, position = "fill", na.rm = TRUE) +
  xlim(58, 68) +
  theme(legend.position = "none")

#Using the density estimate
ggplot(data = diamonds, aes(depth)) +
  geom_density(na.rm = TRUE) +
  xlim(58, 68)

ggplot(data = diamonds, aes(depth, fill = cut, color = cut)) +
  geom_density(alpha = 0.2, na.rm = TRUE)



#Comparing many distributions
#Using the boxplot
ggplot(data = diamonds, aes(x = clarity, y = depth)) +
  geom_boxplot()

ggplot(data = diamonds, aes(x = carat, y = depth)) +
  geom_boxplot(aes(group = cut_width(carat, 0.1))) +
  xlim(NA, 2.05)

#Using the geom_violin
#x = factor, y = continuous
ggplot(data = diamonds, aes(x = clarity, y = depth)) +
  geom_violin()

#x = continuous, y = continuous
ggplot(data = diamonds, aes(x = carat, y = depth)) +
  geom_violin(aes(group = cut_width(carat, 0.1))) +
  xlim(NA, 2.05)



#Exercises 6.4.1
ggplot(data = diamonds, aes(x = carat)) +
  geom_histogram(binwidth = 0.1)

ggplot(data = diamonds, aes(x = price)) +
  geom_histogram(binwidth = 100)

ggplot(data = diamonds, aes(x = reorder(clarity, price), y = price)) +
  geom_boxplot()

ggplot(data = diamonds, aes(x = depth)) +
  geom_density() +
  geom_freqpoly(aes(y = ..density..))
  

#Dealing with Overplotting
#Very small amounts of overplotting can sometimes be alleviated by making the points smaller
df <- data.frame(x = rnorm(2000), y = rnorm(2000))
base <- ggplot(data = df, aes(x, y)) +
  ylab(NULL) +
  xlab(NULL)

base + geom_point()

#Pixel Sized
base + geom_point(shape = ".")

#Pixel sized
base + geom_point(shape = 1)

#For larger datasets
base + geom_point(alpha = 1/3)
base + geom_point(alpha = 1/5)
base + geom_point(alpha = 1/10)



#Using the 2d density estimation
base + geom_bin2d()
base + geom_bin2d(bins = 30)



#Or
library(hexbin)
base + geom_hex()
base + geom_hex(bins = 30)


#Statistical Summaries
ggplot(data = diamonds, aes(x = color)) +
  geom_bar()


ggplot(data = diamonds, aes(x = color, y = price)) +
  geom_bar(stat = "summary_bin", fun = mean)


























































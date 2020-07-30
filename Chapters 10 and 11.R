#Chapter 10: Mastering the Grammar
library(tidyverse)
library(dplyr)
library(ggplot2)

#Building a Scatterplot
ggplot(data = mpg, aes(x = displ, y = hwy, colour = factor(cyl))) +
  geom_point(size = 2)

new_df <- data.frame(x = c(1.8, 1.8, 2.0, 2.0, 2.8, 2.8, 3.1, 1.8),
                     y = c(29, 29, 31, 30, 26, 26, 27, 26),
                     colour = c(4, 4, 4, 4, 6, 6, 6, 4))
ggplot(data = mpg, aes(x = displ, y = hwy, colour = factor(cyl))) +
  geom_line() +
  theme(legend.position = "none")


#Overlaying multiple geoms
ggplot(data = mpg, aes(x = displ, y = hwy, colour = cyl)) +
  geom_point() +
  geom_smooth(method = "lm")

#Note the effect of factor
ggplot(data = mpg, aes(x = displ, y = hwy, colour = factor(cyl))) +
  geom_point() +
  geom_smooth(method = "lm")


#10.3 Adding complexity

ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth() +
  facet_wrap(~year)

#11 Build a plot layer by layer
#Each layer can come from a different dataset and have a different aesthetic
#mapping, making it possible to create sophisticated plots that display data
#from multiple sources
p <- ggplot(data = mpg, aes(x = displ, y = hwy))

#Addign a layer
p +geom_point()

data(mpg)
mod <- loess(hwy ~ displ, data = mpg)
grid <- tibble(seq(from = min(mpg$displ), to = max(mpg$displ), length.out = 50))
names(grid) <- c("displ")
grid$hwy <- predict(mod, newdata = grid)


mpg$std_resid <- resid(mod)/mod$s
outlier <- mpg %>%
  subset(abs(std_resid) > 2)

p + geom_point() +
  geom_line(data = grid, colour = "red", size = 1.5) +
  geom_point(data = outlier, aes(x = displ, y = hwy), size = 2, colour = "red") +
  geom_text(data = outlier, aes(label = model), hjust = "left")
#Note: do not pass size and color into aes() mapping


class <- mpg %>%
  group_by(class) %>%
  summarise(n = n(), hwy = mean(hwy))


#Exercise 11.3.1.2
ggplot(data = class, aes(x = class, y = hwy)) +
  geom_jitter(data = mpg, aes(x = class, y = hwy), width = 0.2, size = 2.5) +
  geom_point(data = class, aes(x = class, y = hwy), colour = "red", size = 7) +
  geom_text(y = 10, aes(label = paste0("n = ", n))) +
  ylim(9,45)
  
#Aesthetic Mappings
ggplot(data = mpg, aes(x = displ, y = hwy, colour = class)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  theme(legend.position = "none")


ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(colour = class)) +
  geom_smooth(method = "lm", se = FALSE) +
  theme(legend.position = "none")


#Setting colour within and outside the aes
ggplot(data = mpg, aes(x = cty, y = hwy)) +
  geom_point(colour = "darkblue")

#vs
ggplot(data = mpg, aes(x = cty, y = hwy)) +
  geom_point(aes(colour = "darkblue")) +
  theme(legend.position = "none")
  
#You can fix this with scale_colour_identity
ggplot(data = mpg, aes(x = cty, y = hwy)) +
  geom_point(aes(colour = "darkblue")) +
  theme(legend.position = "none") + 
  scale_color_identity()

ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(aes(colour = "loess"), method = "loess", se = FALSE) +
  geom_smooth(aes(colour = "lm"), method = lm, se = FALSE)


#11.5 Geoms
# - Graphical Primitives 
#geom_point():points
#geom_path(): paths
#geom_ribbon(): ribbons
#geom_segment():a line segment
#geom_rect(): rectangles
#geom_polygon(): fillled polygons
#geom_text(): text


# - One variable
##Discrete: geom_bar() - display distribution of discrete variable
##Continuous: geom_histogram()
#geom_density()
#geom_dotplot()
#geom_freqpoly()


# - Two variables
## Both continuous
#geom_point(): scatterplot
#geom_quantile(): smoothed quantile regression
#geom_rug(): marginal rug plots
#geom_smooth(): smoothed line of best fit
#geom_text(): text labels

#Show distribution
#geom_bin2d(): bin into rectangles and count
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_bin2d()

#geom_density2d(): smoothed 2d density estimate
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_density_2d()

#geom_hex()
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_hex()

#Atleast one discrete
#geom_count(): count number of point at distinct locations
ggplot(data = mpg, aes(x = class, y = hwy)) +
  geom_count()
#geom_jitter(): randomly jitter overlapping points
ggplot(data = mpg, aes(x = class, y = hwy)) +
  geom_jitter(width = 0.25)


#One continuous, one discrete
#geom_bar(stat = "identity")
ggplot(data = mpg, aes(x = class, y = hwy)) +
  geom_bar(stat = "identity")

#geom_boxplot
ggplot(data = mpg, aes(x = class, y = hwy)) +
  geom_boxplot()

#geom_violin
ggplot(data = mpg, aes(x = class, y = hwy)) +
  geom_violin()

#One time, one continuous
#geom_area(): area plot
#geom_line(): line plot
#geom_step(): step plot

#Display uncertainty
range_mpg <- mpg %>%
  group_by(class) %>%
  summarise(minimum = min(hwy), maximum = max(hwy), average = mean(hwy))

#geom_crossbar
ggplot(data = range_mpg, aes(x = class, y = average, colour = class)) +
  geom_crossbar(aes(ymin = minimum, ymax = maximum))

#geom_errorbar
ggplot(data = range_mpg, aes(x = class, y = average, colour = class)) +
  geom_errorbar(aes(ymin = minimum, ymax = maximum)) +
  theme(legend.position = "none")

#geom_linerange()
ggplot(data = range_mpg, aes(x = class, y = average, colour = class)) +
  geom_linerange(aes(ymin = minimum, ymax = maximum)) +
  theme(legend.position = "none")

#geom_pointrange()
ggplot(data = range_mpg, aes(x = class, y = average, colour = class)) +
  geom_pointrange(aes(ymin = minimum, ymax = maximum)) +
  theme(legend.position = "none")

#11.6 Stats
#stat_ecdf(): compute an empirical cumulative distribution plot
#stat_function(): compute y values from a function of x values
#stat_summary(): summarise y values at distinct x values
#stat summary 2d(), stat_summary_hex(): summarise binned values
#stat_qq(): perform calculations for a quantile-quantile plot
#stat_spoke(): convert angle and radius to position
#stat_unique(): remove duplicated rows
ggplot(data = mpg, aes(x = class, y = cty)) +
  geom_point() +
  geom_point(stat = "summary", fun = "median", colour = "red", size = 6)


##11.6.1 Generated variables
ggplot(data = diamonds, aes(price)) +
  geom_histogram(binwidth = 500)

ggplot(data = diamonds, aes(price)) +
  geom_histogram(aes(y = after_stat(density)), binwidth = 500)

#Its BETTER to compare distribution of multiple groups that have different sizes.
#Because this way, we standardise each group to take the same area

#Do NOT compare using this
ggplot(data = diamonds, aes(x = price, colour = cut)) +
  geom_freqpoly(binwidth = 500)

#BUT DO THIS:
ggplot(data = diamonds, aes(x = price, colour = cut)) +
  geom_freqpoly(aes(y = after_stat(density)), binwidth = 500)

#The results are pretty surprising as low quality diamonds seem to be more expensive on average































































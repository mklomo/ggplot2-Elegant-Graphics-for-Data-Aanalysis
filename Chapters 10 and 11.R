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


ggplot(data = class, aes(x = class, y = hwy)) +
  geom_jitter(data = mpg, aes(x = class, y = hwy), width = 0.2, size = 2.5) +
  geom_point(data = class, aes(x = class, y = hwy), colour = "red", size = 7) +
  geom_text(y = 10, aes(label = paste0("n = ", n))) +
  ylim(9,45)
  




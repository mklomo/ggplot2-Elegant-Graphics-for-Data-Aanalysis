#Chapters 2, 3, 4 & 5: Getting started with ggplot2
library(tidyverse)
library(dplyr)
library(ggplot2)
data(mpg)

ggplot(data = mpg, aes(x = hwy, y = cty, label = drv)) +
  geom_point()+
  theme(plot.title = element_text(size = 12)) +
  ggtitle("point")

ggplot(data = mpg, aes(x = hwy, y = cty, label = drv)) +
  theme(plot.title = element_text(size = 12)) +
  geom_text()+
  ggtitle("point")

ggplot(data = mpg, aes(x = hwy, y = cty, label = drv)) +
  theme(plot.title = element_text(size = 12)) +
  geom_bar(stat = "identity") +
  ggtitle("bar")

ggplot(data = mpg, aes(x = hwy, y = cty, label = drv)) +
  theme(plot.title = element_text(size = 12)) +
  geom_col() +
  ggtitle("bar")



ggplot(data = mpg, aes(x = hwy, y = cty, label = drv)) +
  theme(plot.title = element_text(size = 12)) +
  geom_tile() +
  ggtitle("raster")


ggplot(data = mpg, aes(x = hwy, y = cty, label = drv)) +
  theme(plot.title = element_text(size = 12)) +
  geom_line() +
  ggtitle("line")

ggplot(data = mpg, aes(x = hwy, y = cty, label = drv)) +
  theme(plot.title = element_text(size = 12)) +
  geom_area() +
  ggtitle("area")

ggplot(data = mpg, aes(x = hwy, y = cty, label = drv)) +
  theme(plot.title = element_text(size = 12)) +
  geom_polygon() +
  ggtitle("polygon")



#Use of Longitudinal Data
library(nlme)
data("Oxboys")
as_tibble(Oxboys)


#Spaghetti Plots
ggplot(data = Oxboys, aes(x = age, y = height, group = Subject)) +
  geom_point()+
  geom_line()

#interaction grouping and how it does NOT work 
ggplot(data = mpg, aes(x = cyl, y = hwy, group = interaction(model, year)))+
  geom_point()+
  geom_line()

#Grouped Spaghetti Plots
ggplot(data = Oxboys, aes(x = age, y = height, group = Subject)) +
  geom_line()+
  geom_smooth(method = "lm", se = FALSE)

#Use this instead
ggplot(data = Oxboys, aes(x = age, y = height)) +
  geom_line(aes(group = Subject))+
  geom_smooth(method = "lm", se = FALSE)

#Overriding the default grouping of Occasion vs height
ggplot(data = Oxboys, aes(x = Occasion, y = height)) +
  geom_boxplot()


#Overriding the default grouping of Subject vs height
ggplot(data = Oxboys, aes(x = Subject, y = height)) +
  geom_boxplot() 

#Overriding the default grouping of Subject vs height overlaid with occasion
ggplot(data = Oxboys, aes(x = Subject, y = height)) +
  geom_boxplot() +
  geom_line(aes(group = Occasion))

#Matching aesthetics to graphic objects
df_1 <- data.frame(x = 1:3, y = 5:7, colour = c("a", "b", "c"))

ggplot(data = df_1, aes(x, y , color = as.factor(colour))) +
  geom_point(size = 3) +
  geom_line(aes(group = 1))

#Exercise 5.5
#Boxplot for cyl using group
ggplot(data = mpg, aes(x = cyl, y = hwy, group =cyl)) +
  geom_boxplot()

#Boxplot for displ
ggplot(data = mpg, aes(x = displ, y = hwy, group = displ)) +
  geom_boxplot()

mpg %>% 
  arrange(hwy) %>%
  mutate(id = seq_along(hwy)) %>%
  ggplot(aes(x = drv, fill = hwy, group = id)) +
  geom_bar(colour = "white")


#Babynames
install.packages("babynames")
library(babynames)
hadley <- dplyr::filter(babynames, name == "Hadley")
ggplot(data = hadley, aes(x = year, y = n, color = sex)) +
  geom_line()

Eunice <- babynames %>% 
  filter(name == "Eunice")
ggplot(data = Eunice, aes(x = year, y = n, color = sex))+
  geom_line(size = 2) +
  ylab("Number of applicants so named")
  
  
Daniel <- babynames %>% 
  filter(name == "Daniel")
ggplot(data = Daniel, aes(x = year, y = n, color = sex))+
  geom_line(size = 2) +
  ylab("Number of applicants so named")+
  ggtitle("Distribution of Persons named Daniel")
  
  
  
Judy <- babynames %>% 
  filter(name == "Judy")
ggplot(data = Judy, aes(x = year, y = n, color = sex))+
  geom_line(size = 2) +
  ylab("Number of applicants so named")+
  ggtitle("Distribution of Persons named Judy")


Morgan <- babynames %>% 
  filter(name == "Morgan")
ggplot(data = Morgan, aes(x = year, y = n, color = sex))+
  geom_line(size = 2) +
  ylab("Number of applicants so named")+
  ggtitle("Distribution of Persons named Morgan")


Morgan <- babynames %>% 
  filter(name == "Morgan")
ggplot(data = Morgan, aes(x = year, y = n, color = sex))+
  geom_line(size = 2) +
  ylab("Number of applicants so named")+
  ggtitle("Distribution of Persons named Morgan")


Priscilla <- babynames %>% 
  filter(name == "Priscilla")
ggplot(data = Priscilla, aes(x = year, y = n, color = sex))+
  geom_line(size = 2) +
  ylab("Number of applicants so named")+
  ggtitle("Distribution of Persons named Priscilla")







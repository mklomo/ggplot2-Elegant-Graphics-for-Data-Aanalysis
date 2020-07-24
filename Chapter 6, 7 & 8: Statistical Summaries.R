#Chapters 6, 7 & 8
#Chapter 6
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



#7.1 Polygon Maps
library(tidyverse)
library(dplyr)
mi_counties <- map_data("county", "michigan") %>%
  select(lon = long, lat, group = subregion)
head(mi_counties)



#Plotting Geom_Points
ggplot(data = mi_counties, aes(x = lon, y = lat)) +
  geom_point(size = 0.5) +
  coord_quickmap()


#Similar to above
ggplot(data = mi_counties, aes(x = lon, y = lat)) +
  geom_point(size = 0.5, show.legend = FALSE) +
  coord_quickmap()

#Using Geom_Polygon
ggplot( data = mi_counties, aes(x = lon, y = lat, group = group)) +
  geom_polygon(fill = "white", colour = "grey50") +
  coord_quickmap()


#7.2 Simple features maps
library(ozmaps)
library(sf)
oz_states <- ozmaps::ozmap_states

#Plotting using simple features
ggplot(ozmap_states) +
  geom_sf() +
  coord_sf()


#7.2.1 Layered Maps
oz_states <- ozmap_states %>%
  filter(NAME != "Other Territories")


oz_votes <- rmapshaper::ms_simplify(abs_ced)


ggplot() +
  geom_sf(data = oz_states, mapping = aes(fill = NAME), show.legend = FALSE) +
  geom_sf(data = oz_votes, fill = NA) +
  coord_sf()




#7.2.2 Labelled Maps
sydney_map <- abs_ced %>%
  filter(NAME %in% c("Sydney", "Wentworth", "Warringah", "Kingsfor Smith", "Grayndler", "Lowe",
                     "North Sydney", "Barton", "Bradfield", "Banks", "Blaxland", "Reid",
                     "Watson", "Fowler", "Werriwa", "Prospect", "Parramatta", "Bennelong",
                     "Mackellar", "Greenway", "Mitchell", "Chifley", "McMahon"))
ggplot(sydney_map) +
  geom_sf(aes(fill = NAME), show.legend = FALSE) +
  coord_sf() +
  geom_sf_label(aes(label = NAME))

ggplot(sydney_map) +
  geom_sf(aes(fill = NAME), show.legend = FALSE) +
  coord_sf(xlim = c(150.97, 151.3), ylim = c(-33.98, -33.79)) +
  geom_sf_label(aes(label = NAME), label.padding = unit(1, "mm"))

ggplot(sydney_map) +
  geom_sf(aes(fill = NAME), show.legend = FALSE) +
  coord_sf(xlim = c(150.97, 151.3), ylim = c(-33.98, -33.79)) +
  geom_sf_label(aes(label = NAME))


#Map Projections
#Determining CRS
st_crs(oz_votes)
##Chapter 8: Annotations, Titles and Labels
#Adding text to plots is one of the most common forms of annotation
#Especially imporrtant when labelling outlers and other important points
df <- data.frame(x = 1, y = 3:1, face = c("plain", "bold", "italic"))
ggplot(data = df, aes(x = x, y = y))+
  geom_text(aes(label = face, fontface = face))
ggplot(data = df, aes(x = x, y = y))+
  geom_text(aes(label = face))
ggplot(data = df, aes(x = x, y = y))+
  geom_text(aes(label = face,  fontface = face))


##Chapter 8: Annotations, Titles and Labels
#Adding text to plots is one of the most common forms of annotation
#Especially imporrtant when labelling outlers and other important points
df_1 <- data.frame(x = 1, y = 3:1, family = c("sans", "serif", "mono"))

ggplot(data = df_1, aes(x = x, y = y)) +
  geom_text(aes(label = family))


df_3 <- data.frame(trt = c("a", "b", "c"), resp = c(1.2, 3.4, 2.5))
ggplot(data = df_3, aes(x = resp, y = trt)) +
  geom_point() +
  geom_text(aes(label = paste0("(", resp, ")")), nudge_y = -0.25)


#Using ggrepel geom_label and geom_text
mini_mpg <- mpg[sample(nrow(mpg), 5),]

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(color = "pink") +
  ggrepel::geom_label_repel(data = mini_mpg, aes(label = class))


ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(color = "pink") +
  ggrepel::geom_text_repel(data = mini_mpg, aes(label = class))


#Building custom annotations
data("economics")
data("presidential")

presidential_sum <- presidential %>%
  subset(start > economics$date[1])

#Layer_1
ggplot() +
  geom_rect(aes(xmin = start, xmax = end, fill = party),
            ymin = -Inf, ymax = Inf, alpha = 0.2,
            data = presidential_sum)

ggplot() +
  geom_rect(aes(xmin = start, xmax = end, fill = party,
                ymin = -Inf, ymax = Inf), alpha = 0.3,
            data = presidential_sum) +
  geom_vline( aes(xintercept = as.numeric(start)),
              data = presidential_sum,
              color = "black", alpha = 0.5) +
  geom_text(aes(x = start, y = 2500, label = name),
            data = presidential_sum, size = 5, vjust = 0, hjust = 0,
            nudge_x = 50) +
  geom_line( data = economics, aes(x = date, y = unemploy)) +
  scale_fill_manual(values = c("blue", "red")) +
  xlab("Date") +
  ylab("Unemployment")+
  xlim(min(presidential_sum$start), max(presidential_sum$end))


#Using annotate() helper function
ggplot(data = economics, aes(x = date, y = unemploy)) +
  geom_line()
#Using annotate() helper function to highlight only subaru cars
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point(
    data = filter(mpg, manufacturer == "subaru"),
    colour = "red",
    size = 5
  )

#Using annotate() helper function
base <- ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point(
    data = filter(mpg, manufacturer == "subaru"),
    colour = "red",
    size = 5
  ) +
  geom_point()

#The problem with the above is that the highlighted category would not be labelled
#This is easily rectified using annotate
base +
  annotate(geom = "point", x = 5.5, y = 40, colour = "red", size = 3)


#The problem with the above is that the highlighted category would not be labelled
#This is easily rectified using annotate
base +
  annotate(geom = "point", x = 5.5, y = 40, colour = "red", size = 3) +
  annotate(geom = "point", x = 5.5, y = 40) +
  annotate(geom = "text", x = 5.6, y =40, label = "Subaru", hjust = "left", size = 5)


#This approach has the advantage of creating a label inside th eplot region,
#but the drawback is that the label is distant from the points it picks out
#otherwise the red and black dot adjacent to the label might be confused for real data
#Alternatively
base +
  annotate(
    geom = "curve", x = 4, y = 35, xend = 2.6 , yend = 27,
    curvature = 0.2, arrow = arrow(length = unit(2, "mm"))
  ) +
  annotate(geom = "text", x = 4.1, y = 35, label = "Subaru", hjust = "left")

#Or
base +
  annotate(
    geom = "curve", x = 4, y = 35, xend = 2.6 , yend = 27,
    curvature = 0.1, arrow = arrow(length = unit(2, "mm"))
  ) +
  annotate(geom = "text", x = 4.1, y = 35, label = "Subaru", hjust = "left")
install.packages("directlabels")



#Direct Labelling using the directlabels package
ggplot(data = mpg, aes(x = displ, y = hwy, colour = class)) +
  geom_point(show.legend = FALSE) +
  directlabels::geom_dl(aes(label = class), method = "smart.grid")



#Using facets
ggplot(data = diamonds, aes(x = log10(carat), y = log10(price))) +
  geom_bin2d() +
  facet_wrap(~cut, nrow = 1)



#Using gghighlight package
ggplot(data = mpg, aes(x = displ, y = hwy, colour = factor(cyl))) +
  geom_point(show.legend = FALSE) +
  gghighlight::gghighlight() +
  facet_wrap(~cyl)























































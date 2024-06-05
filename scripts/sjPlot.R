# Load packages 
library(tidyverse)
library(ggthemes)
library(hrbrthemes)
library(RColorBrewer)
library(sjPlot)

# data 
data <- read.csv("data/pulse_data.csv", stringsAsFactors = T)

# check data structure 
glimpse(data)

plot_frq(data$Exercise)


plot_frq(data$Exercise , sort.frq = "desc")

plot_frq(
  data$Exercise,
  sort.frq = "desc",
  title = "Distr. of Exercise among participants"
)

#basic
basic <- plot_frq(data$Exercise)+
  labs(x= "Exercise" , y= "Frequency")+
  scale_fill_ipsum()+
  theme_gray()
basic
save_plot(filename = "figures/ex.png", height = 19, width = 30, dpi = 300)


#grouping

data |> 
  group_by(Gender) |> 
  plot_frq(Exercise) |> 
  plot_grid()



plot_grpfrq(
  var.cnt = data$Exercise, 
  var.grp = data$Gender
)

# coord.flip
plot_grpfrq(
  var.cnt = data$Exercise, 
  var.grp = data$Gender, 
  coord.flip = T
)

# box plot 
data |> 
  group_by(Gender) |> 
  plot_frq(BMI, type = "box", show.mean = T) |> 
  plot_grid()  

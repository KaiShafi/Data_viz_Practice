#Load Packages
library(tidyverse)
library(ggthemes)
library(ggsci)
library(RColorBrewer)
library(hrbrthemes)

#Steps in Data Visualization : Mapping into aesthetics
# 1. Aesthetic (x = ? , Y= ?)
# 2. Visual property of a graph (bar,chart,pie)
# 3. Position,shape, color etc
# 4. Data
# 5. A column ina data set

# ggplot() template
ggplot( data ="",mapping = aes(x="",y=""))+geom_type()

#import
data <- read.csv("Data/pulse_data.csv")

#Frequency
table(data$Gender)

#visualize with barplot
ggplot(data ,aes(x= Gender,))+ geom_bar()


#simple customization
ggplot(data ,aes(x= Gender,fill = Gender))+ 
  geom_bar()+
  labs(
    x = "Gender",
    y = "Counts",
    title = "Distribution of Gender",
    subtitle = "Sample Subtitle",
    caption = "Data Source : Chiral"
    
  )

#Group bar chart(2 categorical value)

table(data$Gender,data$Alcohol)
#Stacked
ggplot(data , aes(x = Gender, fill = Alcohol))+
  geom_bar()

#side by side
ggplot(data,aes(x = Gender,fill = Alcohol))+
  geom_bar(position = position_dodge())


#boxplot( to detect outlier)
data |> 
  ggplot(aes(x = cat, y= num))+
  geom_boxplot()

data |> 
  ggplot(aes(x = Exercise, y= BMI))+
  geom_boxplot()

fivenum(data$BMI) #5 no. summary
summary(data$BMI) # 5 no summary

#Group box plot( to compare groups)
data |> 
  ggplot(aes(x = Exercise, y= BMI , fill = Gender))+
  geom_boxplot()

#violin plot(use for large dataset)
#Simple violin plot
data |> 
  ggplot(aes(x = Exercise, y= BMI))+
  geom_violin()


#Group violin plot
data |> 
  ggplot(aes(x = Exercise, y= BMI , fill = Gender))+
  geom_violin()

#simple point plot

data |> 
  ggplot(aes(x = Age, y= Height))+
  geom_point()
#Group point plot
data |> 
  ggplot(aes(x = Age, y= Height , color = Gender))+
  geom_point()

#simple line plot
data |> 
  ggplot(aes(x = Age, y= Height))+
  geom_line()
#Group Line Plot
data |> 
  ggplot(aes(x =Age, y= Height, color = Gender))+
  geom_line()

#distribution plot : histogram(to visualize numeric distr)

data |> 
  ggplot(aes(x =Height))+
  geom_histogram()

#bin size

data |> 
  ggplot(aes(x = Height , fill =Gender))+
  geom_histogram(bins = 15)

#facet

data |> 
  ggplot(aes(x = BMI , fill = Gender))+
  geom_histogram()+
  facet_wrap(~Gender)

data |> 
  ggplot(aes(x = Height ))+
  geom_histogram(bins = 15)
#distribution plot : density

data |> 
  ggplot(aes(x = Height))+
  geom_density()

#pie Chart
gender_counts <-data |> 
  count(Gender) |> 
  mutate(Percentage = n/ sum(n)*100)

ggplot(gender_counts,aes(x="",y=Percentage,fill = Gender))+
  geom_bar(width = 1,stat = "identity")+
  coord_polar("y",start = 0)


#customization
basic <-ggplot(data ,aes(x= Gender,fill = Gender))+ 
  geom_bar()+
  labs(
    x = "Gender",
    y = "Counts",
    title = "Distribution of Gender",
    subtitle = "Sample Subtitle",
    caption = "Data Source : Chiral"
    
  )
#show
basic

#built in themes
basic + theme_economist()
basic + theme_gray()
basic + theme_fivethirtyeight()
basic + theme_bw()
basic + theme_foundation()
basic + theme_economist_white()
basic + theme_ipsum()
basic + theme_ipsum_pub()



# colors ~ fill 
basic + scale_fill_ipsum()
basic + scale_fill_brewer()
basic + scale_fill_canva()
basic + scale_fill_colorblind()
basic + scale_fill_ft()


# manual colors 
basic + scale_fill_manual(values = c("#084081", "#0868ac", "#2b8cbe"))
basic + scale_fill_manual(values = c("#00441b", "#006d2c", "#238b45"))


# set font size and family globally 
basic + theme_gray(base_size = 16)
basic + theme_gray(base_size = 16, base_family = "Times New Roman")

# Font size for labels, tick labels, and legend separately
basic + theme(axis.title = element_text(size = 28)) # both axis 
basic + theme(axis.title.x = element_text(size = 28)) # x-axis 
basic + theme(axis.title.y = element_text(size = 28)) # y-axis 
basic + theme(axis.title = element_text(size = 16, family = "Times New Roman"))


# customize legend 
basic + theme(legend.position = "left")
basic + theme(legend.position = "top")
basic + theme(legend.position = "bottom")
basic + theme(legend.title = element_text(size = 28, family = "Times New Roman"))

# title, sub-title 
basic + theme(plot.title = element_text(size = 40))
basic + theme(plot.subtitle = element_text(size = 40))
basic + theme(plot.title = element_text(size = 40), 
              plot.subtitle = element_text(size = 30))

#put it together
basic<- data <- ggplot(data ,aes(x= Gender,fill = Gender))+ 
  geom_bar()+
  labs(
    x = "Gender",
    y = "Counts",
    title = "Distribution of Gender",
    subtitle = "Sample Subtitle",
    caption = "Data Source : Chiral")
basic+theme_gray(base_size = 16,base_family = "Arial")
ggsave("figures/exercise.png", dpi = 300)

data2 <- read.table("https://raw.githubusercontent.com/holtzy/data_to_viz/master/Example_dataset/1_OneNum.csv", header=TRUE)

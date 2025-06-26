## data visualization or charts
## 1. number of variables : one, two , more than two vars
## 2. data types: number, not a number (factor)

library(ggplot2)
library(dplyr)

## Q: one variable, number
## A: histogram

base <- ggplot(data = diamonds,
       mapping = aes(x=price))


## mapping vs. setting
base + geom_histogram(bins =10, 
                      fill="salmon" , 
                      color = "black")

## discrete = non-number = factor
## one variable, factor
ggplot(data = diamonds,
       mapping = aes(x = cut)) +
  geom_bar(fill = 'salmon' , 
           color = 'red',
           alpha = 0.75)

base2 <- ggplot(data = diamonds,
                mapping = aes(x = cut))


base2 
    + geom_bar(aes(fill = cut))


## two variables, number x number
## scatter plot (statistician love this)

set.seed(42)
small_diamonds <- diamonds %>% 
  sample_n(5000)


## overplotting
ggplot(data = small_diamonds, mapping = aes(y =carat, x = price)) +
  geom_point(alpha = 0.8 ,
             mapping = aes(colour = cut)) +
  theme_minimal()

## Two approaches to statistics
## [1] graphical [2] numerical

diamonds %>% 
  count(cut)

library(plotly)
plot1 <- ggplot(mtcars, aes(hp, mpg)) + 
  geom_point()

ggplotly(plot1)

## ggplot2: 2D
## add more variables
## mapped to aesthetic of the charts

ggplot(diamonds %>% sample_n(1500),
       aes(carat ,price)) + 
  geom_point(aes(color = clarity ,
                 shape = cut) ,
             size = 2) +
  theme_minimal()

## faceting breaks down big chart
## into small multiples



ggplot(diamonds %>% sample_n(5000) ,
       aes(x=carat ,y = price)) +
  geom_point() +
  facet_wrap(cut~clarity) ## 40 sub plots


## let's look at mtcars
ggplot(mtcars %>% filter(hp < 300), aes(hp, mpg)) + 
  geom_point() + 
  geom_smooth(method = "loess",
              se = TRUE,
              color ="red",
              fill = "gold") +
  theme_minimal() +
  ## add labels to chart
  labs(title = 'Scatter Plot HP x MPG',
       subtitle = "Positive relationship between two charts",
       caption =  "Data Sourec: mtcars dataframe",
       x = "horse power" ,
       y = "mile per gallon")


## dplyr + ggplot
diamonds %>% 
  filter(carat >= 0.5,
         price >= 4000,
         cut == "Ideal") %>% 
  count(clarity) %>% 
  ggplot(aes(clarity, n)) +
  geom_col()


## boxplot
ggplot(diamonds %>% sample_n(1000),
       aes(cut ,price)) +
  geom_boxplot() +
  theme_minimal()

## violine plot
ggplot(diamonds %>% sample_n(1000),
       aes(cut ,price)) +
  geom_violin() + theme_minimal()


## multiple datasets
premium_di <-  diamonds %>%  filter(cut == "Premium") %>% 
  sample_n(500)


good_di <- diamonds %>% 
  filter(cut == "Good") %>% 
  sample_n(500)


ggplot() +
  geom_point(data = premium_di, 
             mapping = aes(carat,price),
             color = "red") + 
  geom_point(data = good_di,
             mapping = aes(carat, price),
             color = "blue") + 
  theme_minimal()







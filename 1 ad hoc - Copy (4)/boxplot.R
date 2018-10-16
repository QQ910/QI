
####instll r packages first #############################
install.packages("ggiraph")
install.packages("ggplot2")

### call library
library(ggiraph)
library(ggplot2)

# create fictitious data

a <- runif(10)

b <- runif(12)

c <- runif(7)

d <- runif(15)


# data groups

group <- factor(rep(1:4, c(10, 12, 7, 15)))


# dataframe #### You need to read your own data set in from excel or csv file to replace the data set "mydata"

mydata <- data.frame(c(a,b,c,d), group)

names(mydata) <- c("value", "group")  ### you can change the name of "value" to your variable name 



# function for computing mean, DS, max and min values

min.mean.sd.max <- function(x) {
  
  r <- c(min(x), mean(x) - sd(x), mean(x), mean(x) + sd(x), max(x))
  
  names(r) <- c("ymin", "lower", "middle", "upper", "ymax")
  
  r
  
}


# ggplot code

p1 <- ggplot(mydata,aes(y = value, x = factor(group), fill=group ))+
  stat_summary(fun.data = min.mean.sd.max, geom = "boxplot" ) +
  # geom_jitter(position=position_jitter(width=.2), size=3, color="lightpink" ) + 
  stat_summary(fun.y=mean, geom="point", shape=23, size=10,  fill="blue") +
  ggtitle("Boxplot con media, 95%CI, valore min. e max.") + 
  xlab("Gruppi") + ylab("Valori")+geom_point_interactive(
    aes(tooltip =value , data_id = value), size = 2)
 
ggiraph(code = print(p1), hover_css = "cursor:pointer;fill:red;stroke:red;")









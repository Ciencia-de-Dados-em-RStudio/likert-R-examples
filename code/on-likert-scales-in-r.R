
# A simple graph would look like the following:
load(file = "./data/sample-likert-data.rda") #our data, see likert-data-generation.Rmd for more info
likert(Item~., cookie_data, ReferenceZero=3,  ylab = "Question", main = list("Cookie Data", x=unit(.62, "npc")), auto.key = list(columns = 2, reverse.rows = T))

#Saving Your Graph
# To save a graph created in the HH package you need to use functions such as png(). 
# You can read the documentation for yourself here. 
# Below is how I save images created via the HH package.

p1 <- likert(Item~., cookie_data, ReferenceZero=3,  ylab = "Question", main = list("Cookie Data", x=unit(.62, "npc")), auto.key = list(columns = 2, reverse.rows = T))

p1 #show image

## Save Image
png("./images/HH_basic.png",
    height=720, width=1080)
p1 
dev.off()

# Note that png defaults to unit of pixels. 
# If you wanted to use inches you would do the following:
dev.off()
pi <- likert(Item~., cookie_data, ReferenceZero=3,  ylab = "Question", main = list("Cookie Data", x=unit(.62, "npc")), auto.key = list(columns = 2, reverse.rows = T))

pi

png("./images/HH_basic_in.png",
    height=5, width=7, units = "in", res = 720)
pi
dev.off()
# When using inches you need to specify the resolution via res.

# Changing How Data Is Displayed

# Working with our cookie data frame, we can group the cookies via “Chunky” and “Smooth.” 
# We reflect this in our data by creating a vector that categorizes each cookie type as smooth or chunky and then using cbind to add this vector to the existing data frame.

## Create New df with Groups
type <- c("Chunky", "Chunky", "Smooth")
new_cookie_data <- cbind(cookie_data, type)
# Our new data frame (with Neutral omitted) looks like this:
View(new_cookie_data)

# We then use the following code to plot the new data frame:
## Plot Data
likert(Item~. | type, new_cookie_data, ReferenceZero=3, main = list("Cookie Data Grouped By Texture Of Cookie", x=unit(.6, "npc")), layout=c(1,2), auto.key = list(columns = 2, reverse.rows = T),
       scales=list(y=list(relation="free")), between=list(y=1), strip.left=TRUE, strip = FALSE,
       par.strip.text=list(cex=1.1, lines=2), ylab="Question")

# I tried to execute this with tidy via select() but the likert package refused to comply. 
# So, I am using some old fashioned indexing. Recall that data frames can be indexed [row, column] 
# There may be a more elegant way to do it but here is how I create my data frames for plotting:

library(dplyr)
library(tidyverse)
library(RColorBrewer)

load(file = "./data/sample-likert-data.rda") #our data, see likert-data-generation.Rmd for more info

## Rename Cols
dental_hyg  <- dental_hyg  %>% 
  rename("How Often Respondents Use Mouth Wash" = mouth_wash,
         "How Often Respondents Brush Their Teeth" = tooth_brush,
         "How Often Respondents Use Floss" = floss)

## New df for not grouped
# dh <- dental_hyg %>% select(-age)
dh <- dental_hyg %>% dplyr::select(-age)

## Not Grouped
# plot(likert(dh)) # basic not grouped
plot(likert(dh), legend.position="right")

## Grouped
# plot(likert(dental_hyg[,c(1:3)], grouping = dental_hyg[,4])) # basic grouped
plot(likert(dental_hyg[,c(1:3)], grouping = dental_hyg[,4]), legend.position="right")







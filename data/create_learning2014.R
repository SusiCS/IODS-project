# Susanne Csader: This is the Data wrangling of learning2014 (Chapter 2)//02.11.2020


# reading the data learning2014 from web into R

lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# dimension of the data set:

dim(lrn14) 

# the data frame (n/d) comprises n= 183 observations and d= 60 variables.


# structure of the data set:

str(lrn14)
#On the left side we can find the name of the variables (e.g. Aa, Ab). see chapter 2 link for variable description

#Attitude include 10 questions (Da + Db + Dc + Dd + De + Df + Dg + Dh + Di + Dj)-> needs to be scaled
lrn14$Attitude

# new column created by scaling (dividing through 10)

lrn14$attitude <- lrn14$Attitude/10

# new column
lrn14$attitude

# combining data using package: dplyr
library(dplyr)

# install.packages("devtools")
# devtools::install_github("tidyverse/dplyr")# if I want to update it delete the #

# deep, surface, strategic are a combination of different questions which has to be combined and returned the mean by each row

# collection alll questions of each variable in an new function
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# new deep column by averaging
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

# new column 'surf' by averaging
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

# new column 'stra' by averaging
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

# selecting new columns (7)
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")
learning2014 <- select(lrn14, one_of(keep_columns))

# to simplify to column names--> all names are in small letter
colnames(learning2014)
colnames(learning2014)[2]<- "age"
colnames(learning2014)[7]<- "points"
colnames(learning2014)

# we want only the student who have more than 0 points
learning2014 <- filter(learning2014, points > 0)

# to see if I have all observations 
dim(learning2014)

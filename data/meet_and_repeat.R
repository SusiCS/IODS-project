# SUSANNE CSADER
#EXERCISE 6 

#reading the data
BPRS<-read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep="", header=TRUE)
RATS<- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep="", header = TRUE)
#exploring the data
dim(BPRS) # 40 observations and 11 variables (treatment, subject, weeks)
str(BPRS)
summary(BPRS)

# We have 20 subject in treatment 1 group and 20 subjects in treatment 2.All are male. The treatment was conducted for 8 weeks. The measurement was the brief psychiatric rating scale (BPRS). 

dim(RATS) # 16 observations and 13 variables
str(RATS)
summary(RATS)
# We have in this data sets, data from 16 rats, which are in different groups (3) having different diets. Measured are the weight in gramm of the different weekdays (1,8,15,22,...)


# Converting the categorical data into factors
library(dplyr)
library(tidyr)
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

#converting to longitudinal data + extracting the data
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5))) #need only the week number


RATSL <-  RATS %>% gather(key = WD, value = Gram, -ID, -Group)
RATSL <-  RATSL %>% mutate(Time = as.integer(substr(WD,3,4))) # only the weekday number


# a look at the long form data
glimpse(BPRSL)
str(BPRSL)
# we have no 5 variables and 360 observations. The treatment group 1 or 2 (as a factor), the subject number, the weeks (this is the "most changed variable", all weeks are now in 1 column and not as before, as an own variable), the bprs results, and the weeks just as a number

glimpse(RATSL)
str(RATSL)
# also here we have 5 columns instead of 13 and 176 obervations. The ID column, the group column, the weekday group (also here are all weekdays are now in one column, (encompassed as one variable)), the gram column and the last column contains just the weekdays as an integer. 


# new data sets
write.csv(BPRSL,file = "C:/Users/susac/Documents/R/IODS-project/data/BPRSL.csv")
write.csv(RATSL,file = "C:/Users/susac/Documents/R/IODS-project/data/RATSL.csv")

#Susanne Csader
#continue of the human data:

# or my data : read.csv(human,file = "C:/Users/susac/Documents/R/IODS-project/data/human.csv")
# I only use the data from the link because it is easier with the abbrevations.

human <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt", sep  =",", header = T)
dim(human)
str(human)
names(human)
# we can see 195 observations and 19 variables, including the country name, HD index, maternal mortality rate,.... 

# GNI to numeric
library(tidyr)
library(stringr)
human$GNI <- str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric()

# columns to keep
library(dplyr)
keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")

# select the 'keep' columns
human <- dplyr::select(human, one_of(keep))
complete.cases(human)

# Removing rows with missing data/values
comp <- complete.cases(human)
human_neu<- filter(human, comp == TRUE)

# Remove observations relating to regions (the last 7 rows)

last <- nrow(human_) - 7
human_neu <- human_neu[1:last, ]

# Countries as row names
rownames(human_neu) <- human_neu$Country
human_neu <- dplyr::select(human_neu, -Country)

# check that dimension matches to 155, 8
dim(human_neu)


# new table sheet
write.csv(human_neu,file = "C:/Users/susac/Documents/R/IODS-project/data/human_neu.csv")

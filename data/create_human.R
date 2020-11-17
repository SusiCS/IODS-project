
# 1. reading the data
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
hd
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")
gii
# Metadata : http://hdr.undp.org/en/content/human-development-index-hdi
# technical data: http://hdr.undp.org/sites/default/files/hdr2015_technical_notes.pdf

#2. exploring the data sets
str(hd)
dim(hd)
summary(hd)

str(gii)
dim(gii)
summary(gii)

#3. shorten the names
hd1<-hd %>% 
  rename(
    HDI_R= HDI.Rank,
    Country = Country,
    HDI =Human.Development.Index..HDI.,
    LEB = Life.Expectancy.at.Birth ,
    EYE = Expected.Years.of.Education,
    MYE = Mean.Years.of.Education ,
    GNI= Gross.National.Income..GNI..per.Capita,
    GNI_R= GNI.per.Capita.Rank.Minus.HDI.Rank
  )

gii1<-gii%>%
  rename(
    GIIR = GII.Rank,
    Country =Country,
    GII = Gender.Inequality.Index..GII.,
    MMR = Maternal.Mortality.Ratio,
    ABR = Adolescent.Birth.Rate,
    PRP = Percent.Representation.in.Parliament,
    PSEE = Population.with.Secondary.Education..Female.,
    PSEM = Population.with.Secondary.Education..Male.,
    LFPRF = Labour.Force.Participation.Rate..Female.,
    LFPRM = Labour.Force.Participation.Rate..Male.
  )

# 4. new columns
library(tidyr)
gii1 <- mutate(gii1, PSE_R = PSEE/PSEM)
gii1 <-mutate(gii1, labr = LFPRF/LFPRM)
gii1

#5. join 2 data sets

hd_gii <- inner_join(hd1, gii1, by = "Country", suffix = c(".hd1", ".gii1"))
dim(hd_gii)
str(hd_gii)
human<- hd_gii

write.csv(human,file = "C:/Users/susac/Documents/R/IODS-project/data/human.csv")

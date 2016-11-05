babyboom = read.csv("babyboom.csv")

head(babyboom)
attach(babyboom)

summary(Sex)

female = c("F", "female", "girl","Female")
Sex %in% female

male = c("M", "male", "boy","Male")
Sex %in% male

#convert to "M" or "F" for Sex
SexToFM2 <- function(x){
  y <- rep.int(NA, length(x))
  y[ x %in% female ] <- "F"
  y[ x %in% male ] <- "M"
  y
} # end of SexToFM2 function

newSex = SexToFM2(babyboom$Sex)
newSex


CleanSex =SexToFM2(babyboom$Sex)
head(babyboom)
?rep
?tolower
#see vals side by side with cbind
cbind(as.character(Sex),CleanSex)
Sex = SexToFM2(Sex)
summary(Sex)
summary(Weight)
summary(Time)
typeof(Time)
Sex
Time
Time2 = as.numeric(as.character(Time)) 
Time = as.numeric(levels(Time))[Time] 
Time[1:5]
Time= Time2


summary(Time)
babyboom[which.max(Time),]
trunc(Time) == Time

which(   ( trunc(Time) == Time ) == F   )

##left off at #10
Time %% 100 

which(Time%%100 >59|Time>2400) # remainder greater than 59 not possible
Time[which(Time%%100 >59|Time>2400)] = NA

Time[14]
Time
##WEIGHT

POUND = 453.592
KG = 1000 
Weight
Weight/POUND
Weight/KG

summary(Weight)
which(Weight<1000)

Weight[which(Weight<1000)] = NA

which(is.na(Time))

Time3 = which(!is.na(Time))
Time3

sd(Time[Time3])

sd(Time,na.rm=T)

rm(mydata2)

mydata2 = data.frame(Time,Sex,Weight)
mydata3 = mydata2[complete.cases(mydata2),]#complete.cases adds only records without NA's or NULLS
mydata3
dim(mydata3) #37

rm(Time,Sex,Weight)

mydata3$morning = with(
  mydata3,
  Time<1200
) #add column to tell whether baby was born in morning

length(which(mydata3$morning==T))

sort(mydata3$Time) 
library(sqldf)

query = "select Weight from mydata3 order by Time"

sqldf(query)
library(reshape2) #used to transpose, look on p.200





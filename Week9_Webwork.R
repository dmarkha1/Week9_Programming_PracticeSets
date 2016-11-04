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

Time2 = as.numeric(as.character(Time))
Time = as.numeric(levels(Time))[Time] 
Time[1:5]

summary(Time)
babyboom[which.max(Time),]
trunc(Time) == Time

which(   ( trunc(Time) == Time ) == F   )

##left off at #10

#Learning R: Cleaning Data Week 9

install.packages("learningr")

head(english_monarchs)


install.packages("stringr")
library(stringr)

multiple_kingdoms <- str_detect(english_monarchs$domain, fixed(","))
english_monarchs[multiple_kingdoms,c("name","domain")]

multiple_rulers <- str_detect(english_monarchs$name, ",|and")

english_monarchs$name[multiple_rulers & !is.na(multiple_rulers)]
individual_rulers <- str_split(english_monarchs$name, ", | and ")
head(individual_rulers[sapply(individual_rulers, length) > 1])

th <- c("th", "ð", "þ")
sapply( #can also use laply from plyr
        th,
        function(th)
        {
        sum(str_count(english_monarchs$name, th))
        }
)##This doesn't work 

english_monarchs$new_name

gender <- c(
  "MALE", "Male", "male", "M", "FEMALE",
  "Female", "female", "f", NA
)
clean_gender <- str_replace(
  gender,
  ignore.case("^m(ale)?$"),
  "Male"
)
(clean_gender <- str_replace(
  clean_gender,
  ignore.case("^f(emale)?$"),
  "Female"
))

english_monarchs$length.of.reign.years <- with(
  english_monarchs,
  end.of.reign - start.of.reign
)

english_monarchs$length.of.reign.years

english_monarchs <- within(
  english_monarchs,
  {
    length.of.reign.years <- end.of.reign - start.of.reign
  }
)

english_monarchs

data("deer_endocranial_volume",package="learningr")
has_all_measurements <- complete.cases(deer_endocranial_volume) #tells of all rows not missing values
deer_endocranial_volume[has_all_measurements,]
na.omit(deer_endocranial_volume)#remove rows where there are missing vals

na.fail(deer_endocranial_volume) #throws error is any vals are missing
deer_wide <- deer_endocranial_volume[,1:5]#wide form of data frame

deer_wide

#long form of data frame uses reshape
install.packages("reshape2")
library(reshape2)

deer_long <- melt(deer_wide,id.vars = "SkullID")#just like transpose
deer_long
melt(deer_wide, measure.vars = c("VolCT", "VolBead", "VolLWH", "VolFinarelli"))
deer_wide_again <- dcast(deer_long, SkullID ~ variable) #converts back to long form

deer_wide_again #now in alphabetical order but same as deer_wide

install.packages("sqldf")#can manipulate data frames using SQL!!!
library(sqldf)

#how to select subset in R
subset(
  deer_endocranial_volume,
  VolCT > 400 | VolCT2 > 400,
  c(VolCT, VolCT2)
)

#how to do it with SQL 
query <-
  "SELECT
VolCT,
VolCT2
FROM
deer_endocranial_volume
WHERE
VolCT > 400 OR
VolCT2 > 400 
order by VolCT"
sqldf(query)
##This is a gamechanger for me!!!

#SORTING ####
x <- c(2, 32, 4, 16, 8)
sort(x)
sort(x, decreasing = TRUE)

##ORDERING###
order(x) #returns index of ordered vals
##
x[order(x)] #returns vals based on ordered index
##
identical(sort(x), x[order(x)])
##
# order is most useful for sorting data frames, where sort cannot be used directly.
# 
# The rank function gives the rank of each element in a dataset, providing a few ways of
# dealing with ties:
(x <- sample(3, 7, replace = TRUE))

rank(x)
## [1] 1.5 3.5 1.5 6.0 6.0 6.0 3.5
rank(x, ties.method = "first")
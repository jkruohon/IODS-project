#Author: Juho Ruohonen. Date: 2017-Feb-4. IODS Exercise 3

#Read both datasets into R:

library(readr); student_mat <- read_delim("C:/Users/juho/Desktop/IODS-project/IODS-project/data/student-mat.csv", ";", escape_double = FALSE, trim_ws = TRUE)
student_por <- read_delim("C:/Users/juho/Desktop/IODS-project/IODS-project/data/student-por.csv", ";", escape_double = FALSE, trim_ws = TRUE)

#Explore both datasets:
str(student_mat); View(student_mat)
str(student_mat); View(student_por)

#Merge these datasets using the following sequence of columns as student identifier: "school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery","internet":

StudentIdentificationColumns<-c("school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery","internet")
mat_por<-merge.data.frame(student_mat, student_por, by = StudentIdentificationColumns, suffixes = c(".mat",".por"))

#Get the names of the columns NOT used for student identification (these are the ones that have both a .mat and a .por version in mat_por):

non.id.columns <- setdiff(colnames(student_mat), StudentIdentificationColumns)

#Create a new data frame which, for now, consist of the student identification columns only:

AlcoholConsumption <- mat_por[StudentIdentificationColumns]

#For each of the non-student-identification columns (the ones that have a .mat and .por version in mat_por)...

for (variable in non.id.columns){
  two.columns <- mat_por[which(startsWith(colnames(mat_por), variable))]
  
  if(startsWith(colnames(two.columns)[1],"studytime")){AlcoholConsumption[variable]<-two.columns[,1]}else{
  #if the data is numeric, take the means of each pair of .mat and .por values and assign them to the corresponding new column in AlcoholConsumption:
  
  if(is.numeric(two.columns[[1]])){
    AlcoholConsumption[variable] <- rowMeans(two.columns)}
  
  #if not, then take just the first of those two values and assign it to the corresponding new column in AlcoholConsumption:
  
  else{
    AlcoholConsumption[variable] <- two.columns[,1]}
}}

#Create a new column reporting each student's overall level of alcohol use:

AlcoholConsumption$alc_use <- rowMeans(AlcoholConsumption[c("Dalc","Walc")])

#Create a logical (TRUE/FALSE) column reporting whether a given student's alcohol use is high (greater than 2)

AlcoholConsumption$high_use <- AlcoholConsumption$alc_use > 2

#Survey the shiny new data frame:
str(AlcoholConsumption); View(AlcoholConsumption)

#Output this data frame to a tab-delimited textfile (We linguists like this format because commas and semicolons are often meaningful elements in our data and therefore not available as separators.)
write.table(AlcoholConsumption,file="drunkards.txt", quote=F, col.names=T, row.names=F, sep="\t")



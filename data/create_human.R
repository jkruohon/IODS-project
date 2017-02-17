#Author: Juho Ruohonen. Date: 2017-Feb-17. IODS Exercise 4

#Set working directory and import the datasets:
setwd(dir="c:/users/juho/desktop/IODS-project/IODS-project/data")
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

#Look at the datasets and show some summaries:
str(gii)
str(hd)
summary(gii$Adolescent.Birth.Rate)
summary(hd$Mean.Years.of.Education)

#Rename all variables (the columns of both datasets) more succinctly:
colnames(gii)
colnames(gii)[3:10]<-c("GII","MaterMort","TeenMum","WomenInParl","EduWomen","EduMen","WorkingWomen","WorkingMen")
colnames(hd)
colnames(hd)[3:8]<-c("HDI","LifeExpect","Exp.EduYrs","MeanEduYrs","GNI","GNIminusHDIrank")

#Create the two new variables for the 'gii' dataset as instructed:
gii$EduRatio<-gii$EduWomen/gii$EduMen
gii$WorkRatio<-gii$WorkingWomen/gii$WorkingMen

#Join the two datasets using the Country for identification:
human<-merge.data.frame(hd,gii,by="Country")

#Export the merged dataset:
write.table(human,file="human.txt",sep="\t",col.names=T,row.names=F,quote=F)


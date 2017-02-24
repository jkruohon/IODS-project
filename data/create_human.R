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

#Part 2 begins: 2017-Feb-23. We have created the 'human' dataset by first renaming the variables of, and then merging, two datasets called 'gii' and 'hd'. Now we pick up from where we left off.

#Remove the thousand-separating commas from variable GNI and convert it into numeric format: !!NB!! I don't use the 'stringr' library here. I use 'gsubfn', which is another pattern matching and manipulation library that I'm already accustomed to. Don't hate!
library("gsubfn", lib.loc="~/R/win-library/3.3")
human$GNI<-as.numeric(gsub(",","",human$GNI,perl=T))

#Remove all columns except the ones corresponding to "Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F". In my case, I'll have to rename them too, on order that they match the names specified in the new instructions:
human<-human[,c("Country","EduRatio","WorkRatio","Exp.EduYrs","LifeExpect","GNI","MaterMort","TeenMum","WomenInParl")]
names(human)<-c("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")

#Remove all rows with missing values, also known as NAs.
human<-human[which(complete.cases(human)),]

#Remove all rows that describe entire regions or continents rather than countries. This is not entirely simple because those rows appear to be scattered across the dataset rather than neatly grouped together. We will have to manually scan the Country column, identify the non-countries, and then filter those rows out:
human<-human[human$Country!="Arab States" & human$Country!="East Asia and the Pacific" & human$Country!="Europe and Central Asia" & human$Country!="Latin America and the Caribbean" & human$Country!="South Asia" & human$Country!="Sub-Saharan Africa" & human$Country!="World",]

#Then we will use the Countries column as the row names, and remove that column:
row.names(human)<-human$Country
human<-human[,which(names(human)!="Country")]

#Output the new file. Remember to preserve the row names now that they contain valuable information!
write.table(human,file="human.txt",sep="\t",col.names=T,row.names=T,quote=F)

#author: Juho Ruohonen, date: 17/2/2, description: theme2 exercise 1

learning2014 <- read_delim("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", "\t", escape_double = FALSE, trim_ws = TRUE) 
#Import the dataset into R
View(learning2014) #view it

#As usual, the rows represent Units of Observation (in this case, individual students). "Points" is likely the dependent variable. 
#The rest are independent (explanatory) variables. The columns with weird names are probably different sections/questions of the survey. 
#Likely, "Attitude" is a combination variable calculated from the sum or mean of all or some of these questions.

#!!NB!! I did not use the dplyr library for the following tasks!
#I find R's built-in subsetting function [] to be quite adequate for the job.
#So if you expected to see dplyr used here and don't understand the code, 
# try it out in RStudio (or wherever you want) to see that it works.

lrn2014<-learning2014[learning2014$Points!=0,] #exclude rows where Points is zero

lrn2014$Deep<-rowMeans(lrn2014[,c("D03","D11","D19","D27","D07","D14","D22","D30","D06","D15","D23","D31")]) 
#Create new combination variable Deep as instructed.
lrn2014$Stra<-rowMeans(lrn2014[,c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")]) 
#Create combination variable Stra as instructed.
attach(lrn2014); lrn2014$Surf<-(SU02+SU10+SU18+SU26+SU05+SU13+SU21+SU29+SU08+SU16+SU24+SU32)/12 
#Create combination variable Surf with a slightly different method this time!

attach(lrn2014) #Attach this new dataframe, so that its columns can be accessed directly by name.
lrn2014_only7<-data.frame(gender,Age,Attitude,Deep,Stra,Surf,Points) 
#Make a new dataframe with only the 7 variables specified in the instructions.

setwd(dir=choose.dir()) 
#Set working directory interactively. This only works in Windows! It is now set to my local IODS-project folder.

write.table(lrn2014_only7, file="lrn2014_only7.txt",quote=F, col.names=T, row.names=F, sep="\t") 
#Output this dataframe a tab-delimited textfile.

lrn2014_only7_copy <- read_delim("C:/Users/juho/Desktop/IODS-project/IODS-project/lrn2014_only7.txt","\t", escape_double = FALSE, trim_ws = TRUE)
#Read a copy of the outputted dataframe back into R as lrn2014_copy. 
#Although the above is the code that did it, in truth I simply used RStudio's Import Dataset menu (top right)
#and chose the file and settings interactively.
#It is much more convenient than typing!

str(lrn2014_only7_copy); head(lrn2014_only7_copy) #Yeah yeah, it looks fine. 
#I definitely prefer using the view() function since it lets you view and browse it though.



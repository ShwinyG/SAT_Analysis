#This code is to look at relatotions between SAT score and accept rate

#Setting Working Directory
setwd("~/Documents/R Coding/Input Files")

#Read the SAT Score file and admission file number
satscore<-read.csv("/Users/shwin/Documents/R Coding/Input Files/SAT_Score.csv",
                   stringsAsFactors = FALSE)

accrate<-read.csv("/Users/shwin/Documents/R Coding/Input Files/Accept_Rate.csv",
                  stringsAsFactors = FALSE)

#Examining Data Frame
head(satscore)
head(accrate)

#Summary of Data Frame
summary(satscore)
summary(accrate)

#Change the datatype of all desired column
satscore$university<-as.integer(satscore$university)
satscore$sat_math_25<-as.numeric(satscore$sat_math_25)
satscore$sat_math_75<-as.numeric(satscore$sat_math_75)
satscore$sat_cr_25<-as.numeric(satscore$sat_cr_25)
satscore$sat_cr_75<-as.numeric(satscore$sat_cr_75)
accrate$university<-as.integer(accrate$university)
accrate$admissions_total<-as.integer(accrate$admissions_total)
accrate$applicants_total<-as.integer(accrate$applicants_total)

#Merge SAT Scores and Admission data into one data frame
satmaindata<-cbind(satscore,accrate)
head(satmaindata)
#Removes Duplicate columns
satmaindata<-satmaindata[,-c(8:10)]
head(satmaindata)
#Add total SAT Score column and acceptance rate column
satmaindata$totalsatscores<-satmaindata$sat_math_75+satmaindata$sat_cr_75
satmaindata$arate<-satmaindata$admissions_total/satmaindata$applicants_total
head(satmaindata)

#Subset the main data frame according to years
data2014<-subset(satmaindata,satmaindata$year==2014)
data2015<-subset(satmaindata,satmaindata$year==2015)
data2016<-subset(satmaindata,satmaindata$year==2016)

#Subetting data by 1300 sat score and above colleges
subdata2014<-subset(data2014, data2014$totalsatscores>=1350)
subdata2015<-subset(data2015, data2015$totalsatscores>=1350)
subdata2016<-subset(data2016, data2016$totalsatscores>=1350)

#Find correlation between SAT scores and accept rates
cor2014<- cor(subdata2014$totalsatscore, data2014$arate)
cor2015<-cor(subdata2015$totalsatscore, data2015$arate)
cor2016<-cor(subdata2016$totalsatscore, data2016$arate)


#Visualize SAT Scores vs Acceptance Rate
par(mfrow = c(1,3))
plot(subdata2014$totalsatscore, subdata2014$arate, xlab = "SAT Score",
     ylab="Acceptance Rate", main="2014")
text(1550,0.85, round(cor2014,digits=2))
abline(lm(subdata2014$arate~subdata2014$totalsatscores),col="red")
plot(subdata2015$totalsatscore, subdata2015$arate, xlab = "SAT Score",
     ylab="Acceptance Rate", main="2015")
text(1550,0.85, round(cor2015,digits=2))
abline(lm(subdata2015$arate~subdata2015$totalsatscores),col="red")

plot(subdata2016$totalsatscore, subdata2016$arate, xlab = "SAT Score",
     ylab="Acceptance Rate", main="2016")
text(1550,0.85, round(cor2016,digits=2))
abline(lm(subdata2016$arate~subdata2016$totalsatscores),col="red")

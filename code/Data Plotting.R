library("ggplot2")
library(data.table)


cleaned <- fread("Data_cleaned.csv")

ref_total<-cleaned[, list(Refugees_Total=sum(Refugees_from_Syria)), by=Year]
death_total<-cleaned[, list(Deaths_Total=sum(Deaths_in_Syria)), by=Year]
ref_deaths<-merge(ref_total, death_total, by="Year")
ref_deaths
################################################
#PLOT 1
# Plot 1) Calculate correlation between deaths in Syria and total refugees
cor(ref_deaths$Refugees_Total,ref_deaths$Deaths_Total) #Correlation is 0.853
ggplot(ref_deaths,aes(x=Year))+geom_line(aes(y=Refugees_Total,colour="Refugees_Total"))+geom_line(aes(y=Deaths_Total, colour="Deaths Total"))+
  scale_y_continuous(breaks=seq(0, 4000000, 500000), name="Total refugee flow to Europe/Deaths in Syria") +
  scale_x_continuous(name="Year t")+labs(title="Correlation between total refugee flows and violence rate in Syria")+labs(color="Variable")

################################################
#PLOT 2
# Plot 2) Proportion of GDP and incoming refugees
#x-Axis: Average GDP
#y-Axis: Average Refugees
GDP<-fread("GDP_Europe_2010-2016.csv")
colnames(GDP)[colnames(GDP) %in% cleaned$Country==FALSE]

# calculate mean GDP over all years
GDP_from_2012<-GDP[Year>=2012,] #subset from 2012 onwards
mean_GDP<-data.frame(colMeans(GDP_from_2012, na.rm = FALSE, dims = 1))
colnames(mean_GDP)<-"avgGDP"
mean_GDP
mean_GDP$Country<-rownames(mean_GDP)
#delete first column
mean_GDP<-mean_GDP[-1,]
#Plot the average GDP
ggplot(mean_GDP, aes(reorder(Country, avgGDP) , avgGDP,  fill=reorder(Country, avgGDP))) + 
  coord_flip() +
  geom_bar(stat="identity", width=.90) 
#Plot the average number of refugees per Country
ref_country_avg<-cleaned[, list(Refugees_mean_Country=mean(Refugees_from_Syria)), by=Country]
ref_country_avg
barplot(ref_country_avg$Refugees_mean_Country)

ref_deaths<-merge(ref_total, death_total, by="Year")
hist(mean_GDP$avgGDP)

#
colnames(GDP)[colnames(GDP) %in% cleaned$Country==FALSE]
####
clean<-read.csv(file="Data_cleaned.csv", sep=",",header=TRUE)
levels(clean$Country)
#CHANGE in GDP data set:
"UnitedKingdom"        "Russia"               "CzechRepublic"        "Lithuania"            "Serbia"               "BosniaandHerzegovina"
"Macedonia"            "Moldova"              "SanMarino" 
####
mean_GDP$Country[which(mean_GDP$Country=="UnitedKingdom" )]<-"United Kingdom"
mean_GDP$Country[which(mean_GDP$Country=="CzechRepublic" )]<-"Czech Rep."
mean_GDP$Country[which(mean_GDP$Country=="Serbia"  )]<-"Serbia and Kosovo (S/RES/1244 (1999))"
mean_GDP$Country[which(mean_GDP$Country=="BosniaandHerzegovina" )]<-"Bosnia and Herzegovina" 
mean_GDP[mean_GDP$Country %in% cleaned$Country==FALSE,]

#Merge mean_GDP and refugee data by Country (inner join)
GDP_refFlow<-merge(mean_GDP, ref_country_avg, by="Country" , all=FALSE)

GDP_refFlow<-GDP_refFlow[!(GDP_refFlow$Country=="Turkey"),]

ggplot(GDP_refFlow, aes(reorder(Country, avgGDP) ,   fill=reorder(Country, avgGDP))) + 
  coord_flip() +  scale_y_continuous(breaks=seq(0, 50000, 1000), name="Average GDP from 2012 to 2015") +
  scale_x_discrete(name="European country") +
  geom_bar(aes(y= avgGDP),stat="identity", width=.90) +labs(title="Average GDP in European countries from 2012-2015")+labs(color="Country")#

################################################
#PLOT 3
# calculate proportion of Refugees/Overall GDP
GDP_refFlow$proportion<-GDP_refFlow$Refugees_mean_Country/GDP_refFlow$avgGDP
GDP_refFlow

#PLOT Proportions
ggplot(GDP_refFlow, aes(reorder(Country, proportion) ,   fill=reorder(Country, proportion))) + 
  coord_flip() +  scale_y_continuous(breaks=seq(0, 130, 10), name="Refugee flow divided by GDP averaged from 2012 to 2015") +
  scale_x_discrete(name="European country") +
  geom_bar(aes(y= proportion),stat="identity", width=.90) +labs(title="Total refugee flow divided by GDP averaged from 2012 to 2015")+labs(color="Country")#



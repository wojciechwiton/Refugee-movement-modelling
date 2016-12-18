library("ggplot2")
library(data.table)


cleaned <- fread("Data_cleaned.csv")
Refugees_from_Syria<-read.csv("Syrian_Refugees_2000-2015_toEU.csv",skip=2, header = TRUE)




Refugees_from_Syria$Country...territory.of.asylum.residence
Refugees_from_Syria[!Refugees_from_Syria$Country...territory.of.asylum.residence=="Turkey"]
ref_total<-cleaned[, list(Refugees_Total=sum(Refugees_from_Syria)), by=Year]
death_total<-cleaned[, list(Deaths_Total=sum(Deaths_in_Syria)), by=Year]
ref_deaths<-merge(ref_total, death_total, by="Year")
ref_deaths
################################################
#PLOT 1
# Plot 1) Calculate correlation between deaths in Syria and total refugees
deaths$Deaths
ref_deaths$Deaths_Total<-1
ref_deaths$Deaths_Total<-deaths$Deaths
deaths$Deaths
ref_deaths
cor(ref_deaths$Refugees_Total,ref_deaths$Deaths_Total) #Correlation is 0.853
ggplot(ref_deaths,aes(x=Year))+geom_line(aes(y=Refugees_Total,colour="Total no. of Refugees"))+geom_line(aes(y=Deaths_Total*34, colour="Total no. of Deaths"))+
  scale_y_continuous(breaks=seq(0, 4000000, 500000), name="Total refugee flow to Europe",sec.axis = sec_axis(~ . * (1/34), breaks=seq(0,50000,10000), name = "Deaths in Syria")) +
  scale_x_continuous(name="Year t")+labs(title="Correlation between total refugee flows and violence rate in Syria")+labs(color="Variable")
train<-
ref_deaths
simple<-lm(Refugees_Total~Year,ref_deaths[1:5])
plot(simple)
predict(2015,simple)
predict(simple,ref_deaths[1:5])
predicted<-predict(simple,ref_deaths[1:6])
predicted
ref_deaths$Refugees_Total[6]
ggplot(ref_deaths, aes(x=Year))+geom_line(aes(y=predicted, colour="OLS Regression line"), lty=10)+geom_point(aes(y=Refugees_Total, colour="Historic migration flows"),size=3)+
  scale_y_continuous(breaks=seq(0, 4000000, 500000), name="Syrian refugee flows to Europe")+
  geom_label(label=paste("predicted value for 2015=",round(predicted[6],0)),aes(x=Year[6]-0.5, y=predicted[6]+150000))+
  geom_label(label=paste("true value for 2015=",ref_deaths$Refugees_Total[6]),aes(x=Year[6]-0.5, y=ref_deaths$Refugees_Total[6]-150000))+
  geom_point(aes(x=Year[6], y=predicted[6]), colour="blue", size=6)+labs(color="Legend",size=40)
(ref_deaths$Refugees_Total[6]-predicted[6])/ref_deaths$Refugees_Total[6]
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

# PLOT 4
library(ggplot2)
library(grid)
install.packages("rworldmap")
library(rworldmap)

# Get the world map
worldMap <- getMap()
worldMap
# Member States of the European Union
europeanUnion <- c("Austria","Belgium","Bulgaria","Croatia","Cyprus",
                   "Czech Rep.","Denmark","Estonia","Finland","France",
                   "Germany","Greece","Hungary","Ireland","Italy","Latvia",
                   "Lithuania","Luxembourg","Malta","Netherlands","Poland",
                   "Portugal","Romania","Slovakia","Slovenia","Spain",
                   "Sweden", "Switzerland","United Kingdom")
# Select only the index of states member of the E.U.
indEU <- which(worldMap$NAME%in%europeanUnion)
# Extract longitude and latitude border's coordinates of members states of E.U. 
europeCoords <- lapply(indEU, function(i){
  df <- data.frame(worldMap@polygons[[i]]@Polygons[[1]]@coords)
  df$region =as.character(worldMap$NAME[i])
  colnames(df) <- list("long", "lat", "region")
  return(df)
})
print(europeCoords)

europeCoords <- do.call("rbind", europeCoords)
# Add some data for each member
europeanUnion
europeanUnionTable
#value <- sample(x = seq(0,3,by = 0.1), size = length(europeanUnion),
                replace = TRUE)
#europeanUnionTable <- data.frame(country = europeanUnion, value = value)
europeanUnionTable<-data.frame(country = europeanUnionT$Country, value = europeanUnionT$Refugees_from_Syria)
europeCoords$value <- europeanUnionTable$value[match(europeCoords$region,europeanUnionTable$country)]
# Plot the map
P <- ggplot() + geom_polygon(data = europeCoords, aes(x = long, y = lat, group = region, fill = value),
                             colour = "black", size = 0.1) + coord_map(xlim = c(-13, 35),  ylim = c(32, 71))
#P <- P + scale_fill_gradient(name = "Growth Rate", low = "#FF0000FF", high = "#FFFFF0FF", na.value = "grey50")

P

P <- P + theme(#panel.grid.minor = element_line(colour = NA), panel.grid.minor = element_line(colour = NA),
  #panel.background = element_rect(fill = NA, colour = NA),
  axis.text.x = element_blank(),
  axis.text.y = element_blank(), axis.ticks.x = element_blank(),
  axis.ticks.y = element_blank(), axis.title = element_blank(),
  #rect = element_blank(),
  plot.margin = unit(0 * c(-1.5, -1.5, -1.5, -1.5), "lines"))
P <- P + scale_fill_gradient(name = "Incoming Syrian refugees", low = "green3", high = "firebrick3", na.value = "grey50", trans="log")
P <- P + scale_fill_gradient(name = "Incoming Syrian refugees", low = "green3", high = "firebrick3", na.value = "grey50")

P
##############################
# Problem with Lithuania so far, no value given...
cleaned[Year=="2015"]$Country
cleaned[Year=="2015"]$Country %in% europeanUnion
cleaned[Year=="2015"][!cleaned[Year=="2015"]$Country %in% europeanUnion]
y2015<-cleaned[Year=="2015"][cleaned[Year=="2015"]$Country %in% europeanUnion]

europeanUnion$Country
europe<-data.frame(Country=europeanUnion$Country)
europe
y2015
europeanUnionT<-merge(europe, y2015, by="Country")
europeanUnionTable<-data.frame(country = europeanUnionT$Country, value = europeanUnionT$Refugees_from_Syria, )
europeanUnionTable


exp(-0.378)



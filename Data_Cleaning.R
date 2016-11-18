#Build cleaned dataset
########################################################################################################
# Start with refugee flows from Syria to European countries:
refugees_all<-read.csv(file="Syrian_Refugees_2000-2015_toEU.csv",skip=2, header=TRUE)
refugees <- refugees_all[,c(1,2,11)]
colnames(refugees)<-c("Year","Country","Population")

########################################################################################################
#add Total number of deaths in Syria
deaths<-read.csv(file="Total_deaths_Syria_2008-2015.csv", header=TRUE, sep=";")
colnames(deaths)<-c("Year","Deaths")
deaths[1,]=c(2010,0) #fill NA in 2010 by 0
#Optional: subset only years >=2010
refugees_2010 <- refugees[refugees[,"Year"]>=2010,] #subset only for years from 2010 onwards
refugees_year<-refugees_2010
#merge(refugees_year, deaths, by="Year")
refugees_viol<-merge(x = refugees_year, y = deaths, by = "Year", all.x = TRUE) # left outer join to not loose 2010

########################################################################################################
#add unemployment
unemployment<-read.csv(file="Unemployment_rate_2000-2015_EU28.csv")
colunemp <- colnames(unemployment)
colunemp[1]<- "Country"
colunemp[6] <- "Year"
colnames(unemployment) <- colunemp
unemployment<-unemployment[,c(1,6,7)] #extract country, year and value
levels(unemployment$Country)<-c("Austria","Belgium", "Czech Rep.", "Germany", "Denmark", "Spain", "Estonia", "Finland", 
                                "France", "United Kingdom", "Greece", "Hungary", "Ireland", "Italy", "Luxembourg", "Latvia", "Netherlands",
                                "Poland", "Portugal", "Slovakia", "Slovenia", "Sweden")
refugees_unempl_viol<-merge(x = refugees_viol, y = unemployment, by.x= c("Year","Country"), by.y=c("Year","Country"), all.x = TRUE) # left outer join to not loose 2010
colnames(refugees_unempl_viol)[5]<-"Unemployment"
#Fill NAs in unemployment with mean of unemployment
summary(refugees_unempl_viol$Unemployment)#mean=10.16
refugees_unempl_viol[is.na(refugees_unempl_viol$Unemployment),"Unemployment"]<-10.16

#END STEPS
cols<-colnames(refugees_unempl_viol)
cols[4] <- "Deaths_in_Syria"
cols[3] <- "Refugees_from_Syria"
colnames(refugees_unempl_viol) <- cols
?write.csv()
row.names(refugees_unempl_viol)





########################################################################################################
#add foreigner information
foreigners<-read.csv(file="Foreign_population_EU28_2014.csv",skip=0)
View(foreigners)
levels(foreigners$CITIZEN)
f <- foreigners[(foreigners$SEX=="Total" & foreigners$CITIZEN=="Syria"),]
f <- f[f$Value!=":",]
f$Value==":" #NAs are :
View(f)
#### change country labels for merge
levels(f$GEO)
levels(f$GEO) %in% levels(refugees_unempl_viol$Country) #we have to change labels here
levels(unemployment$Country)
f_countries <- levels(f$GEO)
f_countries[!levels(f$GEO) %in% levels(refugees_unempl_viol$Country)] #print those labels that have to be changed
levels(refugees_unempl_viol$Country)
f_countries[c(8,12,14)]<-c("Czech Rep.","Russian Federation","Germany"  )
"Czech Republic" --> "  "Czech Rep." "
"Former Yugoslav Republic of Macedonia, the"  --> "Russian Federation"  
"Germany (until 1990 former territory of the FRG)" -->   "Germany" 
levels(f$GEO) <- f_countries
f<-f[,c(1,2,7)] #select  TIME           GEO  Value
refugees_unempl_viol_foreign<-merge(x = refugees_unempl_viol, y = f, by.x= c("Year","Country"), by.y=c("TIME","GEO"), all.x = TRUE) # left outer join to not loose 2010
View(refugees_unempl_viol_foreign)

´#####


#WRITE THE TABLE AS CSV-FILE
write.csv(refugees_unempl_viol_foreign, file="Data_cleaned.csv", sep=",")
#Test if it worked
cleaned<-read.csv(file="Data_cleaned.csv", sep=",",header=TRUE)
View(cleaned)
#View(refugees_unempl_viol)


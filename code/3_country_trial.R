############### Split process in two steps, because independent decisions whether to leave or not...
###To Do:
#1) Integrate number of foreigners per country into the model --> significant?
#2) Work with refugee demographics:
# 3) Idea: Simulate population of Syria
# 4) Run regression model with demographics: Prob_of_leaving_country <- Age + Gender + Time + Violence_in_country
library(stats)
install.packages("ggplot2")#

####################### Plots of death and time series data
refugees_all2<-refugees_all
refugees_all<-read.csv(file ="Syrian_Refugees_2000-2015_toEU.csv", header=TRUE, skip=2, sep=",")
refugees_all$Total.Population=="Germany"
cumsum(refugees_German$Total.Population)
plot(refugees_German$Year, cumsum(refugees_German$Total.Population))
refugees_German=refugees_all[refugees_all$Country...territory.of.asylum.residence=="Germany",]
plot(refugees_German$Year, refugees_German$Total.Population, type="l") #German time series
plot(deaths, type="l", col="red") #Deaths over year
cor(tail(refugees_German$Total.Population,6), deaths$Deaths)
cor(tail(refugees_German$Total.Population,6), deaths$Deaths)
#######################
#Model for Germany
GDP<-read.csv(file="GDP_Europe_2010-2016.csv", sep=";")
GDP_Germany=GDP[GDP$Country=="Germany",]
GDP_Germany
GDP_Germany<-t(GDP_Germany[-1])
GDP_Germany<-c(3418.371, 3755.549,3535.199,3831.427,3859.547,3467.78)
refugees_German=refugees_unempl_viol_foreign[refugees_unempl_viol_foreign$Country=="Germany",]
refugees_German$Intervening_opps<-rep(475,6)
refugees_German

colnames(refugees_unempl_viol_foreign)
refugees_German$GDP=GDP_Germany
fit_Germany<-lm(Refugees_from_Syria~Deaths_in_Syria+GDP+Competing+Intervening_opps, data=refugees_German)
fit_Germany<-lm(Refugees_from_Syria~Deaths_in_Syria+GDP+Intervening_opps, data=refugees_German)

summary(fit_Germany)

refugees_German$Refugees_from_Syria
refugees_German$Competing<-c(0,  13208, 14868,24151,  31819,  70585 )
refugees_German
#######################
#######################
#Model for Germany+Austria
GDP_Austria=GDP[GDP$Country=="Austria",]
GDP_Austria
GDP_Austria<-c(390.383, 429.493,407.801,428.456,374.124,384.799)

refugees_Austria=refugees_unempl_viol_foreign[refugees_unempl_viol_foreign$Country=="Austria",]
refugees_Austria$Intervening_opps<-rep(117,6)
refugees_Austria$GDP<-GDP_Austria
refugees_Austria
colnames(refugees_Austria)
colnames(refugees_German)
#%%
GA<-rbind(refugees_German,refugees_Austria)
refugees_Austria$Refugees_from_Syria
refugees_Austria$Competing<-c(0,  976 , 1359 , 2369 , 4309 , 2748 )
######
GA
###################

Refugees_from_Syria~Deaths_in_Syria
nls(y~a*x/(b+x))
#######
nls_fit<- nls(Refugees_from_Syria ~ k * Deaths_in_Syria^b *GDP^a , data = GA, start = list(k=1, a=1, b=1))
summary(nls_fit)
####not working
nls_fit<- nls(Refugees_from_Syria ~ k * Deaths_in_Syria^b *GDP^a *c*Intervening_opps , data = GA, start = list(k=1, a=1, b=1, c=1))
summary(nls_fit)
#########
nls_fit<- nls(Refugees_from_Syria ~ k * Deaths_in_Syria * GDP^a * Intervening_opps^b * Competing^c , data = GA, start = list(k=1, a=1, b=1,c=1))

summary(nls_fit)
####
fit_GA<-lm(Refugees_from_Syria~Deaths_in_Syria+GDP+Intervening_opps+Competing, data=GA)
summary(fit_GA)
######################

###
load(binhf)
shift(deaths$Deaths)
deaths$Deaths
############################

######## THREE COUNTRIES ONLY --> SKIP

refugees<-read.csv(file="three_country_example.csv",skip=2)
View(refugees)
foreigners<-read.csv(file="Foreign_population_EU28_2014.csv",skip=2)
View(foreigners)
library(ggplot2)
# Plot the historic flows in respective countries
colnames(refugees)
refugees[,2]=="Germany"
#Germany<-subset(refugees, refugees[,2]=="Germany")
countries<-split(refugees,refugees[,2] )
Germany<-countries$Germany
Austria<-countries$Austria
plot(Austria$Year,Austria$Total.Population, type="l")
plot(Germany$Year,Germany$Total.Population, type="l")

#predict Refugee Flow with historical Time Series Data

refugees_all
refugees_all$Sum<-NULL

levels(refugees_all$Country...territory.of.asylum.residence)

str(refugees_all)
refugees <- refugees_all[,c(1,2,11)]
str(refugees)
colnames(refugees)<-c("Year","Country","Population")
# Split data by refugees
countries<-split(refugees,refugees[,2] )
countries[1]
str(countries)
levels(refugees[,2] ) #All countries here in the dataset --> relevant for merge

########################################################################################
#fit a linear model for the first country --> R^2 already 0.45!
# for one country
countries[1,"Year"]
Albania<-as.data.frame(countries[1])
colnames(Albania)
regression_model<-lm(Albania$Albania.Total.Population~Albania$Albania.Year)
summary(regression_model)

x.predictors
#fit a linear model for every country
linear_fit<-function(x.predictors, y.predictors){
  model<-lm(y.predictors~x.predictors)
  model
}

#Albania_fit<-linear_fit(Albania$Albania.Year,Albania$Albania.Total.Population)
#summary(Albania_fit)
countries <- lapply(countries, as.data.frame)
countries$Albania$Year
refugees[refugees[,2]=="Albania",]

########################################################################################
# One model per country
j=0
for (i in levels(refugees$Country)){
  #print (i)
  country<-(refugees[refugees[,2]==i,])
  model<-linear_fit(country$Year, country$Population)
  print (i)
  print (summary(model))
  #lm(y.predictors~x.predictors)
  #j=j+1
}

########################################################################################
# Idea: common model for all countries with Country as normal predictor
refugees[,-3] # Goal: Possibility of different coefficients per Country
head(refugees_all,2)
model<-lm(Population~ . ,data=refugees)
summary(model)

#Incorporate year as factor into the model: <- Assumption: 2015 will be significant
refugees_2010 <- refugees[refugees[,"Year"]>=2010,] #subset only for years from 2010 onwards
refugees_year<-refugees_2010
refugees_year$Year<-as.factor(refugees_year$Year)
str(refugees_year$Year)
refugees_year
model2<-lm(Population ~ . , data=refugees_year)
summary(model2) ## Adjusted R-squared:  0.3442
# Idea: Add interactions?

#Incorporate year as date into the model:
install.packages("lubridate")
library(lubridate)
# Years <- as.Date(refugees_2010$Year, format="%Y") #does not work!

# Idea: common model for all countries, year quadratic
refugees[,-3] # Goal: Possibility of different coefficients per Country
refugees_year$Year_quad<-as.numeric(refugees_year$Year)^2
refugees_year$Year_quad
View(refugees_year)
refugees_year<-refugees_year[,-1] #drop year
model_quad<-lm(Population~ . ,data=refugees_year)
summary(model_quad)

# Add Total_deaths as predictor to the model
deaths<-read.csv(file="Total_deaths_Syria_2008-2015.csv", header=TRUE, sep=";")
deaths
plot(deaths, type="l")
colnames(deaths)<-c("Year","Deaths")
#insert a value for 2010 into deaths #df[6,] =c(5,6)
#mean2009_2011 <- ...
deaths[1,]=c(2010,0)

#merge(refugees_year, deaths, by="Year")
refugees_viol<-merge(x = refugees_year, y = deaths, by = "Year", all.x = TRUE) # left outer join to not loose 2010
str(refugees_viol$Deaths)
#refugees_viol <- refugees_viol[,-1]
View(refugees_viol)
str(refugees_viol$Year)
refugees_viol$Year_2<-as.numeric(refugees_year$Year)^2
# quadratic Year
refugees_viol_quad<-refugees_viol[-1]
model3<-lm(Population ~ . , data=refugees_viol_quad[])
# simple Year
refugees_viol<-merge(x = refugees_year, y = deaths, by = "Year", all.x = TRUE) # left outer join to not loose 2010
model4<-lm(Population ~ . , data=refugees_viol[])

#Comparison
summary(model3) # quadratic does not help anything!
summary(model4)
###Conclusion: Deaths are not a relevant predictor here so far!
########################################################################################
########################################################################################

levels(refugees_viol_quad$Country)
country_levels<-levels(refugees_viol_quad$Country)
Deaths_pred <- rep(80000, length(country_levels))
Year_2_pred <- rep(2016^2, length(country_levels))
predict(model3, newdata=list(Year_2=Year_2_pred, Country=country_levels, Deaths=Deaths_pred)) 
country_levels <- country_levels[-which(country_levels=="Belize")]
length(country_levels)
length(Deaths_pred)

#######
########################################################################################################
#Incorporate unemployment rate
########################################################################################################
unemployment<-read.csv(file="Unemployment_rate_2000-2015_EU28.csv")
View(unemployment)
colunemp <- colnames(unemployment)
colunemp[1]<- "Country"
colunemp[6] <- "Year"
#colunemp[7] <- "Unemployment"
colnames(unemployment) <- colunemp
colnames(unemployment)
unemployment<-unemployment[,c(1,6,7)] #extract country, year and value
# Define Country labels uniquely
levels(unemployment$Country)
levels(refugees_viol$Country)
levels(unemployment$Country)<-c("Austria","Belgium", "Czech Rep.", "Germany", "Denmark", "Spain", "Estonia", "Finland", 
                        "France", "United Kingdom", "Greece", "Hungary", "Ireland", "Italy", "Luxembourg", "Latvia", "Netherlands",
                        "Poland", "Portugal", "Slovakia", "Slovenia", "Sweden")
levels(unemployment$Country)
#refugees_viol<-merge(x = refugees_year, y = deaths, by = "Year", all.x = TRUE) # left outer join to not loose 2010
refugees_unempl_viol<-merge(x = refugees_viol, y = unemployment, by.x= c("Year","Country"), by.y=c("Year","Country"), all.x = TRUE) # left outer join to not loose 2010
View(refugees_unempl_viol)
colnames(refugees_unempl_viol)[5]<-"Unemployment"

#Build model
model5<-lm(Population ~ . , data=refugees_unempl_viol[])
summary(model5) #Multiple R-squared:  0.482,
summary(model4) #R-squared:  0.4775

#Fill NAs in unemployment with mean
mean(-(refugees_unempl_viol[is.na(refugees_unempl_viol$Value)),"Value"])
mean(is.nan(refugees_unempl_viol$Value))
summary(refugees_unempl_viol$Value)#mean=10.16
refugees_unempl_viol[is.na(refugees_unempl_viol$Value),"Value"]<-10.16

########################################################################################################
##### Try out-of-sample prediction for 2015:

train_refugees_unempl_viol <- refugees_unempl_viol[(refugees_unempl_viol$Year<=2014),]
test_refugees_unempl_viol <- refugees_unempl_viol[(refugees_unempl_viol$Year>2014),] #41 entries!
View(test_refugees_unempl_viol)
View(train_refugees_unempl_viol)
model_OOS_5 <- lm(Population ~ . , data=train_refugees_unempl_viol[])
colnames(test_refugees_unempl_viol)

levels(train_refugees_unempl_viol$Country)==levels(test_refugees_unempl_viol$Country)
test_refugees_unempl_viol_xdata <- test_refugees_unempl_viol[,-3]
pred_test_refugees_unempl_viol <- predict(model_OOS_5, test_refugees_unempl_viol_xdata)
?plot
dim(pred_test_refugees_unempl_viol)
length(test_refugees_unempl_viol)
plot(c(test_refugees_unempl_viol$Population, pred_test_refugees_unempl_viol), type="l")
#con(test_refugees_unempl_viol$Population, pred_test_refugees_unempl_viol)
?predict
length(pred_test_refugees_unempl_viol)
#Plot prediction
plot(y=test_refugees_unempl_viol$Population, x=test_refugees_unempl_viol$Country, ylim=c(0,500000))
lines(pred_test_refugees_unempl_viol, col="red") #is not good in prediction so far

summary(model_OOS_5)
test_refugees_unempl_viol$Country


######################### MIXED EFFECTS
install.packages("lme4")
library(lme4)
View(refugees_unempl_viol)
colnames(refugees_unempl_viol)
model5<-lm(Population ~ Year + Deaths + Value + (1|Country) , data=refugees_unempl_viol[])
#varying intercept (per country) model
model5<-lmer(Population ~ (1|Country)+Year + Deaths + Value+1 , data=refugees_unempl_viol)
summary(model5)
#varying slope (per country) model
model6<-lmer(Population ~ Year + Deaths + Value+(1+Year|Country) , data=refugees_unempl_viol)
#Correct signs for Year, Deaths and Value
coef(model5)
coef(model6)
summary(model6)
#### Check where stronger/weaker increase 
country_levels
length(coef(model6)$Country$Year)
Year_increase_per_country <- data.frame(country_levels, coef(model6)$Country$Year)
Year_increase_per_country[,2] <-as.numeric(Year_increase_per_country[,2])
Year_increase_per_country
colnames(Year_increase_per_country)
Year_increase_per_country_sorted <-  Year_increase_per_country[order(Year_increase_per_country$coef.model6..Country.Year),]
Year_increase_per_country_sorted


#### Try constant intercept, varying slopes:
model7<-lmer(Population ~ 1+Year + Deaths + Value+(Year|Country) , data=refugees_unempl_viol)
coef(model7)
summary(model7)
summary(model4)
# largest intercepts for Switzerland, Spain, Greece, Sweden, Germany, Turkey

as.numeric(refugees_unempl_viol$Country)

##What can we say so far?:
#1) Problem: Overestimation of small countries, underestimation of countries with many refugees
#2) Problem: How can we integrate time series? Do we have to? 
#3) Should we incorporate seasonality?
#4) 


########################################################################################################
########################################################################################################
#Demographics of refugees
demographics <- read.csv(file="/Users/sylviaschumacher/Documents/0_Master\ ETH/Social\ Systems/R_Social_Systems/Refugee_demographics_2000-20008.csv", sep=",")
View(demographics)
EU <- levels(demographics[1,]$GEO)[9]
EU
EU_only <- demographics[demographics["GEO"]==EU,]
boxplot(Value~SEX,data=EU_only)
EU_only$Value
View(EU_only)

########################################################################################################
########################################################################################################
# Fit non-linear model
z <- nls(y ~ a * x^b, data = mydata, start = list(a=1, b=1))


?boxplot
########################################################################################################
########################################################################################################
#ASYLUM DATA LLOYD
str()
asylum<-read.csv(file="Asylum_Data.csv", sep=",")
asylum
levels(asylum$CITIZEN)
subset(asylum, "CITIZEN"=="Syria")

Syrians <- asylum[asylum$CITIZEN=="Syria",]
Syrians
str(Syrians)
levels(Syrians$GEO)
#include "Turkey" in our analysis?

Syrians_in_Germany <- Syrians[Syrians$GEO=="Germany",]
Syrians_in_Germany
View(Syrians_in_Germany)

Syrians_in_Austria <- Syrians[Syrians$GEO=="Austria",]
Syrians_in_Austria

Syrians_in_France <- Syrians[Syrians$GEO=="France",]
View(Syrians_in_France)


Syrians_in_Italy <- Syrians[Syrians$GEO=="Italy",]
View(Syrians_in_Italy)

### Predict LM for countries
getwd()
fit
cbind(Austria,Germany)
lm(c(Austria,Germany)~Year,data=refugees_all)
refugees_all$Year
predict_Data<-data.frame(t(refugees_all[-1]))
colnames(predict_Data)<-refugees_all$Year

lm(~refugees_all$Year., data=predict_Data)

?data.frame
refugees_all[-1]
refugees_all


# MATLAB Fall 2016 – Research Plan

> * Group Name: Poor Swiss Immigrants
> * Group participants names: Pietrasik Lukasz, Schumacher Sylvia, Witon Wojciech
> * Project Title: Syrian Refugees movement modelling

## General Introduction

In recent years we have been experiencing increased movement of refugees from Syria. That was caused mainly by the unstable political situation, i.e., ongoing armed conflict. A lot of people looking for an asylum have chosen Europe as a stable place to live due to the decent location and economic conditions.
This has caused the refugee crisis in 2015, due to unexpected growth of refugee number in the western europe. The uncontrollable and unpredicted movement became a political challenge for all european countries and have affected border policies and even resumption of border controls between some countries.
The project aims to model the refugee movement based on the fighting data in the country of origin - Syria, to predict the distribution of refugees among european countries. The model that would be reliable and trustworthy could help in future decision making to avoid future troubles by redirecting the flow of migration or predicting the necessary resources in the given country. Furthermore the refugee datasets are incomplete and the same model could be used to estimate the number of asylum seekers in countries that lack the empirical data.

(States your motivation clearly: why is it important / interesting to solve this problem?)
(Add real-world examples, if any)
(Put the problem into a historical context, from what does it originate? Are there already some proposed solutions?)

## The Model

(Define dependent and independent variables you want to study. Say how you want to measure them.)
(Why is your model a good abstraction of the problem you want to study?) (Are you capturing all the relevant aspects of the problem?)

There are plenty of different datasets that have been created after the crisis, hence we aim to use the migration data to estimate the current capacities between different countries. Our model would also include the fighting measures in Syria as input to estimate the number of incoming refugees.
The fighting can be measured as a number of deaths resulted from fighting in Syria - this would be our model repulsive force from the country of refugees’ origin. The attraction force of refugees towards each country will depend on the following characteristics: GDP, human development index, population of the country, border policy, neighboring countries, distance from origin to the country, number of refugees already in the country.
As output we will predict the amount of refugees in given country of Europe at any specific time.

## Research Methods

(Cellular Automata, Agent-Based Model, Continuous Modeling...) (If you are not sure here: 1. Consult your colleagues, 2. ask the teachers, 3. remember that you can change it afterwards)
(families travel together and the gender or age is not the most important aspect)

We will approach the problem from global perspective, focussing on the flow between countries, their capacities and how they affect the refugee distribution with time.

Hence, we have decided to use the metapopulation model for migration that represents each country with the nodes that have limited capacities. This model helps to find the bottlenecks and how they affect the final distribution. Furthermore, the metapopulation method can be used to estimate the long time limit but it’s also perfect for time series, which is our goal.
OR
Hence, we have decided to use the Stouffer’s Theory of Mobility that claims that number of refugees in the examined country is directly proportional to the number of opportunities there and inversely proportional to the number of opportunities between the origin and the given country.


## Fundamental Questions

(At the end of the project you want to find the answer to these questions)
(Formulate a few, clear questions. Articulate them in sub-questions, from the more general to the more specific.)

How does the Syrian refugees distribute among european countries depending on fighting in their country?
How can the Syrian refugee movement flow be modified to direct them into specific European areas?
How would stop of fighting affect the flow? Would there be any backflow?
Is there some maximum fighting rate that the income of refugees wouldn’t increase?


## Expected Results

(What are the answers to the above questions that you expect to find before starting your research?)

We expect to obtain the prediction that matches the amount of refugees in european countries from our datasets.



## References 

[1]D. Groen, "Simulating Refugee Movements: Where would You Go?", Procedia Computer Science, vol. 80, pp. 2251-2255, 2016.
[2]J. Lewer and H. Van den Berg, "A gravity model of immigration", Economics Letters, vol. 99, no. 1, pp. 164-167, 2008.
[3]"4 General Theories of Migration – Explained!", YourArticleLibrary.com: The Next Generation Library, 2014. [Online]. Available: http://www.yourarticlelibrary.com/population-geography/4-general-theories-of-migration-explained/43257/. [Accessed: 23- Oct- 2016].

(Add the bibliographic references you intend to use)
(Explain possible extension to the above models)
(Code / Projects Reports of the previous year)

## Other

(mention datasets you are going to use)

### Refugee data
#### Time series data (origin country, country of asylum, monthly basis) 1960-2015
http://popstats.unhcr.org/en/time_series

#### Demographics of refugees (gender, age)
http://popstats.unhcr.org/en/demographics

#### Global information about refugee movement
http://data.unhcr.org/

#### “Global trends Forced Displacement in 2015” raport
https://s3.amazonaws.com/unhcrsharedmedia/2016/2016-06-20-global-trends/2016-06-14-Global-Trends-2015.pdf 

### Macroeconomic data
#### GDP of European Union
http://appsso.eurostat.ec.europa.eu/nui/show.do?dataset=naida_10_gdp&lang=en

#### Unemployment rate
https://data.oecd.org/unemp/unemployment-rate.htm

#### Human Development index
http://hdr.undp.org/en/composite/HDI

# MATLAB Fall 2016 – Research Plan

> * Group Name: Poor Swiss Immigrants
> * Group participants names: Pietrasik Lukasz, Schumacher Sylvia, Witon Wojciech
> * Project Title: Syrian Refugees movement modelling

## General Introduction
“We are facing the biggest refugee and displacement crisis of our time. Above all, this is not just a crisis of numbers; it is also a crisis of solidarity.”
- Ban Ki Moon, United Nations Secretary General

The number of refugees has increased significantly in recent years and reached 21.3 millions in 2015. Unstable political situation, ongoing armed conflict and persecution influence refugees' decision-making process of leaving their country. Almost one fourth (4.9 million) of all refugees originate from the Syrian Arab Republic. 
A lot of people looking for an asylum have chosen Europe as a stable place to live thanks to its decent location and economic conditions. The uncontrollable and unpredicted movement became a political challenge for all european countries and finally lead to the European refugee crisis in 2015. European countries reacted by changing border policies and even resumption of border controls between some countries.

Our project aims to model the refugee movement flows from Syrian refugees to all European countries of destination. Having an accurate model, we can examine to what extent different factors affect the number of refugees leaving Syria. Besides, the modelling the decision-making process of choosing a country of destination will reveal insides, which factors affect the competitive attractiveness of European countries.

There are different generalization approaches conceivable when it comes to generalization of our model: first, the simulation could help in the development of future migration and boarder policies by understanding and orchestrating modifiable factors of refugee movement. Furthermore, the same model could be applied to estimate the number of asylum seekers in countries that lack empirical data of historic refugee movement flows.

(States your motivation clearly: why is it important / interesting to solve this problem?)
(Add real-world examples, if any)
(Put the problem into a historical context, from what does it originate? Are there already some proposed solutions?)

Source:
https://s3.amazonaws.com/unhcrsharedmedia/2016/2016-06-20-global-trends/2016-06-14-Global-Trends-2015.pdf

## The Model

(Define dependent and independent variables you want to study. Say how you want to measure them.)
(Why is your model a good abstraction of the problem you want to study?) (Are you capturing all the relevant aspects of the problem?)

In order to model the decision-making process of Syrian refugees we take a sequential two-step-approach. In the first step, we try to model the probability, that a Syrian decides to leave the country in order to obtain the total number of Syrian refugees. In the second step, we model the distribution of the total number of Syrian refugees among the European countries of destination, given the number of total refugees that we determined in step 1. Although in reality, refugees might consider these two decisions of whether to leave their country of origin or not and where to go simultaneously and not sequentially, it allows us to reduce model complexity while not loosing to much model accuracy.

Our model will be trained on empirical data in order to approximate reality fair enough. Hereby, all our indicators are incorporated as time series into the model. A holdout sample of the nearby past will allow us to examine model performance and drawbacks of our simulation. 


Step 1 - Modeling Syrians' decision to leave the country:

Our model approach includes measures of the political and the economic conditions in Syria in order to estimate the number of refugees leaving the country. Among others, different indicators such as the number of attacks, the number of deaths, the number of prisoners,the human development index and the GDP will be incorporated in the model.


Step 2 - Modeling the distribution of refugees among European countries

In order to simulate the competitive attractiveness of each European country, the following indicators are used: GDP, human development index, population of the country, border policy, neighboring countries, distance from origin to the country, number of refugees already in the country.
As output we will predict the amount of refugees in given country of Europe at any specific time.
http://www.yourarticlelibrary.com/population-geography/4-general-theories-of-migration-explained/43257/

## Research Methods

(Cellular Automata, Agent-Based Model, Continuous Modeling...) (If you are not sure here: 1. Consult your colleagues, 2. ask the teachers, 3. remember that you can change it afterwards)
(families travel together and the gender or age is not the most important aspect)

We will approach the problem from global perspective, focussing on the flow between countries, their capacities and how they affect the refugee distribution with time.

In literature, different model approaches are used for simulating migration and people movements. One of them is the metapopulation model for migration that represents each country with the nodes that have limited capacities. This model helps to find the bottlenecks and how they affect the final distribution. Furthermore, the metapopulation method can be used to estimate the long time limit but it’s also perfect for time series, which is our goal.
In this model, the fighting can be measured as a number of deaths resulted from fighting in Syria - this would be our model repulsive force from the country of refugees’ origin. The attraction force of refugees towards each country will depend on the indicators of step 2.

Another model that we like to look at is the Stouffer’s Theory of Mobility that claims that the number of refugees in the examined country is directly proportional to the number of opportunities there and inversely proportional to the number of opportunities between the origin and the given country.

Finally, a modified version of the Gravity model could be applied to simulate our setting. In such a modified model we assume, that flows are directly proportional to the attractiveness of the country of destination and the inverse of the product of the country of origin and the square of the distance between an origin-destination pair. 

Source: http://www.yourarticlelibrary.com/population-geography/4-general-theories-of-migration-explained/43257/

## Fundamental Questions

(At the end of the project you want to find the answer to these questions)
(Formulate a few, clear questions. Articulate them in sub-questions, from the more general to the more specific.)

- How do Syrian refugees distribute among European countries depending on violence rate in their country?

- How can the Syrian refugee movement flow be modified to direct them into specific European areas?

- Is there a different proportional distribution to the countries of destination when varying the absolute number of refugees leaving Syria?

- How does the violence rate affect the upcoming flow of refugees? (What factors drive backflow of refugees)? Does the refugee flow have a saturation point after which it does not further increase?


## Expected Results

(What are the answers to the above questions that you expect to find before starting your research?)

Step 1 - Modeling Syrians' decision to leave the country:
Considering the decision whether to leave Syria, we rather expect the violence rate to be the main driver of refugees leaving their country than economic conditions. 

Step 2 - Modeling the distribution of refugees among European countries
In the process of choosing a country of destination, we assume that border policies and economic conditions will have a significant influence.

Model accuracy:
When training our model on historic data but leaving 2015 out of the training sample for evaluation purposes, our prediction accuracy might perform not as good as supposed to. This is caused by the big increase of refugees in 2015, which makes us predict values with our model that are outside the training values. 


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

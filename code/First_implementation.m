clear all;
clc;


% load('data/GDP.mat');
% load('data/travel_by.mat');
load('data/small/small_dataset.mat');
%GDP = GDP_per_capita;
num_ctr = length(GDP);

%% Define state
State = zeros(num_ctr,1); %initial state
State(1) = 10000; %everybody is in Greece
num_years = 9; 
New_State = zeros(num_ctr, num_years); %8 countries, 9 years
New_State(:,1) = State; %Initialize first year with the State vector

GDP(6) = 1000; %?what is this for?

	%% Calculate GDP between two countries


	GDP_between=zeros(num_ctr);

	for i=1:num_ctr
		for j=1:i 
			countries_between = travelby(i,:)-travelby(j,:); %Travelby(1,:) is first country=Greece
			GDP_between(i,j) = sum(GDP(countries_between==1));	%GDP between county (i and j)
		end
	end
	for i=1:num_ctr
		for j=1:i
			GDP_between(j,i) = GDP_between(i,j);
		end
	end
	%% Calculate GDP between two countries
for year = 2:num_years
	Y = zeros(num_ctr); %new vector for every year, length=number of countries

	for i=1:num_ctr
		for j = 1:num_ctr
			%number of people migrating from country j to country i
			Y(i,j) = floor( calculating_imigrants( GDP(i), GDP_between(i,j), New_State(i, year-1), New_State(j, year-1) ));
		end
	end
	Y(Y==inf)=0;

	%% Clear for countries that have not enought imigrants to export
	for i = 1:num_ctr
		Em = sum(Y(:,i)); %the number of emigrants for each country
		currently = New_State(i, year-1);
		factor = (currently/Em);
		if Em > currently;  
			Y(:,i) = Y(:,i).*factor; %number of emigrants is bigger than number of imigrants,  factor=6.6066
		end
	end
	
	%% New state

	
	for i=1:num_ctr
		Emigration(i) = sum(Y(:,i));
		Imigration(i) = sum(Y(i,:));
		New_State(i,year) = round(New_State(i,(year-1))+Imigration(i)-Emigration(i));
	end
	%% Add to Greece
	New_State(1, year) = New_State(1, year)+1000;
end
[Country, num2cell(New_State)]
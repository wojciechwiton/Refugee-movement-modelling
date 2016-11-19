function [ Y ] = calculating_imigrants(GDP_destination, GDP_between, imigrants_at_destination, imigrants_at_origin)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

k = 50;

if imigrants_at_destination <1
	imigrants_at_destination=1;
end
if imigrants_at_origin <0
	imigrants_at_origin=0;
end
if GDP_between <1
	GDP_between=1;
	GDP_destination = 1;
end

Y = (GDP_destination * imigrants_at_origin / (imigrants_at_destination * GDP_between)) * k;
end


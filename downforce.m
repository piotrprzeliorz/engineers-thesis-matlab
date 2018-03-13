%% The purpose of the script is to plot the downforce
 
clear all;
close all;
clc;

%% Extract data from source

data = xlsread('st2500_S2_2x156f03v200_001.xls');

downforce1 =  data(:,4);
downforce2 = data(:,5);

%% Remove nan values from downforces

downforce1(isnan(downforce1)) = [];
downforce2(isnan(downforce2)) = [];


%% Calculates the average downforce

D = []

for i=1:length(downforce1)
    value = ((downforce1(i) + downforce2(i))/2);
    D=[D value];
end

%% Plot the average downforce

ordinalNumber = [1:1:length(D)]

plot(ordinalNumber,D);

xlabel('Ordinal number'), ylabel('Average downforce')
title('Chart')

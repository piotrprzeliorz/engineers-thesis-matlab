%% The purpose of the script is to calculate the rolling resistance

%Enter file name and number of cycles 
data = xlsread('st2500_S2_2x156f03v200_001.xls');
numberOfMeasurementsInCycle = 80


%% The purpose of the script is to calculate the rolling resistance
 
clear all;
close all;
clc;

%% Extract data from source

resistance1 =  data(:,6);
resistance2 = data(:,7);
timestamps = data(:,10);


%% Remove nan values from numeric vector and timestamps

resistance1(isnan(resistance1)) = [];
resistance2(isnan(resistance2)) = [];
timestamps(isnan(timestamps)) = [];

%% Sum of resistance

sumOfReistance = resistance1 + resistance2

%% Assign timestamps and reistnaces to x,y
 
x = timestamps
y = sumOfReistance

%% Find peaks

Y=y;
[Y,X] = findpeaks(Y);
[m I]=max(y(1:numberOfMeasurementsInCycle));
X=X(X>=I);
U=I;
for i=2:length(X)
    if X(i)-U(end)>numberOfMeasurementsInCycle
        U=[U X(i)];
    end
end

%% Find mins
 
Y=-y;
[Y,X] = findpeaks(Y);
[m I]=min(y(1:numberOfMeasurementsInCycle));
X=X(X>=I);
D=I;
for i=2:length(X)
    if X(i)-D(end)>numberOfMeasurementsInCycle
        D=[D X(i)];
    end
end

%% Cauclate resistances
 
resistanceOfMovement=[];
for i=1:length(U)
    u=mean(y((U(i)+3):(U(i)+18)));
    d=mean(y((D(i)+3):(D(i)+18)));
    resistanceOfMovement=[resistanceOfMovement (u-d)/2];
end

average = mean(resistanceOfMovement)
disp(average')


plot(x,y);

xlabel('Time'), ylabel('Reistnace')
title('Chart')

 


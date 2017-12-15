%% S-1
 
clear all;
close all;
clc;

%% Extract data from source

data = xlsread('st2500_S2_2x156f03v200_001.xls');
numberOfMeasurementsInCycle = 80

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
 
resistanceOfMovement=[];
for i=1:length(U)
    u=mean(y((U(i)+3):(U(i)+18)));
    d=mean(y((D(i)+3):(D(i)+18)));
    resistanceOfMovement = [resistanceOfMovement (u-d)/2];
end


average = mean(resistanceOfMovement')
disp(average)


%plot(x,y);

ordinalNumbers = [1:1:length(y)]

plot(ordinalNumbers, y);

xlabel('Time'), ylabel('Force')
title('Chart')

 


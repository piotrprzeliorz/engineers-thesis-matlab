
% The purpose of the script is to calculate the rolling resistance
 
clear all;
close all;
clc;


%% Enter file name and number of cycles 
data = xlsread('s');
numberOfMeasurementsInCycle = 80



%% Extract data from source

resistance1 =  data(:,6);
resistance2 = data(:,7);
timestamps = data(:,1);


%% Remove nan values from numeric vector and timestamps

resistance1(isnan(resistance1)) = [];
resistance2(isnan(resistance2)) = [];
timestamps(isnan(timestamps)) = [];

%% Sum of resistance

sumOfReistance = resistance1 + resistance2

%% Assign timestamps and reistnaces to x,y
 
x = timestamps
y = sumOfReistance


plot(x,y);

%% Find peaks
j=0;
val=max(y);
while j~=100
    Y=y;
    val=val*0.999;
    Y(y<val)=0;
    [Y,X] = findpeaks(Y);
    [m I]=max(y(1:85));
    X=X(X>=I);
    U=I;
    for i=2:length(X)
        if X(i)-U(end)>numberOfMeasurementsInCycle
            U=[U X(i)];
        end
    end
    j=length(U);
end

plot(y)
hold on
plot(U,y(U),'ro')
numerOfPeaks = length(U);   
messagePekas = sprintf('%d - number of peaks.',numerOfPeaks);
disp(messagePekas);


%% Find mins
j=0;
val=min(y);
while j~=100
    Y=y;
    val=val*1.001;
    Y(y>val)=0;
    [YY,X] = findpeaks(Y);
    [m I]=min(y(1:85));
    X=X(X>=I);
    D=I;
    for i=2:length(X)
        if X(i)-D(end)>numberOfMeasurementsInCycle
            D=[D X(i)];
        end
    end
    j=length(D);
end

plot(X,y(X),'ro')

numerOfMins = length(D);   
messageMins = sprintf('%d - number of mins.',numerOfMins);
disp(messageMins);

%% Cauclate resistances
 
resistanceOfMovement=[];
for i=1:length(U)
    u=mean(y((U(i)+3):(U(i)+18)));
    d=mean(y((D(i)+3):(D(i)+18)));
    resistanceOfMovement= [resistanceOfMovement (u-d)/2];
end

average = mean(resistanceOfMovement);
disp(resistanceOfMovement');


   
xlabel('Time'), ylabel('Reistnace')
title('Chart')

 


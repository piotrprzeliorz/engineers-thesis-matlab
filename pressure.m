%% S-1
 
clear all;
close all;
clc;

%% Extract data from source

data = xlsread('st2500_S2_2x156f03v200_001.xls');

resistance1 =  data(:,6);
resistance2 = data(:,7);
timestamps = data(:,10);


%% Remove nan values from numeric vector and timestamps

resistance1(isnan(resistance1)) = [];
resistance2(isnan(resistance2)) = [];
timestamps(isnan(timestamps)) = [];

%% Sum of resistance

sumOfReistance = resistance1 + resistance2
 
x = timestamps
y = sumOfReistance

Y=y;
Y(y<43)=0;
[Y,X] = findpeaks(Y);
[m I]=max(y(1:83));
X=X(X>=I);
U=I;
for i=2:length(X)
  
    if X(i)-U(end)>80
%           disp(X(i))
    disp(U(end))
%         disp(X(1))
        U=[U X(i)];
    end
end
 
Y=-y;
Y(y<-25)=0;
[Y,X] = findpeaks(Y);
[m I]=min(y(1:83));
X=X(X>=I);
D=I;
for i=2:length(X)
    if X(i)-D(end)>80
%          disp(X(i))
        D=[D X(i)];
    end
end
 
w=[];
for i=1:length(U)
    u=mean(y((U(i)+3):(U(i)+18)));
%     disp(u)
    d=mean(y((D(i)+3):(D(i)+18)));
%     disp(d)
    w=[w (u-d)/2];
end

plot(x,y);
xlabel('Time'), ylabel('Force')
title('Chart')

disp(w')
 


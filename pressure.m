%% S-1
 
clear all;
close all;
clc;
 
data = xlsread('test.xls');
 
x = data(:,1);
y = data(:,2);
 

Y=y;
Y(y<43)=0;
[Y,X] = findpeaks(Y);
[m I]=max(y(1:83));
X=X(X>=I);
U=I;
for i=2:length(X)
  
    if X(i)-U(end)>80
          disp(X(i))
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

disp(w')
 
xlabel('Time'), ylabel('Force')
title('Chart')

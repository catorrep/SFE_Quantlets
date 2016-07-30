clc
clear
close all
load 'exrate_GBR-USD_EUR-USD.mat'
returns=log((fx_data(2:end,3))./(fx_data(1:end-1,3))); %FX-rates to returns 
y=[returns(1:(end-1),1) returns(2:end,1)];
yy=[y(:,1) y(:,2).^2];
hm=0.04; %rule of thumb bandwidth
hs=0.03;
[m1h, ~]=lpregest(y(:,1),y(:,2),1,hm); %estimate conditional mean function
[m2h, yg]=lpregest(yy(:,1),yy(:,2),1,hs);%estimate conditional 2. moment 
sh = [yg' m2h(:,1) - m1h(:,1).^2]; %conditional variance
m1hx = interp1(yg', m1h(:,1), y(:,1)); %interpolate mean
shx = interp1(yg', sh(:,2), y(:,1)); %interpolate variance
shx = [y(:,1) shx];
[clo cup]=lpvarcb(y(:,1),y(:,2),m1hx,sh(:,2),shx(:,2),hs,0.01);
%compute pointwise CI with alpha=0.01
shx=sortrows(shx,1);

figure(1)%plot the results
plot(shx(:,1),shx(:,2),'LineWidth',1,'Color',[0 0 0]);
title('FX Variance Function');%plot the estimated conditional variance function
hold all;
plot(yg,cup,'LineWidth',1,'Color',[0 0 1]);
plot(yg,clo,'LineWidth',1,'Color',[0 0 1]);
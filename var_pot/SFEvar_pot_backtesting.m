%% clear all variables and console 
clear all;
clc;

%% close windows
close all;

%% data import
formatSpec = '%{yyyy-MM-dd}D%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f';
Data       = readtable('2004-2014_dax_ftse.csv','Delimiter',',', 'Format',formatSpec);
Data       = Data(:,{'Date','BAYER','BMW', 'SIEMENS', 'VOLKSWAGEN'});

h       = 250;        % size of moving window
x       = Data.BAYER + Data.BMW + Data.SIEMENS + Data.VOLKSWAGEN;
x       = diff(x);  % returns
minus_x = -x;
p       = 0.95;       % quantile for the Value at Risk
q       = 0.1;
T       = length(x);

%% Value at Risk
% preallocation
var  = NaN(1,T-h);
ksi  = var;
beta = var;
u    = var;

for i=1:T-h
    y = minus_x(i:i+h-1);
    [var(i),ksi(i),beta(i),u(i)] = var_pot(y,h,p,q);
end

%% save variables  and parameters in .csv files
csvwrite('VaR0414_pot_Port.csv', var)
csvwrite('ksi0414_pot_Port.csv', ksi)
csvwrite('beta0414_pot_Port.csv', beta)
csvwrite('u0414_pot_Port.csv', u)

%% number of exceedances fo Value at Risk, p
p = var_pot_backtesting(a,b,c,d,v,h);

v = -var;
L = x;

% preallocation
outlier   = NaN(1,T-h);
exceedVaR = outlier;

for j=1:T-h
    exceedVaR(j) = (L(j+h)<v(j));
    if exceedVaR(j)>0 
        outlier(j) = L(j+h);
    end;
end;

p       = sum(exceedVaR)/(T-h);
K       = find(isfinite(outlier));
outlier = outlier(K);
date_outlier = Data.Date(h+2:end);
date_outlier = date_outlier(K);

%% plot
plot(Data.Date(h+2:end),L(h+1:end), '.')
hold on
plot(Data.Date(h+2:end), v,'Color','red','LineWidth',2)
plot(date_outlier,outlier,'.','Color','m')
yplus   = K.*0+min(L(h+1:end))-2;
plot(date_outlier,yplus,'+','Color',[0,0.25098,0])
legend('Profit/Loss','VaR','Exceedances', 'Location', 'northwest')
title('Peaks Over Threshold Model','FontSize',16,'FontWeight','Bold')

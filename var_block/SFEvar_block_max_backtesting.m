%% clear all variables and console 
clear
clc

%% close windows
close all

%% data import
formatSpec = '%{yyyy-MM-dd}D%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f';
Data       = readtable('2004-2014_dax_ftse.csv','Delimiter',',', 'Format',formatSpec);
Data       = Data(:,{'Date','BAYER','BMW', 'SIEMENS', 'VOLKSWAGEN'});

x       = Data.BAYER + Data.BMW + Data.SIEMENS + Data.VOLKSWAGEN;
x       = diff(x);  % returns
minus_x = -x;
Obs     = length(x);
p       = 0.95;       % quantile for the Value at Risk
q       = 0.1;
h       = 250;        % size of moving window
n       = 16;

%% Value at Risk
% preallocation
var   = NaN(1,Obs-h);
tau   = var;
alpha = var;
beta  = var;
kappa = var;

for i = 1:Obs-h
    y = x(i:i+h-1);
    [var(i),tau(i),alpha(i),beta(i),kappa(i)] = block_max(y,n,p);
end;


[v,K,outlier,yplus,L] =var_block_max_backtesting(x,v,h);
plot(L(h+1:end),'.')
hold on
set(gca,'FontSize',16,'LineWidth',1.6,'FontWeight','bold');
    box on
plot(v,'Color','red','LineWidth',2)
plot(K,outlier,'.','Color','m');

plot(K,yplus,'+','Color',[0,0.25098,0]);
xlim([-3 length(x)-220])
H=legend('Profit/Loss','VaR','Exceedances','Location','NorthWest');
set(H,'FontSize',12,'FontWeight','normal');
t  = [1:522:length(x)];
t1 = [2000:2:2013];
set(gca,'XTick',t,'FontSize',16,'FontWeight','Bold','LineWidth',1.6)
set(gca,'XTickLabel',t1,'FontSize',16,'FontWeight','Bold','LineWidth',1.6)
TT=title('Block Maxima Model');
set(TT,'FontSize',16,'FontWeight','Bold')

% to save the plot in pdf or png please uncomment next 2 lines:

 % print -painters -dpdf -r600 SFEvar_block_max_backtesting.pdf
 % print -painters -dpng -r600 SFEvar_block_max_backtesting.png



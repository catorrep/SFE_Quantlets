%% clear variables and console and close windows
clear
clc
close all

%% set directory
%cd('C:/...')

%% data import
formatSpec = '%{yyyy-MM-dd}D%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f'
DAX        = readtable('2004-2014_dax_ftse.csv','Delimiter',',', 'Format',formatSpec);

%% firt business day of each month
DAX       = DAX(:,{'Date','DAX30'});
DAX.Year  = year(DAX.Date);
DAX.Month = month(DAX.Date); 
DAX.Day   = day(DAX.Date);
minDay    = grpstats(DAX,{'Year','Month'}, 'min', 'DataVars','Day');
n         = size(minDay, 1);
minDayDAX = [];
for i=1:n
    repDay = [repmat(minDay.min_Day(i), minDay.GroupCount(i),1)];
    minDayDAX = [minDayDAX; repDay];
end
DAX.minDay = minDayDAX;

%% monthly DAX
monthlyDAX = DAX(DAX.Day==DAX.minDay,:);
monthlyDAX = monthlyDAX(2:end,:);

%% monthly returns
returns = log(monthlyDAX.DAX30(2:end)) - log(monthlyDAX.DAX30(1:(end-1)));

%% summary statistics of the monthly returns
summary.Minimum           = min(returns);
summary.Maximum           = max(returns);
summary.Mean              = mean(returns);
summary.median            = median(returns);
summary.Std_Error         = std(returns);
summary.Annual_volatility = std(returns)*sqrt(12);
summary.Skewness          = skewness(returns);
summary.Kurtosis          = kurtosis(returns);
summary

%% plot of the monthly DAX returns
set(gcf,'color','w');
plot(monthlyDAX.Date(2:end), returns, 'Color', 'b')
xlim = get(gca,'xlim');  %Get x range 
hold on
plot([xlim(1) xlim(2)],[0 0], 'Color', [0 0.5 0])
title('Monthly DAX Returns 2004.07-2014.05')
xlabel('Date') % x-axis label
ylabel('DAX Returns') % y-axis label

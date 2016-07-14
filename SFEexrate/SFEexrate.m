%% clear variables and console and close windows
clear
clc
close all

%% set directory
%cd('C:/...')

%% data import
formatSpec = '%{dd/MM/yyyy}D%f'
data       = readtable('2004_2014_exRate_EURUSD.csv','Delimiter',',', 'Format',formatSpec);

%% Convert FX-rates to return series
returns = diff(log(data.EUDOLLR)); 

%% These variables will be later used for the label of the time axis
date_Year       = year(data.Date);
where_put_Rate  = [true; (diff(date_Year) == 1)];
Years           = date_Year(where_put_Rate);
where_put_Rtrn  = [true; (diff(date_Year(2:end)) == 1)];           
Index_Rate      = 1:size(data,1);
Index_Rtrn      = 1:(size(data,1)-1);

%% Open the window for the plots
figure
set(gcf,'color','w') % set the background color to white

%% Plot FX EUR/USD
subplot(2, 1, 1) 
plot(Index_Rate, data.EUDOLLR)
  title('FX Rate EUR/USD')
    axis([0 Index_Rate(end) min(data.EUDOLLR) max(data.EUDOLLR)])
    set(gca, 'XTick', Index_Rate(where_put_Rate))
    set(gca,'XTickLabels', Years)

%% Plot returns EUR/USD    
subplot(2,1,2) 
plot(Index_Rtrn, returns)
  title('FX Returns EUR/USD')
    axis([0  Index_Rtrn(end) min(returns) max(returns)])
    set(gca,'XTick', Index_Rtrn(where_put_Rtrn))
    set(gca,'XTickLabels', Years)
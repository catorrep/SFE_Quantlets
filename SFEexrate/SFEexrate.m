%% clear variables and console and close windows
clear
clc
close all

%% set directory
%cd('C:/...')

%% data import
formatSpec = '%{dd/MM/yyyy}D%f%f';
data       = readtable('2010_2016_exRate_USDEUR_HR.csv','Delimiter',',', 'Format',formatSpec);
data       = sortrows(data, {'Date','Hour'});

%% Convert FX-rates to return series
returns = diff(log(data.USDEUR)); 

%% These variables will be later used for the label of the time axis
date_Year       = year(data.Date);
where_put_Rate  = [false; (diff(date_Year) == 1)];
Years           = date_Year(where_put_Rate);
where_put_Rtrn  = [false; (diff(date_Year(2:end)) == 1)];           
Index_Rate      = 1:size(data,1);
Index_Rtrn      = 1:(size(data,1)-1);


%% Open a new window for the plots
figure
set(gcf,'color','w') % set the background color to white

%% Plot FX USD/EUR
subplot(2, 1, 1) 
plot(Index_Rate, data.USDEUR)
  title('FX Rate USD/EUR')
    axis([0 Index_Rate(end) min(data.USDEUR) max(data.USDEUR)])
    set(gca, 'XTick', Index_Rate(where_put_Rate))
    set(gca,'XTickLabels', Years)

%% Plot returns USD/EUR
subplot(2, 1, 2) 
plot(Index_Rtrn, returns)
  title('FX Returns USD/EUR')
    axis([0  Index_Rtrn(end) min(returns) max(returns)])
    set(gca,'XTick', Index_Rtrn(where_put_Rtrn))
    set(gca,'XTickLabels', Years)
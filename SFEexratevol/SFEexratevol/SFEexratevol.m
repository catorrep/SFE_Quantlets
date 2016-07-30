%% clear variables and console and close windows
clear
clc
close all

%% set directory
%cd('C:/...')

%% data import
formatSpec = '%{dd/MM/yyyy}D%f%f';
data       = readtable('2010_2016_exRate_USDEUR_HR.csv', 'Delimiter', ',',  'Format', formatSpec);
data       = sortrows(data, {'Date','Hour'});

%% Convert FX-rates to return series
returns = diff(log(data.USDEUR));

% %% With the original daily data we obtain the same curve as with the original quantlet
% load 'exrate_GBR-USD_EUR-USD.mat'
% plot(fx_data(:, 3))
% xlim([1 length(fx_data(:, 3))])
% returns = diff(log(fx_data(:, 3)));

%% values necessary for the estimation of cn and cnbar

X  = returns(1:(end - 1));
x0 = min(X) : (max(X) - min(X)) / 100 : max(X);
p  = 1;
h  = 0.03;

cn    = lpReg(returns(2:end), X, x0, p, h);
cnbar = lpReg(returns(2:end).^2, X, x0, p, h);

% Estimated variance:
var       = cnbar(:, 1) - cn(:, 1).^2;
varToPlot = sortrows([x0' var], 1);

%% Open a new window for the plot
figure
set(gcf,'color','w') % set the background color to white
plot(varToPlot(:, 1), varToPlot(:, 2), 'LineWidth', 1, 'Color', [0 0 1])
    title('FX Conditional Variance function')

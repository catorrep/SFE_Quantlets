%% clear variables and console and close windows
clear
clc
close all

%% set directory
%cd('C:/...')

% data import
formatSpec = '%{dd/MM/yyyy}D%f';
data       = readtable('2001_2014_exRate_USDEUR.csv','Delimiter',',', 'Format',formatSpec);
figure
plot(data.USEURSP)

%% Convert FX-rates to return series
returns = diff(log(data.USEURSP)); 


% %% TRABAJANDO CON LOS DATOS ORIGINALES:
% load 'exrate_GBR-USD_EUR-USD.mat'
% returns = diff(log(fx_data(:,3))); 

%% bandwidths to fit the regression models Y_i ~ Y_{i-1} and Y_i^2 ~ Y_{i-1})
hy  = 0.04; %rule of thumb bandwidth
hy2 = 0.03;

%% LP regression with p = 1 
[Bx1, x] = lpregest(returns(1:(end - 1)), returns(2:end), 1, hy); 
[Bx2, ~] = lpregest(returns(1:(end - 1)), returns(2:end).^2, 1, hy2); 

B0x1 = Bx1(:,1);         % Estimator for conditional mean, i.e. E(Y_i|Y_{i-1})
B0x2 = Bx2(:,1);         % Estimator for E(Y_i^2|Y_{i-1})
vx   = B0x2 - B0x1.^2;   % Estimator for the conditional variance: v(Yi|Y_{i-1}) = E(Y_i^2|Y_{i-1}) - E(Y_i|Y_{i-1}) (formula 15.8)

%% interpolated mean and variance:
meanInt = interp1(x, B0x1, returns(1:(end-1))); 
varInt  = interp1(x, vx, returns(1:(end-1))); 

%% compute pointwise CI with alpha=0.01
[cilo, ciup] = lpvarcb(returns(1:(end - 1)), returns(2:end), meanInt, vx, varInt, hy2, 0.01);

varToPlot = sortrows([returns(1:(end - 1)) varInt], 1);

%% plot
figure
plot(varToPlot(:, 1), varToPlot(:, 2), 'LineWidth', 1, 'Color', [0 0 0])
title('FX Variance Function');%plot the estimated conditional variance function
hold all;
plot(x, ciup, 'LineWidth', 1, 'Color', [0 0 1]);
plot(x, cilo, 'LineWidth', 1, 'Color', [0 0 1]);
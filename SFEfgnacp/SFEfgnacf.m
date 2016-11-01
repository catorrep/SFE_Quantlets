%% clear variables and console and close windows
clear
clc
close all

%% set input parameters
n   = 1000 + 1;
H1  = 0.2;
H2  = 0.8;
lag = 60;

%% simulation 
% rng(123) % set a seed if you want this simulation to be reproducible
FBMH1 = wfbm(H1, n);
fgnH1 = diff(FBMH1);
FBMH2 = wfbm(H2, n);
fgnH2 = diff(FBMH2);


%% open a new window for the plots
figure
set(gcf,'color','w') % set the background color to white

%% plot simulated data 
subplot(2, 2, 1)
plot(fgnH1);
title(['H = ' , num2str(H1)])
 
subplot(2, 2, 2)
plot(fgnH2);
title(['H = ' , num2str(H2)])

%% plot ACF
subplot(2, 2, 3)
autocorr(fgnH1, lag, [], 2);
title('ACF')
ylabel('')

subplot(2, 2, 4)
autocorr(fgnH2, lag, [], 2)
title('ACF')
ylabel('')
% ---------------------------------------------------------------------
% Book:         SFE
% ---------------------------------------------------------------------
% Quantlet:     SFEvar_block_max_params
% ---------------------------------------------------------------------
% Description:  SFEvar_block_max_params provides parameters estimated 
%               for calculating Value-at-Risk with Block Maxima Model.
% ---------------------------------------------------------------------
% Usage:        -
% ---------------------------------------------------------------------
% Inputs:       k - shape parameter
%               a - scale parameter
%               b - location parameter
% ---------------------------------------------------------------------
% Output:       Parameters estimated for calculating Value-at-Risk with 
%               Block Maxima Model.
% ---------------------------------------------------------------------
% Example:      -
% ---------------------------------------------------------------------
% Reference:    Franke, J., H�rdle, W. and Hafner, Ch.(2004)
%               Statistics of Financial Markets: An Introduction
% ---------------------------------------------------------------------
% Author:       Barbara Choros, 31.10.2007
%               Edit: Awdesch Melzer 20131127
% ---------------------------------------------------------------------


clc;
clear all
close all

a = load('BAYER_close_0012.dat');
b = load('BMW_close_0012.dat');
c = load('SIEMENS_close_0012.dat');
d = load('VW_close_0012.dat');

e = a+b+c+d;
x = e(2:end)-e(1:end-1);
x = -x;
T = length(x);
h = 250;
p = 0.95;
n = 16;
for i = 1:T-h
    y = x(i:i+h-1);
    [v(i),tau(i),alpha(i),beta(i),kappa(i)] = block_max(y,n,p);
end;

k = kappa;
a = alpha;
b = beta;

%PLOTS
plot(k)
hold on
plot(a,'Color','red')
plot(b,'Color','m');
hold off
legend('Shape Parameter','Scale Parameter','Location Parameter','Location','NorthWest')
title('Parameters in Block Maxima Model')
xlim([-3 length(x)-220])
t  = [1:522:length(x)];
t1 = [2000:2:2013];
set(gca,'XTick',t,'FontSize',16,'FontWeight','Bold','LineWidth',1.6)
set(gca,'XTickLabel',t1,'FontSize',16,'FontWeight','Bold','LineWidth',1.6)
TT=title('Block Maxima Model');
set(TT,'FontSize',16,'FontWeight','Bold')

% to save the plot in pdf or png please uncomment next 2 lines:

%  print -painters -dpdf -r600 SFEvar_block_max_params.pdf
%  print -painters -dpng -r600 SFEvar_block_max_params.png

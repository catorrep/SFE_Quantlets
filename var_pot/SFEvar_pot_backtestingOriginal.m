% ---------------------------------------------------------------------
% Book:         SFE
% ---------------------------------------------------------------------
% Quantlet:     SFEvar_pot_backtesting
% ---------------------------------------------------------------------
% Description:  SFEvar_pot_backtesting provides backtesting results for
%               Value at Risk computed with Peaks Over Treshold model 
%               with generalized Pareto distribution.
% ---------------------------------------------------------------------
% Usage:        var_pot_backtesting(x,y,z,v,h)
% ---------------------------------------------------------------------
% Inputs:       a,b,c,d - vector of returns
%               v - values of Value at Risk
%               h - size of the window
% ---------------------------------------------------------------------
% Output:       p - number of exceedances for Value at Risk
% ---------------------------------------------------------------------
% Result:       Number of exceedances for Value at Risk computed with
%               Peaks Over Treshold model with generalized Pareto
%               distribution.
% ---------------------------------------------------------------------
% Example:      -
% ---------------------------------------------------------------------
% Reference:    McNeil, A. (1999) Extreme Value Theory for Risk Managers
% ---------------------------------------------------------------------
% Author:       Barbara Choros, 14.10.2007
%               Edit: Awdesch Melzer 20131126
% ---------------------------------------------------------------------


clear all;
clc;
close all;

a = load('VW_close_0012.dat');
b = load('BAYER_close_0012.dat');
c = load('BMW_close_0012.dat');
d = load('SIEMENS_close_0012.dat');

h = 250;
e = a+b+c+d;
x = e(2:end)-e(1:end-1);
x = -x;
p = 0.95;
q = 0.1;
T = length(x);

for i=1:T-h
    y=x(i:i+h-1);
    [var(i),ksi(i),beta(i),u(i)]=var_pot(y,h,p,q);
end

v = var;



%v = load('VaR9906_pot_Portf.txt','-ascii');
p = var_pot_backtesting(a,b,c,d,v,h);
title('Peaks Over Threshold Model','FontSize',16,'FontWeight','Bold')


    % to save the plot in pdf or png please uncomment next 2 lines:
%  print -painters -dpdf -r600 SFEvar_pot_backtesting.pdf
%  print -painters -dpng -r600 SFEvar_pot_backtesting.png

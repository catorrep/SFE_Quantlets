% ---------------------------------------------------------------------
% Book:         SFE
% ---------------------------------------------------------------------
% Quantlet:     SFEvar_block_max_backtesting
% ---------------------------------------------------------------------
% Description:  SFEvar_block_max_backtesting provides backtesting 
%               results for Value-at-Risk with Block Maxima Model. Refers to exercise 16.9 in SFS.
% ---------------------------------------------------------------------
% Usage:        var_block_max_backtesting(x,y,z,v,h)
% ---------------------------------------------------------------------
% Inputs:       a,b,c,d - vector of returns
%               v - values of Value at Risk
%               h - size of the window
% ---------------------------------------------------------------------
% Output:       p - number of exceedances for Value at Risk
% ---------------------------------------------------------------------
% Example:      -
% ---------------------------------------------------------------------
% Reference     Franke, J., Haerdle, W. and Hafner, Ch.(2004)
%               Statistics of Financial Markets: An Introduction
% ---------------------------------------------------------------------
% Author:       Barbara Choros, 31.10.2007;
%               Revised: Awdesch Melzer 20131113
% ---------------------------------------------------------------------

clear
clc
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
n = 16; % de donde diablos viene este 16???

for i = 1:T-h
    y = x(i:i+h-1);
    [v(i),tau(i),alpha(i),beta(i),kappa(i)] = block_max(y,n,p);
end;

[v,K,outlier,yplus,L ] =var_block_max_backtesting(e,v,h);

% to save the plot in pdf or png please uncomment next 2 lines:

 % print -painters -dpdf -r600 SFEvar_block_max_backtesting.pdf
 % print -painters -dpng -r600 SFEvar_block_max_backtesting.png



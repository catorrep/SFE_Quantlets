% ---------------------------------------------------------------------
% Book:         
% ---------------------------------------------------------------------
% Quantlet:     SFEvar_pot_params
% ---------------------------------------------------------------------
% Description:  SFEvar_pot_params provides parameters estimated for 
%               calculating Value-at-Risk with Peaks Over Treshold 
%               model.
% ---------------------------------------------------------------------
% Usage:        -
% ---------------------------------------------------------------------
% Inputs:       bet - scale parameter
%               ksi - shape parameter
%               u - threshold
% ---------------------------------------------------------------------
% Output:       
% ---------------------------------------------------------------------
% Example:     
% ---------------------------------------------------------------------
% Reference:    McNeil, A. (1999) Extreme Value Theory for Risk 
%               Managers
% ---------------------------------------------------------------------
% Author:       Barbara Choros, 14.10.2007
%               Revised: Awdesch Melzer 20131114
% ---------------------------------------------------------------------
% See also:     SFEMeanExcessFun, SFEclose, SFEportfolio,
%               SFEportlogreturns, SFEtailGEV_pp, SFEtailGEV_qq,
%               SFEtailGPareto_pp, SFEtailGPareto_qq,
%               SFEvar_block_max_backtesting, SFEvar_block_max_params,
%               block_max, var_block_max_backtesting, var_pot,
%               var_pot_backtesting, SFEvar_pot_backtesting
% ---------------------------------------------------------------------
% Keywords:     VaR, POT, Pareto, Extreme Value, portfolio, returns
% ---------------------------------------------------------------------
clc;
close all;
clear all;

a = load('VW_close_0012.dat');
b = load('BAYER_close_0012.dat');
c = load('BMW_close_0012.dat');
d = load('SIEMENS_close_0012.dat');

h = 250;
e = a + b + c + d;
x = e(2:end)-e(1:end-1);
x = -x;
p = 0.95;
q = 0.1;
T = length(x);

for i=1:T-h
    y=x(i:i+h-1);
    [var(i),ksi(i),beta(i),u(i)]=var_pot(y,h,p,q);
end


% Plots
plot(beta)
hold on
plot(ksi,'Color','red')
plot(u,'Color','m');
hold off
legend('Scale Parameter','Shape Parameter','Threshold','FontSize',16,'FontWeight','Bold','Location','NorthWest')
title('Parameters in Peaks Over Threshold Model','FontSize',16,'FontWeight','Bold')
xlim([-3 length(x)-220])
t  = [1:522:length(x)];
t1 = [2000:2:2013];
set(gca,'XTick',t,'FontSize',16,'FontWeight','Bold','LineWidth',1.6)
set(gca,'XTickLabel',t1,'FontSize',16,'FontWeight','Bold','LineWidth',1.6)

    % to save the plot in pdf or png please uncomment next 2 lines:
%  print -painters -dpdf -r600 SFEvar_pot_params.pdf
%  print -painters -dpng -r600 SFEvar_pot_params.png
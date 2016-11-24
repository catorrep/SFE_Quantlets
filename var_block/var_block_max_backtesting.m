% ---------------------------------------------------------------------
% Book:        SFE
% ---------------------------------------------------------------------
% See also:    SFEvar_block_max, var_block_max_backtesting, block_max
% ---------------------------------------------------------------------
% Quantlet:    var_block_max_backtesting
% ---------------------------------------------------------------------
% Description: var_block_max_backtesting tests back VaR estimate results v
%              from block_max routine in a observation window h (e.g 250)
%              for the portfolio x and gives VaR estimates and outliers.
% ---------------------------------------------------------------------
% Usage:       [v,K,outlier,yplus,L]=var_block_max_backtesting(x,v,h)
% ---------------------------------------------------------------------
% Input:       
% Parameter:   x
% Definition:  (p x 1) vector of portfolio
% Parameter:   v 
% Definition:  (p x 1) vector of VaR estimates from block_max routine
% Parameter:   h
% Definition:  integer, observation window (e.g. 250)
% ---------------------------------------------------------------------
% Output:      
% Parameter:   v
% Definition:  (p x 1) vector of VaR estimates
% Parameter:   K
% Definition:  dummy vector (outlier == 1)
% Parameter:   outlier
% Definition:  vector of outliers
% Parameter:   yplus
% Definition:  furthest level of return
% Parameter:   L
% Definition:  point values for plot
% ---------------------------------------------------------------------
% Example:    -
% ---------------------------------------------------------------------
% Results:    -
% ---------------------------------------------------------------------
% Keywords:    VaR, backtesting, GEV
% ---------------------------------------------------------------------
% Author:      Barbara Choros
%              edit: Awdesch Melzer 20131117
% ---------------------------------------------------------------------


function [v,K,outlier,yplus]=var_block_max_backtesting(x,v,h)
v=-v;
L=x;
T=length(L);
outlier=NaN(1,T-h);
for j=1:T-h
exceedVaR(j)=(L(j+h)<v(j));
    if exceedVaR(j)>0 
        outlier(j)=L(j+h);
    end;
end;
p=sum(exceedVaR)/(T-h);
K=find(isfinite(outlier));
yplus=K.*0+min(L(h+1:end))-2;
outlier=outlier(K);
end
  
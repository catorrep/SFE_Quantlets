% ---------------------------------------------------------------------
% Book:         SFE
% ---------------------------------------------------------------------
% Quantlet:     var_pot_backtesting
% ---------------------------------------------------------------------
% Description:  var_pot_backtesting provides backtesting results for
%               Value at Risk computed with Peaks Over Treshold model 
%               with generalized Pareto distribution.
% ---------------------------------------------------------------------
% Usage:        p = var_pot_backtesting(a,b,c,d,v,h)
% ---------------------------------------------------------------------
% Inputs:       x,y,z - vector of returns
%               v - values of Value at Risk from POT model
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


function p=var_pot_backtesting(a,b,c,d,v,h)

v       = -v;
V       = a+b+c+d;
L       = V(2:end,1)-V(1:(end-1),1);
T       = length(L);
outlier = NaN(1,T-h);

for j=1:T-h
    exceedVaR(j)   = (L(j+h)<v(j));
    if exceedVaR(j)>0 
        outlier(j) = L(j+h);
    end;
end;

p       = sum(exceedVaR)/(T-h);
K       = find(isfinite(outlier));
outlier = outlier(K);

plot(L(h+1:end),'.')
grid on
hold on
plot(v,'Color','red','LineWidth',2)
plot(K,outlier,'.','Color','m');
yplus   = K.*0+min(L(h+1:end))-2;
plot(K,yplus,'+','Color',[0,0.25098,0]);
legend('Profit/Loss','VaR','Exceedances')
% xlim([-3 length(x)-220])
% t       = [1:522:length(x)];
% t1      = [2000:2:2013];
set(gca,'XTick',t,'FontSize',16,'FontWeight','Bold','LineWidth',1.6)
set(gca,'XTickLabel',t1,'FontSize',16,'FontWeight','Bold','LineWidth',1.6)
box on
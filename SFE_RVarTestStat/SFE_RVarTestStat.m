function [v_s] = SFE_RVarTestStat(z, q)
 T   = length(z);
 meanZ = mean(z);                 
 diffZ = z - meanZ; 
 % partial sums
 a     = sum(cumsum(diffZ).^2);
 b     = sum(cumsum(diffZ))^2;
 o     = ones(1,q);
 i     = (1:q).*(1/(1+q));
 k     = xcov(z, q);        % autocovariances
 l     = k(q+2:end);
 sig2  = k(q+1)/T + 2 * sum((o - i).*l');   
 % statistic 
 v_s = (1/(sig2*(T^2))) * (a - (1/length(z))* b);
end
%% function to compute confidence intervals
% (returns(1:(end - 1)), returns(2:end), meanInt, vx, varInt, hy2, 0.01
function [clo, cup] = lpvarcb(X, Y, mhx, sh, shx, hs, alpha)
    n    = length(X);
    x    = min(X):(max(X)-min(X))/200:max(X); %grid
    m    = length(x);
    khat = zeros(m, n);
    res  = ((Y - mhx).^2 - shx).^2;        %find the residuals (Y-meanInt)^2 - varInt
    for i = 1:n
        Xx        = X(i) - x;
        Wx        = quadk(Xx./hs)./hs;     %compute kernel weigths
        khat(:,i) = Wx;
    end;
    sh2         = (khat * res).*1./(n * khat * ones(n,1)); % compute variance of variance
    [fh ,~ , h] = ksdensity(X, x);                         % estimate density of x
    ck          = 5/7;                                     % ||K||^2_2
    cl          = norminv(1-(alpha/2));                    % alpha-quantile of standard normal distribution        
    mrg         = cl*((ck*sh2)./((fh.*h*n)')).^(0.5);    
    clo         = sh - mrg;
    cup         = sh + mrg;

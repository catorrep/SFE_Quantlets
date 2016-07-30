%% function needed to compute local polynomial regression estimator

function [bhat, x] = lpregest(X, Y, p, h)
    x         = min(X): (max(X) - min(X)) / 200 : max(X); %grid    
    m         = length(x); 
    bhat      = zeros(m, p + 1);    
    
    for i = 1:m                        
        differ    = X - x(i);
        Wx        = diag(quadk(differ./h)./h);      
        Xx        = []; 
        for j = 0:p
            Xx = [Xx differ.^j]; 
        end;
        bhat(i, :) = inv(Xx' * Wx * Xx) * Xx' * Wx * Y;
    end;

%% This function is necessary to find the coefficients cn from the formula 15.10

function [cn] = lpReg(Y, X, x0, p, h)
    m  = length(x0);
    cn = zeros(m, p + 1);        
    
    for i = 1:m                        
        u = (X - x0(i)) / h;
        U = [];
        
        for j = 0:p
            U = [U u.^j];
        end
        
        K = diag(quadk(u));
        cn(i, :) = inv(U' * K * U) * U' * K * Y;
    end

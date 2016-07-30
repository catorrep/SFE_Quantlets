%% function needed to compute quadratic kernel
% Usage :  y = quadk(x);
% Returns: y = (15/16).*(x.*x.<1).*(1- x.*x).^2 ) ;
function y = quadk(x)    
    I = (x.*x < 1);
    x = x .*I ;
    y = (15/16) * I .* (1 - x.*x).^2 ;  
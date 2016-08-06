function funct = SFEwhittle(d ,series, m)
    
    n      = length(series);
    t      = 1:n;
    j      = 1:m;
    lambda = 2 * pi * j / n;
    
    semiw  = zeros(m, 1);
    for jj = 1:m
        semiw(jj) = exp(1i * t * lambda(jj)) * series;    
    end
    
    % Discrete Fourier Transform
    w = (2 * pi * n)^(1/2) * semiw;

    % Periodogram:
    I     = w.*conj(w);
    funct = log(mean(I'.*(lambda.^d))) - 2*d*mean(log(lambda));
end
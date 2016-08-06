function d = SFE_gsp(series, a, b, m)
    d = fminbnd(@(d) SFEwhittle(d,series, m), a, b);
end

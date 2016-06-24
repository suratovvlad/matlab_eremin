function Dy = equation_one_dde( t, y, etta )
    inside_cos = 4 * y * t / (t + 1);
    theta = 1/4 * (cos(inside_cos) + 3);
    Dy = exp(theta) * etta;
end


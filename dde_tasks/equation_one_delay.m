function result = equation_one_delay( t, y )

inside_cos = 4 * y * t / (t + 1);
theta = 1/4 * (cos(inside_cos) + 3);

result = t - theta;

end


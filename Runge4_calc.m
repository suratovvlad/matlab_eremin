function [ array_x, array_y, count_calc_ ] = Runge4_calc(tol_, a_, b_, y0)

setGlobalCountCalc(0);

%p - порядок метода. Порядок метода 4
p = 4;

%tol
tol = tol_;

fac = (0.25)^(1/(p+1));
facmax = 1.5;
facmin = 0.1;

% 0 <= x <= 20
a = a_;
b = b_;

y = y0;
x = a;
n = 200;
h = (b - a) / n;

array_y = [y];
array_x = [x];

while x < b
    
    if (x+h>=b)
        h = b - x;
    end
    
    %recalculate steps for each case
    h_2step = h / 2;
    h_1step = h;
    
    % calcule two steps with h
    x_2step = x;
    y_2step = y;
    for i=1:2
        k_1_2step = JACB(0, y_2step);
        k_2_2step = JACB(0, y_2step + 0.5 * h_2step * k_1_2step);
        k_3_2step = JACB(0, y_2step + 0.5 * h_2step * k_2_2step);
        k_4_2step = JACB(0, y_2step + h_2step * k_3_2step);
        y_new_2step = y_2step + 1/6 * h_2step * (k_1_2step + 2 * k_2_2step + 2 * k_3_2step + k_4_2step);
        y_2step = y_new_2step; % y_2
        x_2step = x_2step + h_2step;
    end
    
    %calculate one step with 2h
    x_1step = x;
    y_1step = y;
    
    k_1_1step = JACB(0, y_1step);
    k_2_1step = JACB(0, y_1step + 0.5 * h_1step * k_1_1step);
    k_3_1step = JACB(0, y_1step + 0.5 * h_1step * k_2_1step); 
    k_4_1step = JACB(0, y_1step + h_1step * k_3_1step);
    y_new_1step = y_1step + 1/6 * h_1step * (k_1_1step + 2 * k_2_1step + 2 * k_3_1step + k_4_1step);
    y_1step = y_new_1step; %w
    
    %calculate error
    y_2_roof = y_2step + (y_2step - y_1step)/(2^p - 1);    
    d = max(max(abs(y_2_roof), abs(y)), 10^(-6));
    err = 1 / (2^p - 1) * max(abs(y_2step - y_1step) ./ d);
    
    %calculate new step
    h_new = h * min(facmax, max(facmin, fac * (tol/err)^(1/(p+1)) ));
    %h_new = h * (tol/err)^(1/(p+1));
    
    %decide about result    
    if err <= tol
        x = x + h;
        y = y_2_roof;
        array_y = [array_y, y];
        array_x = [array_x, x];
    end
    h = h_new;    
end

count_calc_ = getGlobalCountCalc * 3;

end


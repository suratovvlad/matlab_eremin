function [ array_x, array_y, count_calc_ ] = Olemskoy3_calc( tol_, a_, b_, y0 )

setGlobalCountCalc( [0; 0; 0] );

%p - порядок метода. Порядок метода Хойна = 3
p = 3;

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
%         k_1_2step = JACB(0, y_2step);
%         k_2_2step = JACB(0, y_2step + 1/3 * h_2step * k_1_2step);
%         k_3_2step = JACB(0, y_2step + 2/3 * h_2step * k_2_2step);    
%         y_new_2step = y_2step + h_2step * (1/4 * k_1_2step + 3/4 * k_3_2step);
%         y_2step = y_new_2step; % y_2

        k_0_1_2step = h_2step * JACB_struct_zero(0, y_2step);
        k_i_1_2step = h_2step * JACB_struct_one(0, y_2step);
        k_j_1_2step = h_2step * JACB_struct_two(0, [ y_2step(1) + 1/3 * k_0_1_2step, y_2step(2) + 1/3 * k_i_1_2step, 0 ]);
        k_0_2_2step = h_2step * JACB_struct_zero(0, [  y_2step(1) + 1/2 * k_0_1_2step,  y_2step(2) + 1/2 * k_i_1_2step, y_2step(3) + 1/2 * k_j_1_2step]);
        k_i_2_2step = h_2step * JACB_struct_one(0, [ y_2step(1) + 2/9 * k_0_1_2step + 4/9 * k_0_2_2step, 0, y_2step(3) + 2/3 * k_j_1_2step]);
        k_j_2_2step = h_2step * JACB_struct_two(0, [ y_2step(1) - 1/3 * k_0_1_2step + 4/3 * k_0_2_2step, y_2step(2) + k_i_2_2step, 0 ] );
        k_0_3_2step = h_2step * JACB_struct_zero(0, [ y_2step(1) - k_0_1_2step + 2 * k_0_2_2step,  y_2step(2) - 1/2 * k_i_1_2step + 3/2 * k_i_2_2step, y_2step(3) + k_j_2_2step ] );

        y_new_0_2step = y_2step(1) + 1/6 * (k_0_1_2step + 4 * k_0_2_2step + k_0_3_2step);
        y_new_i_2step = y_2step(2) + 1/4 * (k_i_1_2step + 3 * k_i_2_2step);
        y_new_j_2step = y_2step(3) + 1/4 * (3 * k_j_1_2step + k_j_2_2step);
        
        y_2step = [y_new_0_2step; y_new_i_2step; y_new_j_2step]; % y_2
        x_2step = x_2step + h_2step;
    end
    
    %calculate one step with 2h
    x_1step = x;
    y_1step = y;
    
    k_0_1_1step = h_1step * JACB_struct_zero(0, y_1step);
    k_i_1_1step = h_1step * JACB_struct_one(0, y_1step);
    k_j_1_1step = h_1step * JACB_struct_two(0, [ y_1step(1) + 1/3 * k_0_1_1step, y_1step(2) + 1/3 * k_i_1_1step, 0 ]);
    k_0_2_1step = h_1step * JACB_struct_zero(0, [  y_1step(1) + 1/2 * k_0_1_1step,  y_1step(2) + 1/2 * k_i_1_1step, y_1step(3) + 1/2 * k_j_1_1step]);
    k_i_2_1step = h_1step * JACB_struct_one(0, [ y_1step(1) + 2/9 * k_0_1_1step + 4/9 * k_0_2_1step, 0, y_1step(3) + 2/3 * k_j_1_1step]);
    k_j_2_1step = h_1step * JACB_struct_two(0, [ y_1step(1) - 1/3 * k_0_1_1step + 4/3 * k_0_2_1step, y_1step(2) + k_i_2_1step, 0 ] );
    k_0_3_1step = h_1step * JACB_struct_zero(0, [ y_1step(1) - k_0_1_1step + 2 * k_0_2_1step,  y_1step(2) - 1/2 * k_i_1_1step + 3/2 * k_i_2_1step, y_1step(3) + k_j_2_1step ] );
    
    y_new_0_1step = y_1step(1) + 1/6 * (k_0_1_1step + 4 * k_0_2_1step + k_0_3_1step);
    y_new_i_1step = y_1step(2) + 1/4 * (k_i_1_1step + 3 * k_i_2_1step);
    y_new_j_1step = y_1step(3) + 1/4 * (3 * k_j_1_1step + k_j_2_1step);
    y_1step = [y_new_0_1step; y_new_i_1step; y_new_j_1step]; %w
    
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

count_calc_ = getGlobalCountCalc;

end



clear all;
setGlobalCountCalc(0);

%p - ������� ������. ������� ������ ����� = 3
p = 3;

%tol
tol = 0.000001;

fac = (0.25)^(1/(p+1));
facmax = 1.5;
facmin = 0.1;
% 0 <= x <= 20
a = 0;
b = 10;

y = [0; 1; 1];

n = 200;
h = (b-a) / n;

x = a;

array_y = [y];
array_x = [x];

while x <= b
    
    %recalculate steps for each case
    h_2step = h / 2;
    h_1step = h;
    
    % calcule two steps with h
    x_2step = x;
    y_2step = y;
    for i=1:2
        k_1_2step = JACB(0, y_2step);
        k_2_2step = JACB(0, y_2step + 1/3 * h_2step * k_1_2step);
        k_3_2step = JACB(0, y_2step + 2/3 * h_2step * k_2_2step);    
        y_new_2step = y_2step + h_2step * (1/4 * k_1_2step + 3/4 * k_3_2step);
        y_2step = y_new_2step; % y_2
        x_2step = x_2step + h_2step;
    end
    
    %calculate one step with 2h
    x_1step = x;
    y_1step = y;
    
    k_1_1step = JACB(0, y_1step);
    k_2_1step = JACB(0, y_1step + 1/3 * h_1step * k_1_1step);
    k_3_1step = JACB(0, y_1step + 2/3 * h_1step * k_2_1step); 
    y_new_1step = y_1step + h_1step * (1/4 * k_1_1step + 3/4 * k_3_1step);
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

figure;
plot(array_x, array_y);
hold on;
plot(array_x, array_y, '+');
hold on;
ode45(@JACB, [a:0.1:b], [0 1 1]);

figure;
display(getGlobalCountCalc*3);

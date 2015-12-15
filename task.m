%task
clear all;
% 0 <= x <= 20
a = 0;
b = 10;
y = [0; 1; 1];

% plot Heun
tol = 10^(-4);
[array_x, array_y, count_calc_] = Heun_calc(tol, a, b, y);
figure;
plot(array_x, array_y);
hold on;
plot(array_x, array_y, '+');
hold on;
ode45(@JACB, [a:0.1:b], [0 1 1]);

%plot count with error Heun
array_i = [];
array_count = [];
for i=3:0.5:6
    %tol
    tol = 10^(-i);
    [array_x, array_y, count_calc_] = Heun_calc(tol, a, b, y);
    array_i = [array_i, i];
    array_count = [array_count, count_calc_];
end
figure;
loglog(array_i, array_count);

% plot Olemskoy 3
tol = 10^(-4);
[array_x, array_y, count_calc_] = Olemskoy3_calc(tol, a, b, y);
figure;
plot(array_x, array_y);
hold on;
plot(array_x, array_y, '+');
hold on;
ode45(@JACB, [a:0.1:b], [0 1 1]);

%plot count with error Olemskoy 3
array_count_old = array_count;
array_i = [];
array_count = [];
for i=3:0.5:6
    %tol
    tol = 10^(-i);
    [array_x, array_y, count_calc_] = Olemskoy3_calc(tol, a, b, y);
    array_i = [array_i, i];
    temp = count_calc_(1) + count_calc_(2) + count_calc_(3);    
    array_count = [array_count , temp];
end
figure;
loglog(array_i, array_count);

%plot same on one graphic
new_array_count = [array_count; array_count_old];
figure;
loglog(array_i, new_array_count);



% plot Runge
tol = 10^(-4);
[array_x, array_y, count_calc_] = Runge4_calc(tol, a, b, y);
figure;
plot(array_x, array_y);
hold on;
plot(array_x, array_y, '+');
hold on;
ode45(@JACB, [a:0.1:b], [0 1 1]);

%plot count with error Runge
array_i = [];
array_count = [];
for i=3:0.5:6
    %tol
    tol = 10^(-i);
    [array_x, array_y, count_calc_] = Runge4_calc(tol, a, b, y);
    array_i = [array_i, i];
    array_count = [array_count, count_calc_];
end
figure;
loglog(array_i, array_count);

% plot Olemskoy 4
tol = 10^(-4);
[array_x, array_y, count_calc_] = Olemskoy4_calc(tol, a, b, y);
figure;
plot(array_x, array_y);
hold on;
plot(array_x, array_y, '+');
hold on;
ode45(@JACB, [a:0.1:b], [0 1 1]);

%plot count with error Olemskoy 4
array_count_old = array_count;
array_i = [];
array_count = [];
for i=3:0.5:6
    %tol
    tol = 10^(-i);
    [array_x, array_y, count_calc_] = Olemskoy4_calc(tol, a, b, y);
    array_i = [array_i, i];
    
    temp = count_calc_(1) + count_calc_(2) + count_calc_(3);    
    array_count = [array_count , temp];    
    
end

figure;
loglog(array_i, array_count);
%plot same on one graphic
new_array_count = [array_count ; array_count_old];
figure;
loglog(array_i, new_array_count);



clear all;

% 0 <= x <= 20
a = 0;
b = 20;
y = [0; 1; 1];

tol = 10^(-4);
[array_x, array_y, count_calc_] = Olemskoy4_calc(tol, a, b, y);
figure;
plot(array_x, array_y);
hold on;
plot(array_x, array_y, '+');
hold on;
ode45(@JACB, [a:0.1:b], [0 1 1]);
    
% array_i = [];
% array_count = [];
% for i=3:0.5:6
%     %tol
%     tol = 10^(-i);
%     [array_x, array_y, count_calc_] = Olemskoy4_calc(tol, a, b, y);
%     
%     figure;
%     plot(array_x, array_y);
%     hold on;
%     plot(array_x, array_y, '+');
%     hold on;
%     ode45(@JACB, [a:0.1:b], [0 1 1]);
% 
% %     array_i = [array_i, i];
% %     array_count = [array_count, count_calc_];
% %     display(count_calc_);
% %     semilogx(array_i, array_count);
% end
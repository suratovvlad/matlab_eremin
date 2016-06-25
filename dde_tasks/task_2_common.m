function task_2_common( DDE_FUN, HISTORY_FUN, DELAY_TIME_FUN, ANALYTICAL_SOLUTION, HISTORY_DERIV_FUN, time_start, time_end )
% DDE_FUN       -   ���������������� ��������� � ������������� ����������
% HISTORY_FUN   -   ������� �������
% DELAY_TIME_FUN    -   ������� ������������
% ANALYTICAL_SOLUTION   -   ������������� �������
% HISTORY_DERIV_FUN
% time_start    -   ������ ������������ ���������
% time_end      -   ����� ������������ ���������

order = 5;          % ������� ������
stage_count = 8;    % ���������� ������ � ������

% ������� ������������� a ������
a_matrix = @MATRIX_A_OF_CERK5_METHOD;
% ������ ������������� b ������
b_vector = @VECTOR_B_OF_CERK5_METHOD;
% ������ ������������� c ������
c_vector = @VECTOR_C_OF_CERK5_METHOD;

% �����������
INTERPOLANT_FUN = @Hermite_interpolant;

steps = [];
errors = [];

for steps_k = 1:8 % ��������� ��� �����
    
    % ���������� �����
    step_count = 5*2^steps_k;    
    % ����� ����
    STEP = (time_end - time_start) / step_count; 
    
    % ������ ���������
    [ T_ARRAY, Y_ARRAY, K_MATRIX, GLOBAL_ERROR, DY_ARRAY ] = dde_solver(a_matrix, b_vector, c_vector, order, stage_count, ...
        DDE_FUN, HISTORY_FUN, DELAY_TIME_FUN, ANALYTICAL_SOLUTION, HISTORY_DERIV_FUN, ...
        time_start, time_end, steps_k, step_count, STEP, INTERPOLANT_FUN);
    
    % ��������� ������� ��� ��������
    steps = [steps, STEP];
    errors = [errors, GLOBAL_ERROR];
   
end


dk = length(steps);
error_ratio = [];
for i = 2 : dk
    error_ratio = [error_ratio, errors(i)/errors(i-1)];
end

step_ratio = [];
for i = 1 : dk - 1
    step_ratio = [step_ratio, steps(i)];
end
    
figure;
plot(log2(step_ratio), -log2(error_ratio));
title('log2(h_k) to log2(err_{k+1} / err_k)');
xlabel('log2(h_k)') % x-axis label
ylabel('log2(err_{k+1} / err_k)') % y-axis label

t_start = log10(steps(1));
t_step = (log10(steps(dk)) - log10(steps(1))) / 10;
t_end = log10(steps(dk));
t = t_start:t_step:t_end;
y = 5 * t + 3.5;

figure;
plot(log10(steps), log10(errors), t, y);
title('log10(h_k) to log10(err_k)');
xlabel('log10(h_k)') % x-axis label
ylabel('log10(err_k)') % y-axis label
legend('h_k / err_k','t / y','Location','southwest');

end


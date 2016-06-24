function task_1_common( DDE_FUN, HISTORY_FUN, DELAY_TIME_FUN, ANALYTICAL_SOLUTION, time_start, time_end )
% DDE_FUN       -   ���������������� ��������� � ������������� ����������
% HISTORY_FUN   -   ������� �������
% DELAY_TIME_FUN    -   ������� ������������
% ANALYTICAL_SOLUTION   -   ������������� �������
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


errors_plot_x = [];
errors_plot_y = [];
errors_plot_x2 = [];
errors_plot_y2 = [];

last_error = 0;
for steps_k = 2:8 % ��������� ��� �����
    
    % ���������� �����
    step_count = 2^steps_k;    
    % ����� ����
    STEP = (time_end - time_start) / step_count; 
    
    % ������ ���������
    [ T_ARRAY, Y_ARRAY, K_MATRIX, GLOBAL_ERROR ] = dde_solver(a_matrix, b_vector, c_vector, order, stage_count, ...
        DDE_FUN, HISTORY_FUN, DELAY_TIME_FUN, ANALYTICAL_SOLUTION, time_start, time_end, steps_k, step_count, STEP);
    
    % ��������� ������� ��� ��������
    errors_plot_x = [errors_plot_x, log10(STEP)];
    errors_plot_y = [errors_plot_y, log10(GLOBAL_ERROR)];
    
    errors_plot_x2 = [errors_plot_x2, log2(STEP)];
    if last_error > 0
        errors_plot_y2 = [errors_plot_y2, log2(GLOBAL_ERROR / last_error)];
    end
    % ���������� ������
    last_error = GLOBAL_ERROR;
end


figure;
loglog( (errors_plot_x2(1: (length(errors_plot_x2) - 1) )), errors_plot_y2);
title('log2(h_k) to log2(err_{k+1} / err_k)');
xlabel('log2(h_k)') % x-axis label
ylabel('log2(err_{k+1} / err_k)') % y-axis label

figure;
loglog(errors_plot_x, errors_plot_y);
title('log10(h_k) to log10(err_k)');
xlabel('log10(h_k)') % x-axis label
ylabel('log10(err_k)') % y-axis label

end


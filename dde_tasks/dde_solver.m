function [ T_ARRAY, Y_ARRAY, K_MATRIX, GLOBAL_ERROR, DY_ARRAY ] = dde_solver( a_matrix, b_vector, c_vector, order, stage_count, ...
 DDE_FUN, HISTORY_FUN, DELAY_TIME_FUN, ANALYTICAL_SOLUTION, HISTORY_DERIV_FUN, ...
 time_start, time_end, steps_k, step_count, STEP, INTERPOLANT_FUN )
% a_matrix  -   ������� ������������� a ������
% b_vector  -   ������ ������������� b ������
% c_vector  -   ������ ������������� c ������
% order     -   ������� ������
% stage_count   -   ���������� ������ � ������
% DDE_FUN       -   ���������������� ��������� � ������������� ����������
% HISTORY_FUN   -   ������� �������
% DELAY_TIME_FUN    -   ������� ������������
% ANALYTICAL_SOLUTION   -   ������������� �������
% HISTORY_DERIV_FUN
% time_start    -   ������ ������������ ���������
% time_end      -   ����� ������������ ���������
% steps_k       -   ��������� ��� �����
% step_count    -	���������� �����
% STEP          -   ����� ����
% INTERPOLANT_FUN   - ������� ����������������

% T_ARRAY   -   ������ �������� ������� �� ������ ����
% Y_ARRAY   -   ������ �������� ������� ������� �� ������ ����

% ������ �������� ������� �� ������ ����
T_ARRAY = zeros(step_count + 1, 1);
% ������ �������� ������� ������� �� ������ ����
Y_ARRAY = zeros(step_count + 1, 1);
% ������� ������������� ��� ������� ����� �� ������ ����
K_MATRIX = zeros(step_count + 1, stage_count);
% ������� ���������� ������������
GLOBAL_ERROR_MATRIX = [];

DY_ARRAY = zeros(step_count + 1, 1);

% ��������� �������� ������� � ������� � ���� �������
T_ARRAY(1) = time_start;
Y_ARRAY(1) = HISTORY_FUN(time_start);
DY_ARRAY(1) = HISTORY_DERIV_FUN(time_start);

step_index = 2;     % ����� ����
time_current = time_start;  % ������� �����

GLOBAL_ERROR = -10;

while time_current < time_end
    
    % ���������� �������� ������� �� ������� ����
    y_value = Y_ARRAY(step_index - 1);
    
    for stage_index = 1:stage_count % ����� �����
        
        % �������� ������������� c �� ������� ��� �������� ������
        c_value = c_vector(stage_index);
        
        % ��������� ����� ����� ��� �����
        new_time_for_stage = time_current + c_value * STEP;       
        
        % �����, �� ������� ����������� �������� �������  
        sum_for_stage = 0;
        for prev_stage = 1: (stage_index - 1) % ��������� �� ���� ���������� ������ ����� ����
            
            % �������� ������������� a �� ������� ��� �������� ������
            a_value = a_matrix(stage_index, prev_stage);
            
            % ����������� �������� ������������ k
            k_value =  K_MATRIX(step_index, prev_stage);
            
            % ����������� �����
            sum_for_stage = sum_for_stage + a_value * k_value;
        end
        
        % ��������� ����� �������� ������� ��� �����
        new_y_for_stage = y_value + STEP * sum_for_stage;

        % ��������� ����-������� �� ����������� ��������� �� ����� �����
        etta_for_stage = etta_func(new_time_for_stage, new_y_for_stage, T_ARRAY, stage_count, ...
            step_index, STEP, K_MATRIX, Y_ARRAY, DY_ARRAY, b_vector, HISTORY_FUN, DELAY_TIME_FUN, INTERPOLANT_FUN);
        
        % ��������� ����� ����������� �� ���� �����
        new_k_stage = DDE_FUN(new_time_for_stage, new_y_for_stage, etta_for_stage);
        K_MATRIX(step_index, stage_index) = new_k_stage;
    end

    % ��������� �������� ������� �� ������ ����
    new_y = get_new_y_value(1, step_index, STEP, stage_count, K_MATRIX, Y_ARRAY, b_vector);
    Y_ARRAY(step_index) = new_y;
    
    % ����������� ����� �� ����� ����
    time_current = time_current + STEP;
    T_ARRAY(step_index) = time_current;
    
    % ��������� ����-������� �� ����������� ��������� �� ����� ����
    etta_for_step = etta_func(time_current, new_y, T_ARRAY, stage_count, ...
        step_index, STEP, K_MATRIX, Y_ARRAY, DY_ARRAY, b_vector, HISTORY_FUN, DELAY_TIME_FUN, INTERPOLANT_FUN);
    
    % ��������� ����������� � ���� �����
    new_dy = DDE_FUN(time_current, new_y, etta_for_step);
    DY_ARRAY(step_index) = new_dy;
    
    
    % ������� ���������� ����������� �� ���� ���� ��� ������������
    % ����������, ����������� �� 100 ������������� ����� ������ ����� ����
    time_left = T_ARRAY(step_index - 1);
    time_right = T_ARRAY(step_index);    
    
    timer_step = (time_right - time_left) / 100;
    timer = time_left;
    while timer < time_right
        
        numerical_answer = delaying_func(timer, step_index, STEP, stage_count, K_MATRIX, Y_ARRAY, b_vector);
        analitycal_answer = ANALYTICAL_SOLUTION(timer);
        
        error_for_step = abs(numerical_answer - analitycal_answer);
        
        if error_for_step > GLOBAL_ERROR
            GLOBAL_ERROR = error_for_step;
        end
        
        timer = timer + timer_step;
    end
    
    % ����������� ������� ������� ����
    step_index = step_index + 1;
end


x = time_start:0.01:time_end;
y = ANALYTICAL_SOLUTION(x);

figure;
plot(T_ARRAY, Y_ARRAY, x, y);

title(['Graph of Numerical and Analitycal Solutions with step = '  num2str(STEP)]);
xlabel('time') % x-axis label
ylabel('function values') % y-axis label
legend('y = Numerical','y = Analitycal','Location','southwest');
end


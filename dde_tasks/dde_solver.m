function [ T_ARRAY, Y_ARRAY ] = dde_solver( a_matrix, b_vector, c_vector, order, stage_count, ...
 DDE_FUN, HISTORY_FUN, DELAY_TIME_FUN, ANALYTICAL_SOLUTION, time_start, time_end, steps_k )
% a_matrix  -   ������� ������������� a ������
% b_vector  -   ������ ������������� b ������
% c_vector  -   ������ ������������� c ������
% order     -   ������� ������
% stage_count   -   ���������� ������ � ������
% DDE_FUN       -   ���������������� ��������� � ������������� ����������
% HISTORY_FUN   -   ������� �������
% DELAY_TIME_FUN    -   ������� ������������
% ANALYTICAL_SOLUTION   -   ������������� �������
% time_start    -   ������ ������������ ���������
% time_end      -   ����� ������������ ���������
% steps_k       -   ��������� ��� �����

% T_ARRAY   -   ������ �������� ������� �� ������ ����
% Y_ARRAY   -   ������ �������� ������� ������� �� ������ ����


% ���������� �����
step_count = 2^steps_k;    
% ����� ����
STEP = (time_end - time_start) / step_count; 

% ������ �������� ������� �� ������ ����
T_ARRAY = zeros(step_count + 1, 1);
% ������ �������� ������� ������� �� ������ ����
Y_ARRAY = zeros(step_count + 1, 1);
% ������� ������������� ��� ������� ����� �� ������ ����
K_MATRIX = zeros(step_count + 1, stage_count); 

% ��������� �������� ������� � ������� � ���� �������
T_ARRAY(1) = time_start;
Y_ARRAY(1) = HISTORY_FUN(time_start);

step_index = 2;     % ����� ����
time_current = time_start;  % ������� �����

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
        etta_for_stage = etta_func(new_time_for_stage, new_y_for_stage, T_ARRAY, stage_count, step_index, STEP, K_MATRIX, Y_ARRAY, b_vector, HISTORY_FUN, DELAY_TIME_FUN);
        
        % ��������� ����� ����������� �� ���� �����
        new_k_stage = DDE_FUN(new_time_for_stage, new_y_for_stage, etta_for_stage);
        K_MATRIX(step_index, stage_index) = new_k_stage;
    end

    % ��������� �������� ������� �� ������ ����
    new_y = delaying_func(1, step_index, STEP, stage_count, K_MATRIX, Y_ARRAY, b_vector);
    Y_ARRAY(step_index) = new_y;
    
    % ����������� ����� �� ����� ����
    time_current = time_current + STEP;
    T_ARRAY(step_index) = time_current;
    
    % ����������� ������� ������� ����
    step_index = step_index + 1;
end

end


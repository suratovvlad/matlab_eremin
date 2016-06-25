function result = CERK5_interpolant( delayed_t, current_step_index, STEP, stage_count, ...
    K_MATRIX, Y_ARRAY, DY_ARRAY, B_VECTOR_FUN, T_ARRAY )
    % delayed_t             - �������� �������, � ������� ���������
    %                         ����������������� �������� �������
    % current_step_index 	- ������ �������� ����                
    % STEP                  - ��� ������
    % stage_count   - ���������� ������ ������
    % K_MATRIX      - ������� �������������. 
    %                 �����������: [���������� ����� x ���������� ������]
    % Y_ARRAY       - ������ �������� ������� �� ������ ����
    % DY_ARRAY      - ������ �������� ����������� �� ������ ����
    % B_VECTOR_FUN  - ������ ������������� b ������
    % T_ARRAY       - ������ �������� ������� �� ������ ����
    
    
    % ������� ��������, ���� �������� ������������    
    step_index = find_time_interval(delayed_t, T_ARRAY, current_step_index);

    % �������� �� ����� ������� ���������
    t_left = T_ARRAY(step_index); 

    % �������� �� ������ ������� ���������
    t_right = T_ARRAY(step_index + 1);

    % ��������� ����
    theta = (delayed_t - t_left) / (t_right - t_left);
        
    
    result = get_new_y_value(theta, step_index + 1, STEP, stage_count, K_MATRIX, Y_ARRAY, B_VECTOR_FUN);
end


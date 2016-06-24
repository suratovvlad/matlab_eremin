function result = etta_func( t, y, T_ARRAY, stage_count, current_step_index, STEP, K_MATRIX, Y_ARRAY, B_VECTOR_FUN, HISTORY_FUN, DELAY_TIME_FUN )
    % t             - ������� �������� ������� �� ������ ���� � ������ ����� 
    % y             - ������� �������� ������� �� ������ ���� � ������ ����� 
    % T_ARRAY       - ������ �������� ������� �� ������ ����
    % stage_count   - ���������� ������ ������
    % current_step_index 	- ������ �������� ����
    % STEP          - ��� ������
    % K_MATRIX      - ������� �������������. 
    %                 �����������: [���������� ����� x ���������� ������]
    % Y_ARRAY       - ������ �������� ������� �� ������ ����
    % B_VECTOR_FUN  - ������ ������������� b ������
    % HISTORY_FUN   - ������� �������
    % DELAY_TIME_FUN    - ������� ������������
    
    
    % ��������� ������������
    delayed_t = DELAY_TIME_FUN(t, y);
    
    % �����, ��� ������������� �������
    time0 = T_ARRAY(1);
    
    if delayed_t <= time0
        result = HISTORY_FUN(delayed_t);
    else
        % ������� ��������, ���� �������� ������������    
        step_index = find_time_interval(delayed_t, T_ARRAY, current_step_index);
        
        % �������� �� ����� ������� ���������
        t_left = T_ARRAY(step_index); 
        
        % �������� �� ������ ������� ���������
        t_right = T_ARRAY(step_index + 1);

        % ��������� ����
        theta = (delayed_t - t_left) / (t_right - t_left);
        
        % ��������� �������� �� ���� ����
        delayed_value = delaying_func(theta, step_index + 1, STEP, stage_count, K_MATRIX, Y_ARRAY, B_VECTOR_FUN);
        
        % ���������� ���������
        result = delayed_value;
    end

end


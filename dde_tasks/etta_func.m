function result = etta_func( t, y, T_ARRAY, stage_count, current_step_index, STEP, K_MATRIX, Y_ARRAY, DY_ARRAY, ...
    B_VECTOR_FUN, HISTORY_FUN, DELAY_TIME_FUN, INTERPOLANT_FUN )
    % t             - ������� �������� ������� �� ������ ���� � ������ ����� 
    % y             - ������� �������� ������� �� ������ ���� � ������ ����� 
    % T_ARRAY       - ������ �������� ������� �� ������ ����
    % stage_count   - ���������� ������ ������
    % current_step_index 	- ������ �������� ����
    % STEP          - ��� ������
    % K_MATRIX      - ������� �������������. 
    %                 �����������: [���������� ����� x ���������� ������]
    % Y_ARRAY       - ������ �������� ������� �� ������ ����
    % DY_ARRAY      - ������ �������� ����������� �� ������ ����
    % B_VECTOR_FUN  - ������ ������������� b ������
    % HISTORY_FUN   - ������� �������
    % DELAY_TIME_FUN    - ������� ������������
    % INTERPOLANT_FUN   - ������� ����������������
    
    % ��������� ������������
    delayed_t = DELAY_TIME_FUN(t, y);
    
    % �����, ��� ������������� �������
    time0 = T_ARRAY(1);
    
    if delayed_t <= time0
        result = HISTORY_FUN(delayed_t);
    else
        
        
        % ��������� �������� �� ���� ����
        delayed_value = INTERPOLANT_FUN(delayed_t, current_step_index, STEP, stage_count, ...
            K_MATRIX, Y_ARRAY, DY_ARRAY, B_VECTOR_FUN, T_ARRAY );
        
        % ���������� ���������
        result = delayed_value;
    end

end


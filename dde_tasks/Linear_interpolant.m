function result = Linear_interpolant( theta, current_step_index, STEP, stage_count, ...
    K_MATRIX, Y_ARRAY, DY_ARRAY, B_VECTOR_FUN, T_ARRAY )
    % theta                 - �������� �������, � ������� ���������
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
    step_index = find_time_interval(theta, T_ARRAY, current_step_index);
    
    % �������� ������� �� ���������� ����
    time_left = T_ARRAY(step_index);
    
    % �������� ������� �� ������� ����
    time_right = T_ARRAY(step_index + 1);
    
    % �������� ������� �� ���������� ����
    y_value_left = Y_ARRAY(step_index);
    
    % �������� ������� �� ������� ����
    y_value_right = Y_ARRAY(step_index + 1);
    
    x = [time_left, time_right];
    f = [y_value_left, y_value_right];
    
    % �������� ������������
    final = interp1(x, f, theta);
         
    % ������������ ��������
    result = final;    
    
end
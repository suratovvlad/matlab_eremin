function result = get_new_y_value( theta, current_step_index, STEP, stage_count, K_MATRIX, Y_ARRAY, B_VECTOR_FUN )
    % theta                 - �������� �������, � ������� ���������
    %                         ����������������� �������� �������
    % current_step_index 	- ������ �������� ����                
    % STEP                  - ��� ������
    % stage_count   - ���������� ������ ������
    % K_MATRIX      - ������� �������������. 
    %                 �����������: [���������� ����� x ���������� ������]
    % Y_ARRAY       - ������ �������� ������� �� ������ ����
    % B_VECTOR_FUN  - ������ ������������� b ������
    
    % �����, �� ������� ����������� �������� �������    
    sum_for_step = 0;
    for stage_index = 1:stage_count % ����� �����
        
        % �������� �� �������-������������� b ��� �������� ������
        b_value = B_VECTOR_FUN(theta, stage_index);
        
        % ����������� �������� ������������ k
        k_value = K_MATRIX(current_step_index, stage_index);
        
        % ����������� �����
        sum_for_step = sum_for_step + b_value * k_value;
    end
    
    % �������� ������� �� ���������� ����
    y_value = Y_ARRAY(current_step_index - 1);
        
    % ��������� ���������
    result = y_value + STEP * sum_for_step;    

end


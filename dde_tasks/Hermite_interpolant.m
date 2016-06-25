function result = Hermite_interpolant( theta, current_step_index, STEP, stage_count, ...
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
    
    % �������� ����������� ������� �� ���������� ����
    dy_value_left = DY_ARRAY(step_index);
    
    % �������� ����������� ������� �� ������� ����
    dy_value_right = DY_ARRAY(step_index + 1);
    
    x = [time_left, time_right];
    f = [y_value_left, y_value_right];
    df = [dy_value_left, dy_value_right];
    
    % ������������� �������
    % ������� ��� ���� �����, �������� ������� � �������� ����������� � ���
    
    p0 = f(1);    
    alpha1 = df(1);
    temp1 = (f(2) - f(1)) / (x(2) - x(1));
    temp2 = df(2);
    alpha2 = (temp1 - alpha1) / (x(2) - x(1));
    temp3  = (temp2 - temp1) / (x(2) - x(1));
    alpha3 = (temp3 - alpha2) / (x(2) - x(1));
    
    % ��� �������� ������� � ����� theta
    final = p0 + alpha1 * (theta - x(1)) + alpha2 * ((theta - x(1))^2) + alpha3 * ((theta - x(1))^2) * (theta - x(2));
        
    % ������������ ��������
    result = final;    
    
end

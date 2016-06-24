function left_index = find_time_interval( time, T_ARRAY, current_step_index )
    % time                  - �������� �������, ������� ���������� ������� 
    %                         �������� �������
    % T_ARRAY               - ������ �������� ������� �� ������ ����
    % current_step_index    - ������ �������� ����

    % ����������� �� ���� ��������������� �����
    for step_index = 2 : current_step_index
        
        % ���������� ����� ������ �������� ��������� �������
        left_index = step_index - 1;
        
        % ��������, ������ �� � ��������� �������� ��� ���
        if T_ARRAY(step_index) > time
            % ���� � ��������� �������� �� ������, �� ����� �������
            % �������� ������� - �������
            break;
        end
    end
    
end


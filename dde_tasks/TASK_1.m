function [ DDE_FUN, HISTORY_FUN, DELAY_TIME_FUN, ANALYTICAL_SOLUTION, HISTORY_DERIV_FUN, time_start, time_end ] = TASK_1()

    % ���������������� ��������� � ������������� ����������
    DDE_FUN = @paul127_function;
    % ������� �������
    HISTORY_FUN = @paul127_history;
    % ������� ������������
    DELAY_TIME_FUN = @paul127_delay_time;
    % ������������� �������
    ANALYTICAL_SOLUTION = @paul127_solution;
    % ����������� ������� �������
    HISTORY_DERIV_FUN = @paul127_histoty_deriv;

    % ������ ������������ ���������
    time_start = 2;
    % ����� ������������ ���������
    time_end = 3;

end


% ���������������� ��������� � ������������� ����������
DDE_FUN = @simple_test_dde;
% ������� �������
HISTORY_FUN = @exp;
% ������� ������������
DELAY_TIME_FUN = @paul127_delay_time;
% ������������� �������
ANALYTICAL_SOLUTION = @simple_test_solution;
% ����������� ������� �������
HISTORY_DERIV_FUN = @exp;

% ������ ������������ ���������
time_start = 0.1;
% ����� ������������ ���������
time_end = 3;


% ������ ������
task_A_common(DDE_FUN, HISTORY_FUN, DELAY_TIME_FUN, ANALYTICAL_SOLUTION, HISTORY_DERIV_FUN, time_start, time_end);
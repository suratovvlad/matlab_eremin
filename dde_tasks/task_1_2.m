clear;

% ���������������� ��������� � ������������� ����������
DDE_FUN = @equation_one_dde;
% ������� �������
HISTORY_FUN = @equation_one_history;
% ������� ������������
DELAY_TIME_FUN = @equation_one_delay;
% ������������� �������
ANALYTICAL_SOLUTION = @equation_one_solution;

% ������ ������������ ���������
time_start = 0;
% ����� ������������ ���������
time_end = 2;

task_1_common(DDE_FUN, HISTORY_FUN, DELAY_TIME_FUN, ANALYTICAL_SOLUTION, time_start, time_end);


clear;

% ���������������� ��������� � ������������� ����������
DDE_FUN = @paul127_function;
% ������� �������
HISTORY_FUN = @history_func;
% ������� ������������
DELAY_TIME_FUN = @paul127_delay_time;
% ������������� �������
ANALYTICAL_SOLUTION = @log;

% ������ ������������ ���������
time_start = 2;
% ����� ������������ ���������
time_end = 3;

task_1_common(DDE_FUN, HISTORY_FUN, DELAY_TIME_FUN, ANALYTICAL_SOLUTION, time_start, time_end);
function task_3_common( DDE_FUN, HISTORY_FUN, DELAY_TIME_FUN, ANALYTICAL_SOLUTION, HISTORY_DERIV_FUN, time_start, time_end )
% DDE_FUN       -   ���������������� ��������� � ������������� ����������
% HISTORY_FUN   -   ������� �������
% DELAY_TIME_FUN    -   ������� ������������
% ANALYTICAL_SOLUTION   -   ������������� �������
% HISTORY_DERIV_FUN
% time_start    -   ������ ������������ ���������
% time_end      -   ����� ������������ ���������

% �����������
INTERPOLANT_FUN = @Linear_interpolant;

tasks_common( DDE_FUN, HISTORY_FUN, DELAY_TIME_FUN, ANALYTICAL_SOLUTION, HISTORY_DERIV_FUN, time_start, time_end, INTERPOLANT_FUN );

end


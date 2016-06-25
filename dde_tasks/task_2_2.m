clear;

% дхттепемжхюкэмне спюбмемхе я гюоюгдшбючыхл юпцслемрнл
DDE_FUN = @equation_one_dde;
% тсмйжхъ хярнпхх
HISTORY_FUN = @equation_one_history;
% тсмйжхъ гюоюгдшбюмхъ
DELAY_TIME_FUN = @equation_one_delay;
% юмюкхрхвеяйне пеьемхе
ANALYTICAL_SOLUTION = @equation_one_solution;

HISTORY_DERIV_FUN = @equation_one_history_deriv;

% мювюкн хяякедселнцн хмрепбюкю
time_start = 0;
% йнмеж хяякедселнцн хмрепбюкю
time_end = 2;

task_2_common(DDE_FUN, HISTORY_FUN, DELAY_TIME_FUN, ANALYTICAL_SOLUTION, HISTORY_DERIV_FUN, time_start, time_end);


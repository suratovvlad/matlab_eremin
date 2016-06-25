clear;

% дхттепемжхюкэмне спюбмемхе я гюоюгдшбючыхл юпцслемрнл
DDE_FUN = @paul127_function;
% тсмйжхъ хярнпхх
HISTORY_FUN = @history_func;
% тсмйжхъ гюоюгдшбюмхъ
DELAY_TIME_FUN = @paul127_delay_time;
% юмюкхрхвеяйне пеьемхе
ANALYTICAL_SOLUTION = @log;

HISTORY_DERIV_FUN = @paul127_histoty_deriv;

% мювюкн хяякедселнцн хмрепбюкю
time_start = 2;
% йнмеж хяякедселнцн хмрепбюкю
time_end = 3;

task_3_common(DDE_FUN, HISTORY_FUN, DELAY_TIME_FUN, ANALYTICAL_SOLUTION, HISTORY_DERIV_FUN, time_start, time_end);
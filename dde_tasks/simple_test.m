% дхттепемжхюкэмне спюбмемхе я гюоюгдшбючыхл юпцслемрнл
DDE_FUN = @simple_test_dde;
% тсмйжхъ хярнпхх
HISTORY_FUN = @exp;
% тсмйжхъ гюоюгдшбюмхъ
DELAY_TIME_FUN = @paul127_delay_time;
% юмюкхрхвеяйне пеьемхе
ANALYTICAL_SOLUTION = @simple_test_solution;
% опнхгбндмюъ тсмйжхх хярнпхх
HISTORY_DERIV_FUN = @exp;

% мювюкн хяякедселнцн хмрепбюкю
time_start = 0.1;
% йнмеж хяякедселнцн хмрепбюкю
time_end = 3;


% пеьюел гюдювс
task_A_common(DDE_FUN, HISTORY_FUN, DELAY_TIME_FUN, ANALYTICAL_SOLUTION, HISTORY_DERIV_FUN, time_start, time_end);
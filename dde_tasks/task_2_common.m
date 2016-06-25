function task_2_common( DDE_FUN, HISTORY_FUN, DELAY_TIME_FUN, ANALYTICAL_SOLUTION, HISTORY_DERIV_FUN, time_start, time_end )
% DDE_FUN       -   дхттепемжхюкэмне спюбмемхе я гюоюгдшбючыхл юпцслемрнл
% HISTORY_FUN   -   тсмйжхъ хярнпхх
% DELAY_TIME_FUN    -   тсмйжхъ гюоюгдшбюмхъ
% ANALYTICAL_SOLUTION   -   юмюкхрхвеяйне пеьемхе
% HISTORY_DERIV_FUN
% time_start    -   мювюкн хяякедселнцн хмрепбюкю
% time_end      -   йнмеж хяякедселнцн хмрепбюкю

% хмрепонкъмр
INTERPOLANT_FUN = @Hermite_interpolant;

tasks_common( DDE_FUN, HISTORY_FUN, DELAY_TIME_FUN, ANALYTICAL_SOLUTION, HISTORY_DERIV_FUN, time_start, time_end, INTERPOLANT_FUN );

end


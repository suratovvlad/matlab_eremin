clear;

order = 5;          % онпъднй лерндю
stage_count = 8;    % йнкхвеярбн щрюонб б лернде

% люрпхжю йнщттхжхемрнб a лерндю
a_matrix = @MATRIX_A_OF_CERK5_METHOD;
% бейрнп йнщттхжхемрнб b лерндю
b_vector = @VECTOR_B_OF_CERK5_METHOD;
% бейрнп йнщттхжхемрнб c лерндю
c_vector = @VECTOR_C_OF_CERK5_METHOD;

% дхттепемжхюкэмне спюбмемхе я гюоюгдшбючыхл юпцслемрнл
% DDE_FUN = @paul127_function;
% DDE_FUN = @equation_one_dde;

% тсмйжхъ хярнпхх
% HISTORY_FUN = @history_func;
% HISTORY_FUN = @equation_one_history;

% тсмйжхъ гюоюгдшбюмхъ
% DELAY_TIME_FUN = @paul127_delay_time;
% DELAY_TIME_FUN = @equation_one_delay;

% юмюкхрхвеяйне пеьемхе
% ANALYTICAL_SOLUTION = @log;
% ANALYTICAL_SOLUTION = @equation_one_solution;
        
time_start = 0;     % мювюкн хяякедселнцн хмрепбюкю
time_end = 2;       % йнмеж хяякедселнцн хмрепбюкю
steps_k = 8;        % лмнфхрекэ дкъ ьюцнб

[ T_ARRAY, Y_ARRAY ] = dde_solver(a_matrix, b_vector, c_vector, order, stage_count, ...
    DDE_FUN, HISTORY_FUN, DELAY_TIME_FUN, ANALYTICAL_SOLUTION, time_start, time_end, steps_k);

% 
% for step_index = 2:step_count
%     
%     time_left = T_ARRAY(step_index - 1);
%     time_right = T_ARRAY(step_index);
%     
%     timer = time_left:0.01:time_right;
%     
%     
%     
% end


figure
plot(T_ARRAY, Y_ARRAY)

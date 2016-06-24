clear;

order = 5;          % ПОРЯДОК МЕТОДА
stage_count = 8;    % КОЛИЧЕСТВО ЭТАПОВ В МЕТОДЕ

% МАТРИЦА КОЭФФИЦИЕНТОВ a МЕТОДА
a_matrix = @MATRIX_A_OF_CERK5_METHOD;
% ВЕКТОР КОЭФФИЦИЕНТОВ b МЕТОДА
b_vector = @VECTOR_B_OF_CERK5_METHOD;
% ВЕКТОР КОЭФФИЦИЕНТОВ c МЕТОДА
c_vector = @VECTOR_C_OF_CERK5_METHOD;

% ДИФФЕРЕНЦИАЛЬНОЕ УРАВНЕНИЕ С ЗАПАЗДЫВАЮЩИМ АРГУМЕНТОМ
% DDE_FUN = @paul127_function;
% DDE_FUN = @equation_one_dde;

% ФУНКЦИЯ ИСТОРИИ
% HISTORY_FUN = @history_func;
% HISTORY_FUN = @equation_one_history;

% ФУНКЦИЯ ЗАПАЗДЫВАНИЯ
% DELAY_TIME_FUN = @paul127_delay_time;
% DELAY_TIME_FUN = @equation_one_delay;

% АНАЛИТИЧЕСКОЕ РЕШЕНИЕ
% ANALYTICAL_SOLUTION = @log;
% ANALYTICAL_SOLUTION = @equation_one_solution;
        
time_start = 0;     % НАЧАЛО ИССЛЕДУЕМОГО ИНТЕРВАЛА
time_end = 2;       % КОНЕЦ ИССЛЕДУЕМОГО ИНТЕРВАЛА
steps_k = 8;        % МНОЖИТЕЛЬ ДЛЯ ШАГОВ

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

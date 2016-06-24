function [ T_ARRAY, Y_ARRAY ] = dde_solver( a_matrix, b_vector, c_vector, order, stage_count, ...
 DDE_FUN, HISTORY_FUN, DELAY_TIME_FUN, ANALYTICAL_SOLUTION, time_start, time_end, steps_k )
% a_matrix  -   МАТРИЦА КОЭФФИЦИЕНТОВ a МЕТОДА
% b_vector  -   ВЕКТОР КОЭФФИЦИЕНТОВ b МЕТОДА
% c_vector  -   ВЕКТОР КОЭФФИЦИЕНТОВ c МЕТОДА
% order     -   ПОРЯДОК МЕТОДА
% stage_count   -   КОЛИЧЕСТВО ЭТАПОВ В МЕТОДЕ
% DDE_FUN       -   ДИФФЕРЕНЦИАЛЬНОЕ УРАВНЕНИЕ С ЗАПАЗДЫВАЮЩИМ АРГУМЕНТОМ
% HISTORY_FUN   -   ФУНКЦИЯ ИСТОРИИ
% DELAY_TIME_FUN    -   ФУНКЦИЯ ЗАПАЗДЫВАНИЯ
% ANALYTICAL_SOLUTION   -   АНАЛИТИЧЕСКОЕ РЕШЕНИЕ
% time_start    -   НАЧАЛО ИССЛЕДУЕМОГО ИНТЕРВАЛА
% time_end      -   КОНЕЦ ИССЛЕДУЕМОГО ИНТЕРВАЛА
% steps_k       -   МНОЖИТЕЛЬ ДЛЯ ШАГОВ

% T_ARRAY   -   ВЕКТОР ЗНАЧЕНИЙ ВРЕМЕНИ НА КАЖДОМ ШАГЕ
% Y_ARRAY   -   ВЕКТОР ЗНАЧЕНИЙ ИСКОМОЙ ФУНКЦИИ НА КАЖДОМ ШАГЕ


% КОЛИЧЕСТВО ШАГОВ
step_count = 2^steps_k;    
% ДЛИНА ШАГА
STEP = (time_end - time_start) / step_count; 

% ВЕКТОР ЗНАЧЕНИЙ ВРЕМЕНИ НА КАЖДОМ ШАГЕ
T_ARRAY = zeros(step_count + 1, 1);
% ВЕКТОР ЗНАЧЕНИЙ ИСКОМОЙ ФУНКЦИИ НА КАЖДОМ ШАГЕ
Y_ARRAY = zeros(step_count + 1, 1);
% МАТРИЦА КОЭФФИЦИЕНТОВ ДЛЯ КАЖДОГО ЭТАПА НА КАЖДОМ ШАГЕ
K_MATRIX = zeros(step_count + 1, stage_count); 

% НАЧАЛЬНЫЕ ЗНАЧЕНИЯ ВРЕМЕНИ И ФУНКЦИИ В ЭТОМ ВРЕМЕНИ
T_ARRAY(1) = time_start;
Y_ARRAY(1) = HISTORY_FUN(time_start);

step_index = 2;     % НОМЕР ШАГА
time_current = time_start;  % ТЕКУЩЕЕ ВРЕМЯ

while time_current < time_end
    
    % ЗАПОМИНАЕМ ЗНАЧЕНИЕ ФУНКЦИИ НА ПРОШЛОМ ШАГЕ
    y_value = Y_ARRAY(step_index - 1);
    
    for stage_index = 1:stage_count % НОМЕР ЭТАПА
        
        % ЗНАЧЕНИЕ КОЭФФИЦИЕНТОВ c ИЗ ВЕКТОРА ДЛЯ ТЕКУЩЕГО МЕТОДА
        c_value = c_vector(stage_index);
        
        % ВЫЧИСЛЯЕМ НОВОЕ ВРЕМЯ ДЛЯ ЭТАПА
        new_time_for_stage = time_current + c_value * STEP;       
        
        % СУММА, НА КОТОРУЮ УВЕЛИЧИВАЕМ ЗНАЧЕНИЕ ФУНКЦИИ  
        sum_for_stage = 0;
        for prev_stage = 1: (stage_index - 1) % ПРОБЕГАЕМ ПО ВСЕМ ПРЕДЫДУЩЕМ ЭТАПАМ ЭТОГО ШАГА
            
            % ЗНАЧЕНИЕ КОЭФФИЦИЕНТОВ a ИЗ МАТРИЦЫ ДЛЯ ТЕКУЩЕГО МЕТОДА
            a_value = a_matrix(stage_index, prev_stage);
            
            % НЕОБХОДИМОЕ ЗНАЧЕНИЕ КОЭФФИЦИЕНТА k
            k_value =  K_MATRIX(step_index, prev_stage);
            
            % УВЕЛИЧИВАЕМ СУММУ
            sum_for_stage = sum_for_stage + a_value * k_value;
        end
        
        % ВЫЧИСЛЯЕМ НОВОЕ ЗНАЧЕНИЕ ФУНКЦИИ ДЛЯ ЭТАПА
        new_y_for_stage = y_value + STEP * sum_for_stage;

        % ВЫЧИСЛЯЕМ ЭТТА-ФУНКЦИЮ ПО ВЫЧИСЛЕННЫМ ЗНАЧЕНИЯМ ДО ЭТОГО ЭТАПА
        etta_for_stage = etta_func(new_time_for_stage, new_y_for_stage, T_ARRAY, stage_count, step_index, STEP, K_MATRIX, Y_ARRAY, b_vector, HISTORY_FUN, DELAY_TIME_FUN);
        
        % ВЫЧИСЛЯЕМ НОВЫЙ КОЭФФИЦИЕНТ НА ЭТОМ ЭТАПЕ
        new_k_stage = DDE_FUN(new_time_for_stage, new_y_for_stage, etta_for_stage);
        K_MATRIX(step_index, stage_index) = new_k_stage;
    end

    % ВЫЧИСЛЯЕМ ЗНАЧЕНИЕ ФУНКЦИИ НА ДАННОМ ШАГЕ
    new_y = delaying_func(1, step_index, STEP, stage_count, K_MATRIX, Y_ARRAY, b_vector);
    Y_ARRAY(step_index) = new_y;
    
    % УВЕЛИЧИВАЕМ ВРЕМЯ НА ДЛИНУ ШАГА
    time_current = time_current + STEP;
    T_ARRAY(step_index) = time_current;
    
    % УВЕЛИЧИВАЕМ ТЕКУЩИЙ СЧЕТЧИК ШАГА
    step_index = step_index + 1;
end

end


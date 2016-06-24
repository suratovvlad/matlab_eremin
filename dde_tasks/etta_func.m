function result = etta_func( t, y, T_ARRAY, stage_count, current_step_index, STEP, K_MATRIX, Y_ARRAY, B_VECTOR_FUN, HISTORY_FUN, DELAY_TIME_FUN )
    % t             - ТЕКУЩЕЕ ЗНАЧЕНИЕ ВРЕМЕНИ НА ДАННОМ ШАГЕ И ДАННОМ ЭТАПЕ 
    % y             - ТЕКУЩЕЕ ЗНАЧЕНИЕ ФУНКЦИИ НА ДАННОМ ШАГЕ И ДАННОМ ЭТАПЕ 
    % T_ARRAY       - ВЕКТОР ЗНАЧЕНИЙ ВРЕМЕНИ НА КАЖДОМ ШАГЕ
    % stage_count   - КОЛИЧЕСТВО ЭТАПОВ МЕТОДА
    % current_step_index 	- ИНДЕКС ТЕКУЩЕГО ШАГА
    % STEP          - ШАГ МЕТОДА
    % K_MATRIX      - МАТРИЦА КОЭФФИЦИЕНТОВ. 
    %                 РАЗМЕРНОСТЬ: [КОЛИЧЕСТВО ШАГОВ x КОЛИЧЕСТВО ЭТАПОВ]
    % Y_ARRAY       - ВЕКТОР ЗНАЧЕНИЙ ФУНКЦИИ НА КАЖДОМ ШАГЕ
    % B_VECTOR_FUN  - ВЕКТОР КОЭФФИЦИЕНТОВ b МЕТОДА
    % HISTORY_FUN   - ФУНКЦИЯ ИСТОРИИ
    % DELAY_TIME_FUN    - ФУНКЦИЯ ЗАПАЗДЫВАНИЯ
    
    
    % ВЫЧИСЛЯЕМ ЗАПАЗДЫВАНИЕ
    delayed_t = DELAY_TIME_FUN(t, y);
    
    % ВРЕМЯ, ГДЕ ЗАКАНЧИВАЕТСЯ ИСТОРИЯ
    time0 = T_ARRAY(1);
    
    if delayed_t <= time0
        result = HISTORY_FUN(delayed_t);
    else
        % НАХОДИМ ИНТРЕВАЛ, КУДА ПОПАДАЕТ ЗАПАЗДЫВАНИЕ    
        step_index = find_time_interval(delayed_t, T_ARRAY, current_step_index);
        
        % ЗНАЧЕНИЕ НА ЛЕВОЙ ГРАНИЦЕ ИНТЕРВАЛА
        t_left = T_ARRAY(step_index); 
        
        % ЗНАЧЕНИЕ НА ПРАВОЙ ГРАНИЦЕ ИНТЕРВАЛА
        t_right = T_ARRAY(step_index + 1);

        % ВЫЧИСЛЯЕМ ТЕТУ
        theta = (delayed_t - t_left) / (t_right - t_left);
        
        % ВЫЧИСЛЯЕМ ЗНАЧЕНИЕ ОТ ЭТОЙ ТЕТЫ
        delayed_value = delaying_func(theta, step_index + 1, STEP, stage_count, K_MATRIX, Y_ARRAY, B_VECTOR_FUN);
        
        % ЗАПИСЫВАЕМ РЕЗУЛЬТАТ
        result = delayed_value;
    end

end


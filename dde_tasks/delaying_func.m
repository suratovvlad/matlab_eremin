function result = delaying_func( theta, current_step_index, STEP, stage_count, K_MATRIX, Y_ARRAY, B_VECTOR_FUN)
    % theta                 - ПАРАМЕТР ВРЕМЕНИ, В КОТОРОМ ВЫЧИСЛЯЕМ
    %                         ИНТЕРПОЛИРОВАННОЕ ЗНАЧЕНИЕ ФУНКЦИИ
    % current_step_index 	- ИНДЕКС ТЕКУЩЕГО ШАГА                
    % STEP                  - ШАГ МЕТОДА
    % stage_count   - КОЛИЧЕСТВО ЭТАПОВ МЕТОДА
    % K_MATRIX      - МАТРИЦА КОЭФФИЦИЕНТОВ. 
    %                 РАЗМЕРНОСТЬ: [КОЛИЧЕСТВО ШАГОВ x КОЛИЧЕСТВО ЭТАПОВ]
    % Y_ARRAY       - ВЕКТОР ЗНАЧЕНИЙ ФУНКЦИИ НА КАЖДОМ ШАГЕ
    % B_VECTOR_FUN  - ВЕКТОР КОЭФФИЦИЕНТОВ b МЕТОДА
    
    % СУММА, НА КОТОРУЮ УВЕЛИЧИВАЕМ ЗНАЧЕНИЕ ФУНКЦИИ    
    sum_for_step = 0;
    for stage_index = 1:stage_count % НОМЕР ЭТАПА
        
        % ЗНАЧЕНИЕ ИЗ ФУНКЦИЙ-КОЭФФИЦИЕНТОВ b ДЛЯ ТЕКУЩЕГО МЕТОДА
        b_value = B_VECTOR_FUN(theta, stage_index);
        
        % НЕОБХОДИМОЕ ЗНАЧЕНИЕ КОЭФФИЦИЕНТА k
        k_value = K_MATRIX(current_step_index, stage_index);
        
        % УВЕЛИЧИВАЕМ СУММУ
        sum_for_step = sum_for_step + b_value * k_value;
    end
    
    % ЗНАЧЕНИЕ ФУНКЦИИ НА ПРЕДЫДУЩЕМ ШАГЕ
    y_value = Y_ARRAY(current_step_index - 1);
        
    % ВЫЧИСЛЯЕМ РЕЗУЛЬТАТ
    result = y_value + STEP * sum_for_step;    
end


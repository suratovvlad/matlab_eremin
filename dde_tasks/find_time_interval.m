function left_index = find_time_interval( time, T_ARRAY, current_step_index )
    % time                  - ЗНАЧЕНИЕ ВРЕМЕНИ, КОТОРЫЙ ОПРЕДЕЛЯЕТ ИСКОМЫЙ 
    %                         ИНТЕРВАЛ ВРЕМЕНИ
    % T_ARRAY               - ВЕКТОР ЗНАЧЕНИЙ ВРЕМЕНИ НА КАЖДОМ ШАГЕ
    % current_step_index    - ИНДЕКС ТЕКУЩЕГО ШАГА

    % ПРОБЕГАЕМСЯ ПО ВСЕМ ПРЕДШЕДСТВУЮЩИМ ШАГАМ
    for step_index = 2 : current_step_index
        
        % ЗАПОМИНАЕМ ЛЕВЫЙ ИНДЕКС ИСКОМОГО ИНТЕРВАЛА ВРЕМЕНИ
        left_index = step_index - 1;
        
        % ПРОВЕРКА, ПОПАЛИ МЫ В СЛЕДУЮЩИЙ ИНТЕРВАЛ ИЛИ НЕТ
        if T_ARRAY(step_index) > time
            % ЕСЛИ В СЛЕДУЮЩИЙ ИНТЕРВАЛ НЕ ПОПАЛИ, ТО НАШЛИ ИСКОМЫЙ
            % ИНТЕРВАЛ ВРЕМЕНИ - ТЕКУЩИЙ
            break;
        end
    end
    
end


function result = etta_func( t, y, T_ARRAY, stage_count, current_step_index, STEP, K_MATRIX, Y_ARRAY, B_VECTOR_FUN, HISTORY_FUN, DELAY_TIME_FUN )
    % t             - рейсыее гмювемхе бпелемх мю дюммнл ьюце х дюммнл щрюое 
    % y             - рейсыее гмювемхе тсмйжхх мю дюммнл ьюце х дюммнл щрюое 
    % T_ARRAY       - бейрнп гмювемхи бпелемх мю йюфднл ьюце
    % stage_count   - йнкхвеярбн щрюонб лерндю
    % current_step_index 	- хмдейя рейсыецн ьюцю
    % STEP          - ьюц лерндю
    % K_MATRIX      - люрпхжю йнщттхжхемрнб. 
    %                 пюглепмнярэ: [йнкхвеярбн ьюцнб x йнкхвеярбн щрюонб]
    % Y_ARRAY       - бейрнп гмювемхи тсмйжхх мю йюфднл ьюце
    % B_VECTOR_FUN  - бейрнп йнщттхжхемрнб b лерндю
    % HISTORY_FUN   - тсмйжхъ хярнпхх
    % DELAY_TIME_FUN    - тсмйжхъ гюоюгдшбюмхъ
    
    
    % бшвхякъел гюоюгдшбюмхе
    delayed_t = DELAY_TIME_FUN(t, y);
    
    % бпелъ, цде гюйюмвхбюеряъ хярнпхъ
    time0 = T_ARRAY(1);
    
    if delayed_t <= time0
        result = HISTORY_FUN(delayed_t);
    else
        % мюундхл хмрпебюк, йсдю оноюдюер гюоюгдшбюмхе    
        step_index = find_time_interval(delayed_t, T_ARRAY, current_step_index);
        
        % гмювемхе мю кебни цпюмхже хмрепбюкю
        t_left = T_ARRAY(step_index); 
        
        % гмювемхе мю опюбни цпюмхже хмрепбюкю
        t_right = T_ARRAY(step_index + 1);

        % бшвхякъел рерс
        theta = (delayed_t - t_left) / (t_right - t_left);
        
        % бшвхякъел гмювемхе нр щрни рерш
        delayed_value = delaying_func(theta, step_index + 1, STEP, stage_count, K_MATRIX, Y_ARRAY, B_VECTOR_FUN);
        
        % гюохяшбюел пегскэрюр
        result = delayed_value;
    end

end


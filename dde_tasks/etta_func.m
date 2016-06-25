function result = etta_func( t, y, T_ARRAY, stage_count, current_step_index, STEP, K_MATRIX, Y_ARRAY, DY_ARRAY, ...
    B_VECTOR_FUN, HISTORY_FUN, DELAY_TIME_FUN, INTERPOLANT_FUN )
    % t             - рейсыее гмювемхе бпелемх мю дюммнл ьюце х дюммнл щрюое 
    % y             - рейсыее гмювемхе тсмйжхх мю дюммнл ьюце х дюммнл щрюое 
    % T_ARRAY       - бейрнп гмювемхи бпелемх мю йюфднл ьюце
    % stage_count   - йнкхвеярбн щрюонб лерндю
    % current_step_index 	- хмдейя рейсыецн ьюцю
    % STEP          - ьюц лерндю
    % K_MATRIX      - люрпхжю йнщттхжхемрнб. 
    %                 пюглепмнярэ: [йнкхвеярбн ьюцнб x йнкхвеярбн щрюонб]
    % Y_ARRAY       - бейрнп гмювемхи тсмйжхх мю йюфднл ьюце
    % DY_ARRAY      - бейрнп гмювемхи опнхгбндмни мю йюфднл ьюце
    % B_VECTOR_FUN  - бейрнп йнщттхжхемрнб b лерндю
    % HISTORY_FUN   - тсмйжхъ хярнпхх
    % DELAY_TIME_FUN    - тсмйжхъ гюоюгдшбюмхъ
    % INTERPOLANT_FUN   - тсмйжхъ хмрепонкхпнбюмхъ
    
    % бшвхякъел гюоюгдшбюмхе
    delayed_t = DELAY_TIME_FUN(t, y);
    
    % бпелъ, цде гюйюмвхбюеряъ хярнпхъ
    time0 = T_ARRAY(1);
    
    if delayed_t <= time0
        result = HISTORY_FUN(delayed_t);
    else
        
        
        % бшвхякъел гмювемхе нр щрни рерш
        delayed_value = INTERPOLANT_FUN(delayed_t, current_step_index, STEP, stage_count, ...
            K_MATRIX, Y_ARRAY, DY_ARRAY, B_VECTOR_FUN, T_ARRAY );
        
        % гюохяшбюел пегскэрюр
        result = delayed_value;
    end

end


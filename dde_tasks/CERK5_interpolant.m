function result = CERK5_interpolant( delayed_t, current_step_index, STEP, stage_count, ...
    K_MATRIX, Y_ARRAY, DY_ARRAY, B_VECTOR_FUN, T_ARRAY )
    % delayed_t             - оюпюлерп бпелемх, б йнрнпнл бшвхякъел
    %                         хмрепонкхпнбюммне гмювемхе тсмйжхх
    % current_step_index 	- хмдейя рейсыецн ьюцю                
    % STEP                  - ьюц лерндю
    % stage_count   - йнкхвеярбн щрюонб лерндю
    % K_MATRIX      - люрпхжю йнщттхжхемрнб. 
    %                 пюглепмнярэ: [йнкхвеярбн ьюцнб x йнкхвеярбн щрюонб]
    % Y_ARRAY       - бейрнп гмювемхи тсмйжхх мю йюфднл ьюце
    % DY_ARRAY      - бейрнп гмювемхи опнхгбндмни мю йюфднл ьюце
    % B_VECTOR_FUN  - бейрнп йнщттхжхемрнб b лерндю
    % T_ARRAY       - бейрнп гмювемхи бпелемх мю йюфднл ьюце
    
    
    % мюундхл хмрпебюк, йсдю оноюдюер гюоюгдшбюмхе    
    step_index = find_time_interval(delayed_t, T_ARRAY, current_step_index);

    % гмювемхе мю кебни цпюмхже хмрепбюкю
    t_left = T_ARRAY(step_index); 

    % гмювемхе мю опюбни цпюмхже хмрепбюкю
    t_right = T_ARRAY(step_index + 1);

    % бшвхякъел рерс
    theta = (delayed_t - t_left) / (t_right - t_left);
        
    
    result = get_new_y_value(theta, step_index + 1, STEP, stage_count, K_MATRIX, Y_ARRAY, B_VECTOR_FUN);
end


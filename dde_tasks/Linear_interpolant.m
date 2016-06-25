function result = Linear_interpolant( theta, current_step_index, STEP, stage_count, ...
    K_MATRIX, Y_ARRAY, DY_ARRAY, B_VECTOR_FUN, T_ARRAY )
    % theta                 - оюпюлерп бпелемх, б йнрнпнл бшвхякъел
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
    step_index = find_time_interval(theta, T_ARRAY, current_step_index);
    
    % гмювемхе бпелемх мю опедшдсыел ьюце
    time_left = T_ARRAY(step_index);
    
    % гмювемхе бпелемх мю рейсыел ьюце
    time_right = T_ARRAY(step_index + 1);
    
    % гмювемхе тсмйжхх мю опедшдсыел ьюце
    y_value_left = Y_ARRAY(step_index);
    
    % гмювемхе тсмйжхх мю рейсыел ьюце
    y_value_right = Y_ARRAY(step_index + 1);
    
    x = [time_left, time_right];
    f = [y_value_left, y_value_right];
    
    % кхмеимюъ хмрепонкъжхъ
    final = interp1(x, f, theta);
         
    % бнгбпюыюелне гмювемхе
    result = final;    
    
end
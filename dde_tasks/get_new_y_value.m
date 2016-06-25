function result = get_new_y_value( theta, current_step_index, STEP, stage_count, K_MATRIX, Y_ARRAY, B_VECTOR_FUN )
    % theta                 - оюпюлерп бпелемх, б йнрнпнл бшвхякъел
    %                         хмрепонкхпнбюммне гмювемхе тсмйжхх
    % current_step_index 	- хмдейя рейсыецн ьюцю                
    % STEP                  - ьюц лерндю
    % stage_count   - йнкхвеярбн щрюонб лерндю
    % K_MATRIX      - люрпхжю йнщттхжхемрнб. 
    %                 пюглепмнярэ: [йнкхвеярбн ьюцнб x йнкхвеярбн щрюонб]
    % Y_ARRAY       - бейрнп гмювемхи тсмйжхх мю йюфднл ьюце
    % B_VECTOR_FUN  - бейрнп йнщттхжхемрнб b лерндю
    
    % ясллю, мю йнрнпсч сбекхвхбюел гмювемхе тсмйжхх    
    sum_for_step = 0;
    for stage_index = 1:stage_count % мнлеп щрюою
        
        % гмювемхе хг тсмйжхи-йнщттхжхемрнб b дкъ рейсыецн лерндю
        b_value = B_VECTOR_FUN(theta, stage_index);
        
        % менаундхлне гмювемхе йнщттхжхемрю k
        k_value = K_MATRIX(current_step_index, stage_index);
        
        % сбекхвхбюел ясллс
        sum_for_step = sum_for_step + b_value * k_value;
    end
    
    % гмювемхе тсмйжхх мю опедшдсыел ьюце
    y_value = Y_ARRAY(current_step_index - 1);
        
    % бшвхякъел пегскэрюр
    result = y_value + STEP * sum_for_step;    

end


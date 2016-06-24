function left_index = find_time_interval( time, T_ARRAY, current_step_index )
    % time                  - гмювемхе бпелемх, йнрнпши нопедекъер хяйнлши 
    %                         хмрепбюк бпелемх
    % T_ARRAY               - бейрнп гмювемхи бпелемх мю йюфднл ьюце
    % current_step_index    - хмдейя рейсыецн ьюцю

    % опнаецюеляъ он бяел опедьедярбсчыхл ьюцюл
    for step_index = 2 : current_step_index
        
        % гюонлхмюел кебши хмдейя хяйнлнцн хмрепбюкю бпелемх
        left_index = step_index - 1;
        
        % опнбепйю, оноюкх лш б якедсчыхи хмрепбюк хкх мер
        if T_ARRAY(step_index) > time
            % еякх б якедсчыхи хмрепбюк ме оноюкх, рн мюькх хяйнлши
            % хмрепбюк бпелемх - рейсыхи
            break;
        end
    end
    
end


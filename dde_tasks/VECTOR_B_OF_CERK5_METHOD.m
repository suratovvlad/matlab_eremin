function answer =  VECTOR_B_OF_CERK5_METHOD( theta, stage )
    % theta     - оюпюлерп бпелемх, б йнрнпнл бшвхякъел хмрепонкхпнбюммне
    %             гмювемхе бейрнпю лерндю CERK оърнцн онпъдйю
    % stage     - рейсыхи щрюо лерндю
    
    % бейрнп йнщттхжхернб c лерндю CERK оърнцн онпъдйю
    % гмювемхе йюфднцн щкелемрю БЕЙРНПЮ гюбхяхр нр theta
    switch stage
        case 1
            answer = 596/315 * theta^5 - 4969/819 * theta^4 + 17893/2457 * theta^3 - 3292/819 * theta^2 + theta;
        case 2
            answer = 0;
        case 3
            answer = -1984/275 * theta^5 + 1344/65 * theta^4 - 43568/2145 * theta^3 + 5112/715 * theta^2;
        case 4
            answer = 118/15 * theta^5 - 1465/78 * theta^4 + 3161/234 * theta^3 - 123/52 * theta^2;
        case 5
            answer = 2 * theta^5 - 413/78 * theta^4 + 1061/234 * theta^3 - 63/52 * theta^2;
        case 6
            answer = -9604/6435 * theta^5 + 2401/1521 * theta^4 + 60025/50193 * theta^3 - 40817/33462 * theta^2;
        case 7
            answer = -48128/6825 * theta^5 + 96256/5915 * theta^4 - 637696/53235 * theta^3 + 18048/5915 * theta^2;
        case 8
            answer = 4 * theta^5 - 109/13 * theta^4 + 75/13 * theta^3 - 18/13 * theta^2;
        otherwise
            answer = 0;
    end
    
end


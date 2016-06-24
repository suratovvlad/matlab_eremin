function [ T_ARRAY, Y_ARRAY, K_MATRIX, GLOBAL_ERROR ] = dde_solver( a_matrix, b_vector, c_vector, order, stage_count, ...
 DDE_FUN, HISTORY_FUN, DELAY_TIME_FUN, ANALYTICAL_SOLUTION, time_start, time_end, steps_k, step_count, STEP )
% a_matrix  -   люрпхжю йнщттхжхемрнб a лерндю
% b_vector  -   бейрнп йнщттхжхемрнб b лерндю
% c_vector  -   бейрнп йнщттхжхемрнб c лерндю
% order     -   онпъднй лерндю
% stage_count   -   йнкхвеярбн щрюонб б лернде
% DDE_FUN       -   дхттепемжхюкэмне спюбмемхе я гюоюгдшбючыхл юпцслемрнл
% HISTORY_FUN   -   тсмйжхъ хярнпхх
% DELAY_TIME_FUN    -   тсмйжхъ гюоюгдшбюмхъ
% ANALYTICAL_SOLUTION   -   юмюкхрхвеяйне пеьемхе
% time_start    -   мювюкн хяякедселнцн хмрепбюкю
% time_end      -   йнмеж хяякедселнцн хмрепбюкю
% steps_k       -   лмнфхрекэ дкъ ьюцнб
% step_count    -	йнкхвеярбн ьюцнб
% STEP          -   дкхмю ьюцю

% T_ARRAY   -   бейрнп гмювемхи бпелемх мю йюфднл ьюце
% Y_ARRAY   -   бейрнп гмювемхи хяйнлни тсмйжхх мю йюфднл ьюце

% бейрнп гмювемхи бпелемх мю йюфднл ьюце
T_ARRAY = zeros(step_count + 1, 1);
% бейрнп гмювемхи хяйнлни тсмйжхх мю йюфднл ьюце
Y_ARRAY = zeros(step_count + 1, 1);
% люрпхжю йнщттхжхемрнб дкъ йюфднцн щрюою мю йюфднл ьюце
K_MATRIX = zeros(step_count + 1, stage_count);
% люрпхжю цкнаюкэмшу онцпеьмняреи
GLOBAL_ERROR_MATRIX = [];

% мювюкэмше гмювемхъ бпелемх х тсмйжхх б щрнл бпелемх
T_ARRAY(1) = time_start;
Y_ARRAY(1) = HISTORY_FUN(time_start);

step_index = 2;     % мнлеп ьюцю
time_current = time_start;  % рейсыее бпелъ

while time_current < time_end
    
    % гюонлхмюел гмювемхе тсмйжхх мю опнькнл ьюце
    y_value = Y_ARRAY(step_index - 1);
    
    for stage_index = 1:stage_count % мнлеп щрюою
        
        % гмювемхе йнщттхжхемрнб c хг бейрнпю дкъ рейсыецн лерндю
        c_value = c_vector(stage_index);
        
        % бшвхякъел мнбне бпелъ дкъ щрюою
        new_time_for_stage = time_current + c_value * STEP;       
        
        % ясллю, мю йнрнпсч сбекхвхбюел гмювемхе тсмйжхх  
        sum_for_stage = 0;
        for prev_stage = 1: (stage_index - 1) % опнаецюел он бяел опедшдсыел щрюоюл щрнцн ьюцю
            
            % гмювемхе йнщттхжхемрнб a хг люрпхжш дкъ рейсыецн лерндю
            a_value = a_matrix(stage_index, prev_stage);
            
            % менаундхлне гмювемхе йнщттхжхемрю k
            k_value =  K_MATRIX(step_index, prev_stage);
            
            % сбекхвхбюел ясллс
            sum_for_stage = sum_for_stage + a_value * k_value;
        end
        
        % бшвхякъел мнбне гмювемхе тсмйжхх дкъ щрюою
        new_y_for_stage = y_value + STEP * sum_for_stage;

        % бшвхякъел щррю-тсмйжхч он бшвхякеммшл гмювемхъл дн щрнцн щрюою
        etta_for_stage = etta_func(new_time_for_stage, new_y_for_stage, T_ARRAY, stage_count, step_index, STEP, K_MATRIX, Y_ARRAY, b_vector, HISTORY_FUN, DELAY_TIME_FUN);
        
        % бшвхякъел мнбши йнщттхжхемр мю щрнл щрюое
        new_k_stage = DDE_FUN(new_time_for_stage, new_y_for_stage, etta_for_stage);
        K_MATRIX(step_index, stage_index) = new_k_stage;
    end

    % бшвхякъел гмювемхе тсмйжхх мю дюммнл ьюце
    new_y = delaying_func(1, step_index, STEP, stage_count, K_MATRIX, Y_ARRAY, b_vector);
    Y_ARRAY(step_index) = new_y;
    
    % сбекхвхбюел бпелъ мю дкхмс ьюцю
    time_current = time_current + STEP;
    T_ARRAY(step_index) = time_current;
    
    time_left = T_ARRAY(step_index - 1);
    time_right = T_ARRAY(step_index);    
    
    timer_step = (time_right - time_left) / 100;
    timer = time_left;
    while timer < time_right
        
        numerical_answer = delaying_func(timer, step_index, STEP, stage_count, K_MATRIX, Y_ARRAY, b_vector);
        analitycal_answer = ANALYTICAL_SOLUTION(timer);
        
        global_error = abs(numerical_answer - analitycal_answer);
        
        GLOBAL_ERROR_MATRIX = [GLOBAL_ERROR_MATRIX; global_error];
        
        timer = timer + timer_step;
    end
    
    % сбекхвхбюел рейсыхи явервхй ьюцю
    step_index = step_index + 1;
end

GLOBAL_ERROR = max(GLOBAL_ERROR_MATRIX);

figure;

hold on;
% plot(T_ARRAY, Y_ARRAY, '+');
% hold on;

x = time_start:0.01:time_end;
y = ANALYTICAL_SOLUTION(x);


plot(T_ARRAY, Y_ARRAY, x, y);

title(['Graph of Numerical and Analitycal Solutions with step = '  num2str(STEP)]);
xlabel('time') % x-axis label
ylabel('function values') % y-axis label
legend('y = Numerical','y = Analitycal','Location','southwest');
end


function task_1_common( DDE_FUN, HISTORY_FUN, DELAY_TIME_FUN, ANALYTICAL_SOLUTION, time_start, time_end )
% DDE_FUN       -   ƒ»‘‘≈–≈Õ÷»¿À‹ÕŒ≈ ”–¿¬Õ≈Õ»≈ — «¿œ¿«ƒ€¬¿ﬁŸ»Ã ¿–√”Ã≈Õ“ŒÃ
% HISTORY_FUN   -   ‘”Õ ÷»ﬂ »—“Œ–»»
% DELAY_TIME_FUN    -   ‘”Õ ÷»ﬂ «¿œ¿«ƒ€¬¿Õ»ﬂ
% ANALYTICAL_SOLUTION   -   ¿Õ¿À»“»◊≈— Œ≈ –≈ÿ≈Õ»≈
% time_start    -   Õ¿◊¿ÀŒ »——À≈ƒ”≈ÃŒ√Œ »Õ“≈–¬¿À¿
% time_end      -    ŒÕ≈÷ »——À≈ƒ”≈ÃŒ√Œ »Õ“≈–¬¿À¿

order = 5;          % œŒ–ﬂƒŒ  Ã≈“Œƒ¿
stage_count = 8;    %  ŒÀ»◊≈—“¬Œ ›“¿œŒ¬ ¬ Ã≈“Œƒ≈

% Ã¿“–»÷¿  Œ›‘‘»÷»≈Õ“Œ¬ a Ã≈“Œƒ¿
a_matrix = @MATRIX_A_OF_CERK5_METHOD;
% ¬≈ “Œ–  Œ›‘‘»÷»≈Õ“Œ¬ b Ã≈“Œƒ¿
b_vector = @VECTOR_B_OF_CERK5_METHOD;
% ¬≈ “Œ–  Œ›‘‘»÷»≈Õ“Œ¬ c Ã≈“Œƒ¿
c_vector = @VECTOR_C_OF_CERK5_METHOD;


errors_plot_x = [];
errors_plot_y = [];
errors_plot_x2 = [];
errors_plot_y2 = [];

last_error = 0;
for steps_k = 2:8 % ÃÕŒ∆»“≈À‹ ƒÀﬂ ÿ¿√Œ¬
    
    %  ŒÀ»◊≈—“¬Œ ÿ¿√Œ¬
    step_count = 2^steps_k;    
    % ƒÀ»Õ¿ ÿ¿√¿
    STEP = (time_end - time_start) / step_count; 
    
    % –≈ÿ¿≈Ã ”–¿¬Õ≈Õ»≈
    [ T_ARRAY, Y_ARRAY, K_MATRIX, GLOBAL_ERROR ] = dde_solver(a_matrix, b_vector, c_vector, order, stage_count, ...
        DDE_FUN, HISTORY_FUN, DELAY_TIME_FUN, ANALYTICAL_SOLUTION, time_start, time_end, steps_k, step_count, STEP);
    
    % ‘Œ–Ã»–”≈Ã Ã¿——»¬€ ƒÀﬂ √–¿‘» Œ¬
    errors_plot_x = [errors_plot_x, log10(STEP)];
    errors_plot_y = [errors_plot_y, log10(GLOBAL_ERROR)];
    
    errors_plot_x2 = [errors_plot_x2, log2(STEP)];
    if last_error > 0
        errors_plot_y2 = [errors_plot_y2, log2(GLOBAL_ERROR / last_error)];
    end
    % «¿œŒÃ»Õ¿≈Ã Œÿ»¡ ”
    last_error = GLOBAL_ERROR;
end


figure;
loglog( (errors_plot_x2(1: (length(errors_plot_x2) - 1) )), errors_plot_y2);
title('log2(h_k) to log2(err_{k+1} / err_k)');
xlabel('log2(h_k)') % x-axis label
ylabel('log2(err_{k+1} / err_k)') % y-axis label

figure;
loglog(errors_plot_x, errors_plot_y);
title('log10(h_k) to log10(err_k)');
xlabel('log10(h_k)') % x-axis label
ylabel('log10(err_k)') % y-axis label

end


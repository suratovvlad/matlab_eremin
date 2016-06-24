function result = VECTOR_C_OF_CERK5_METHOD( index )
% index     - ИНДЕКС ТРЕБУЕМОГО ЭЛЕМЕНТА

% ВЕКТОР КОЭФФИЦИЕТОВ c МЕТОДА CERK ПЯТОГО ПОРЯДКА
c_vector = [0 1/6 1/4 1/2 1/2 9/14 7/8 1];

% ЗАПИСЫВАЕМ ЗНАЧЕНИЕ
result = c_vector(index);
end


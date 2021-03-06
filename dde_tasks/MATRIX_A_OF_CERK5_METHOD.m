function result = MATRIX_A_OF_CERK5_METHOD( index_row, index_column )
% index_row 	- ИНДЕКС СТРОКИ ТРЕБУЕМОГО ЭЛЕМЕНТА
% index_column  - ИНДЕКС СТОЛБЦА ТРЕБУЕМОГО ЭЛЕМЕНТА

% МАТРИЦА КОЭФФИЦИЕТОВ a МЕТОДА CERK ПЯТОГО ПОРЯДКА
a_matrix = [0           0           0           0               0               0               0           0;
            1/6         0           0           0               0               0               0           0;
            1/16        3/16        0           0               0               0               0           0;
            1/4         -3/4        1           0               0               0               0           0;
            -3/4        15/4        -3          1/2             0               0               0           0;
            369/1372    -243/343    297/343     1485/9604       297/4802        0               0           0;
            -133/4512   1113/6016   7945/16544  -12845/24064    -315/24064      156065/198528   0           0;
            83/945      0           248/825     41/180          1/36            2401/38610      6016/20475  0];

% ЗАПИСЫВАЕМ ЗНАЧЕНИЕ
result = a_matrix(index_row, index_column);

end


function [ Dy ] = JACB( t, vector_y )
Dy(1) =  vector_y(2) * vector_y(3);
Dy(2) = -vector_y(1) * vector_y(3);
Dy(3) = -0.51 * vector_y(1) * vector_y(2);
Dy=Dy';
end


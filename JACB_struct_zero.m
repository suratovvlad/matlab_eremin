function [ Dy ] = JACB_struct_zero( t, vector_y )

Dy =  vector_y(2) * vector_y(3);
%Dy(2) = -vector_y(1) * vector_y(3);
%Dy(3) = -0.51 * vector_y(1) * vector_y(2);
%Dy=Dy';

vector_calc = getGlobalCountCalc;
setGlobalCountCalc([vector_calc(1) + 1; vector_calc(2); vector_calc(3)]);
end


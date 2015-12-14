function [ Dy ] = JACB_struct_one( t, vector_y )

%Dy(1) =  vector_y(2) * vector_y(3);
Dy = -vector_y(1) * vector_y(3);
%Dy(3) = -0.51 * vector_y(1) * vector_y(2);
%Dy=Dy';

vector_calc = getGlobalCountCalc;
setGlobalCountCalc([vector_calc(1); vector_calc(2) + 1; vector_calc(3)]);

end


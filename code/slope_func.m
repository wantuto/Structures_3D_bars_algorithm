function [slope] = slope_func(Ixx,Iyy,Ixy,Mx,My)
%calculation of the orientation of the neutral axis
% y_na = slope * x_na

slope = (My*Ixx+Ixy*Mx)/(Mx*Iyy + My*Ixy);

end

 
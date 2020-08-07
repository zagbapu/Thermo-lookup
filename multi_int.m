function [ output ] = multi_int(x,y,inmatrix)
%MULTI_INT Interpolating using two independent variables
%   Using a bilinear interpolation

%saving pressure and temperature in one matrix, and the properties in a
%different matrix
variable = [ones(4,1),inmatrix(:,[1,2]),inmatrix(:,1).*inmatrix(:,2)];
functions = inmatrix(:,3:6);

%Solving the linear equation to find the necessary coefficients
coeff = (variable\functions).';

%Creating a vector with the input pressure and temperature
xymatrix=[1;x;y;x*y];

%Saving the results into a single ourput vector
output = [x,y];
output(3) = coeff(1,:)*xymatrix;
output(4) = coeff(2,:)*xymatrix;
output(5) = coeff(3,:)*xymatrix;
output(6) = coeff(4,:)*xymatrix;

end


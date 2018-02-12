function [ X_extend ] = extendx( X )
%input attribute, output extension
degree2_X = X.^2;
X_extend = horzcat(X,degree2_X);
end


function [ Y_hat ] = LR_predict ( X_test, W )
%imput the optimized W and X test, output predicted value

m = length(X_test);             % number of points
X = [ones(m,1), X_test];
Y_hat = X * W;

end


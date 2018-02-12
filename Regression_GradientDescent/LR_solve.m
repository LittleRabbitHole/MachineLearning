function [ W ] = LR_solve( X_train,  Y_train)
%LR_solve input features 
% X as [#obs by #features] matric
% Y as column vector

m = length(X_train);             % number of points
X = [ones(m,1), X_train];
%use the estimation fomular
W = (X' * X) \ (X' * Y_train);

end


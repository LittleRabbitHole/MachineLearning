function [ y_hat, y_score ] = apply_svlm( x, w, b )
%this function take the new input data x
% w, b is trained from svml
% output the predicted class

y_hat = x*w +b > 0;
y_score = x*w +b;

end


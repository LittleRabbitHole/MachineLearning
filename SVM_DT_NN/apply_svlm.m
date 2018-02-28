function [ y_hat ] = apply_svlm( x, w, b )
%this function take the new input data x
% w, b is trained from svml
% output the predicted class

y_hat = x*w +b > 0;
y_sore = x*w +b;

end


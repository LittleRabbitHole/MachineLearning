function [data_train, data_test] = divideset2( data, p_train )
%this function directly choose from data a sample 
%the sample size is based on the p_train 
length_data = size(data,1);
choose_N = floor( length_data*p_train );
selection_ID = randsample(length_data, choose_N);
%seperating
data_train = data(selection_ID,:);
data_test = data;
data_test(selection_ID,:) = [];
end


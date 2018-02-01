function [ newdata ] = subsample( data, k)
%sample k rows from data as newdata
length_data = size(data,1);
selection_ID = randsample(length_data, k);
newdata = data(selection_ID,:);
end


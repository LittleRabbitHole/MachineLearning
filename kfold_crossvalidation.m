function [ train, test ] = kfold_crossvalidation( data, k,m )
%UNTITLED4 Summary of this function goes here
%   randomize the data
n = size(data, 1);
rand_ind = randperm(n);
%create fold labels
fold_label = zeros(n,1);
fold_id = 1; % this will be number of folds
for i = 1:n
    fold_label(rand_ind(i)) = fold_id;
    fold_id = fold_id + 1;
     % make sure folds = k
    if ( fold_id > k )
       fold_id = 1;
    end
end
test_ind = find(fold_label==m);
train_ind = find(fold_label~=m);
test = data(test_ind);
train = data(train_ind);
end


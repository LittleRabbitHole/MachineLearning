load housing_train.txt;
load housing_test.txt;

data_train = housing_train;
data_test = housing_test;

%% prepare the train data
% normalization on training data
[train_mean_norm train_std_norm]=compute_norm_parameters(data_train);
[data_train_norm]=normalize(data_train, train_mean_norm, train_std_norm);

% normalization on testing data
[test_mean_norm test_std_norm]=compute_norm_parameters(data_test);
[data_test_norm]=normalize(data_test,test_mean_norm,test_std_norm);

%% online gradient descent on normalized data
m_train = size(data_train_norm, 2);
W = zeros(1, size(data_train_norm, 2));
for step = 0:999
    %step=0;
    ind_data = mod(step, size(data_train_norm, 1))+1;
    newdata = data_train_norm(ind_data,:);
    X_newdata = [1, newdata(:,1:(m_train-1))];
    Y_newdata = newdata(:,m_train);
    %learning rate
    alpha = 2/(step+1);
    %gradient
    dw = (Y_newdata - W*X_newdata.')*X_newdata;
    %update
    W = W + alpha*dw;
end

%% training error
m_train = size(data_train_norm, 2);
X_train = data_train_norm(:,1:(m_train-1));
Y_train = data_train_norm(:,m_train);

%error on training
m = length( X_train);             % number of points
X = [ones(m,1),  X_train];
Y_train_hat = X * W.';
MSR_train = mean((Y_train - Y_train_hat).^2)

%% prepare the test data
m_test = size(data_test_norm, 2);
X_test = data_test_norm(:,1:(m_test-1));
Y_test = data_test_norm(:,m_test);

%error on training
m = length( X_test);             % number of points
X = [ones(m,1),  X_test];
Y_test_hat = X * W.';
MSR_test = mean((Y_test - Y_test_hat).^2)

%% online gradient descent on original data can not find result
W = zeros(1, size(data_train, 2));
for step = 0:72
    %step=0;
    ind_data = mod(step, size(data_train, 1))+1;
    newdata = data_train(ind_data,:);
    X_newdata = [1, newdata(:,1:(m_train-1))];
    Y_newdata = newdata(:,m_train);
    %learning rate
    alpha = 2/(step+1);
    %gradient
    dw = (Y_newdata - W*X_newdata.')*X_newdata
    %update
    W = W + alpha*dw
end


load housing_train.txt;
load housing_test.txt;

data_train = housing_train;
data_test = housing_test;

%% turn into polynomial type data
data_trainX_extend = extendx( data_train(:,1:13) );
% remove the binary squared column
data_trainX_extend = horzcat(data_trainX_extend(:,1:17-1),data_trainX_extend(:,18:26)); 
data_train_extend = horzcat(data_trainX_extend, data_train(:,14));

data_testX_extend = extendx( data_test(:,1:13) );
% remove the binary squared column
data_testX_extend = horzcat(data_testX_extend(:,1:17-1),data_testX_extend(:,18:26)); 
data_test_extend = horzcat(data_testX_extend, data_test(:,14));

%% prepare the train data
% normalization on training data
[train_extend_mean_norm train_extend_std_norm]=compute_norm_parameters(data_train_extend);
[data_train_extend_norm]=normalize(data_train_extend, train_extend_mean_norm, train_extend_std_norm);

% normalization on testing data
[test_extend_mean_norm test_extend_std_norm]=compute_norm_parameters(data_test_extend);
[data_test_extend_norm]=normalize(data_test_extend,test_extend_mean_norm,test_extend_std_norm);

%% training
m_train = size(data_train_extend_norm, 2);
X_train = data_train_extend_norm(:,1:(m_train-1));
Y_train = data_train_extend_norm(:,m_train);


%% optimization of parameters based on train
W = LR_solve( X_train,  Y_train);

%% error on training
m = length( X_train);             % number of points
X = [ones(m,1),  X_train];
Y_train_hat = X * W;
MSR_train = mean((Y_train - Y_train_hat).^2)

%% prepare the test data
m_test = size(data_test_extend_norm, 2);
X_test = data_test_extend_norm(:,1:(m_test-1));
Y_test = data_test_extend_norm(:,m_test);

%error on training
m = length( X_test);             % number of points
X = [ones(m,1),  X_test];
Y_test_hat = X * W;
MSR_test = mean((Y_test - Y_test_hat).^2)


%% online gradient descent on normalized data
m_train = size(data_train_extend_norm, 2);
W = zeros(1, size(data_train_extend_norm, 2));
for step = 0:1500
    %step=0;
    ind_data = mod(step, size(data_train_extend_norm, 1))+1;
    newdata = data_train_extend_norm(ind_data,:);
    X_newdata = [1, newdata(:,1:(m_train-1))];
    Y_newdata = newdata(:,m_train);
    %learning rate
    alpha = 0.01;
    %alpha = 2/(step+1);
    %gradient
    dw = (Y_newdata - W*X_newdata.')*X_newdata;
    %update
    W = W + alpha*dw;
end

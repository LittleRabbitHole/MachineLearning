% load the data
load housing_train.txt;
load housing_test.txt;

data_train = housing_train;
data_test = housing_test;

%prepare the train data
m_train = size(data_train, 2);
X_train = data_train(:,1:(m_train-1));
Y_train = data_train(:,m_train);
% optimization of parameters based on train
W = LR_solve( X_train,  Y_train)

%error on training
Y_train_hat = LR_predict ( X_train, W );
MSR_train = mean((Y_train - Y_train_hat).^2)

%prepare the test data
m_test = size(data_test, 2);
X_test = data_test(:,1:(m_test-1));
Y_test = data_test(:,m_test);

%error on testing
Y_test_hat = LR_predict ( X_test, W );
MSR_test = mean((Y_test - Y_test_hat).^2)




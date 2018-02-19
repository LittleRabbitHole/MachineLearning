load pima_train.txt;
load pima_test.txt;

data_train = pima_train;
data_test = pima_test;

%% prepare the train data
m_train = size(data_train, 2);
X_train = data_train(:,1:(m_train-1));
Y_train = data_train(:,m_train);

% normalization on training data
[train_mean_norm, train_std_norm]=compute_norm_parameters(X_train);
[pima_train_norm]=normalize(X_train, train_mean_norm, train_std_norm);
pima_train_norm = [pima_train_norm, Y_train];

dlmwrite('pima_train_norm.txt', pima_train_norm)

%% prepare the test data
m_test = size(data_test, 2);
X_test = data_test(:,1:(m_test-1));
Y_test = data_test(:,m_test);

% normalization on testing data
[test_mean_norm, test_std_norm]=compute_norm_parameters(X_test);
[pima_test_norm]=normalize(X_test,test_mean_norm,test_std_norm);
pima_test_norm = [pima_test_norm, Y_test];

dlmwrite('pima_test_norm.txt', pima_test_norm)

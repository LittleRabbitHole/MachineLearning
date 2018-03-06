%%%% load the train and test data (both are normalized)
load pima_train_norm.txt;
load pima_test_norm.txt;
tr_data = pima_train_norm;
test_data = pima_test_norm;

data_col= size(tr_data,2);
n_features = data_col - 1;

%%% create x
x = tr_data(:,1:n_features);
%% create y vector
y=tr_data(:,data_col);
 
%% builds x for the the test set
x_test = test_data(:,1:n_features);
%% builds y vector for the test set
y_test=test_data(:,data_col);

%% builds a neural network with two hidden units
%%% with a sigmoidal output function
%%% to be trained with the gradient method
net=patternnet([2]);
view(net)

%% sets the parameters of the NN model
% see the NN toolbox documentation help(net.trainFcn)
net.trainParam.epochs = 2000;
net.trainParam.show = 10;
net.trainParam.max_fail=50;
%%% use conjugate gradient to train the model
net.trainFcn='traincgf';
% net.trainFcn= 'trainscg';


%%% training of the neural net
[net, tr] = train(net,x',y') 

%% runs learned network on inputs in x (training set)
res=net(x');
%%% mean classification error on the training data
class_error_train=sum(abs(y-round(res)'))/size(res,2)
%%% 'Mean squared error (mse) on the training data'
mse_error_train = perform(net,y',res)


%% runs learned network on inputs in x (testing set)
res_test = net(x_test');
%%% mean classification error on the testing data
class_error_test=sum(abs(y_test-round(res_test)'))/size(res_test,2)
%%% 'Mean squared error (mse) on the testing data'
mse_error_test = perform(net,y_test',res_test)

%% weights
cell2mat(net.IW)
%%% bias
cell2mat(net.b)



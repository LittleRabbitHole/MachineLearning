%% load data
load pima_train.txt;
load pima_test.txt;

data_train = pima_train;
data_test = pima_test;

%% class posterior
p_y_1 = sum(data_train(:,9))/length(data_train(:,9));
p_y_0 = 1 - (sum(data_train(:,9))/length(data_train(:,9)));

%% for trainning set
Y_train_predict = [];
for i =1:length(data_train)
    x = data_train(i, :);
    y_hat = predict_NB(x);
    Y_train_predict = [Y_train_predict, y_hat];    
end

Y_train_class = data_train(:,9);
Y_train_predict = Y_train_predict';

%% training confusion matrix
conf_mat_train = confusionmat(Y_train_class,Y_train_predict,'order',[1,0]);

TP = conf_mat_train(1,1);
TN = conf_mat_train(2,2);
FN = conf_mat_train(2,1);
FP = conf_mat_train(1,2);
accuracy_train = (TP+TN)/sum(sum(conf_mat_train));
misclass_train = 1-accuracy_train

%% for testing set
Y_test_predict = [];
for i =1:length(data_test)
    x = data_train(i, :);
    y_hat = predict_NB(x);
    Y_test_predict = [Y_test_predict, y_hat];    
end
Y_test_class = data_test(:,9);
Y_test_predict = Y_test_predict';

%% testing confusion matrix
conf_mat_test = confusionmat(Y_test_class,Y_test_predict,'order',[1,0]);

TP = conf_mat_test(1,1);
TN = conf_mat_test(2,2);
FN = conf_mat_test(2,1);
FP = conf_mat_test(1,2);
accuracy_test = (TP+TN)/sum(sum(conf_mat_test));
misclass_test = 1-accuracy_test


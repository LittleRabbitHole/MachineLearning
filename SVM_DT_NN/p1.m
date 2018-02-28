%% input data
load pima_train.txt
load pima_test.txt

X_train = pima_train(:, 1:8);
y_train = pima_train(:, 9);
[w, b] = svml(X_train,Y_train,1);

X_test = pima_test(:, 1:8);
y_test = pima_test(:, 9);

%% Part c. for trainning set
Y_train_predict = [];
for i =1:length(X_train)
    x = X_train(i, :);
    y_hat = apply_svlm( x, w, b );
    Y_train_predict = [Y_train_predict, y_hat];
end

Y_train_class = y_train;
Y_train_predict = Y_train_predict';

%% training confusion matrix
conf_mat_train = confusionmat(Y_train_class,Y_train_predict,'order',[1,0])

TP = conf_mat_train(1,1);
TN = conf_mat_train(2,2);
FN = conf_mat_train(2,1);
FP = conf_mat_train(1,2);
accuracy_train = (TP+TN)/sum(sum(conf_mat_train));
misclass_train = 1-accuracy_train
sensit = TP/(TP+FN)
specif = TN/(TN+FP)

%% for testing set
Y_test_predict = [];
for i =1:length(X_test)
    x = X_train(i, :);
    y_hat = apply_svlm( x, w, b );
    Y_test_predict = [Y_test_predict, y_hat];  
end

Y_test_class = y_test;
Y_test_predict = Y_test_predict';

%% testing confusion matrix
conf_mat_test = confusionmat(Y_test_class,Y_test_predict,'order',[1,0]);

TP = conf_mat_test(1,1);
TN = conf_mat_test(2,2);
FN = conf_mat_test(2,1);
FP = conf_mat_test(1,2);
accuracy_test = (TP+TN)/sum(sum(conf_mat_test));
misclass_test = 1-accuracy_test
test_sensit = TP/(TP+FN)
test_specif = TN/(TN+FP)

%% ROC curve
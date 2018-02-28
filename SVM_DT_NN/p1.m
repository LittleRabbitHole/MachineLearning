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
Y_train_scores = [];

for i =1:length(X_train)
    x = X_train(i, :);
    [ y_hat, y_score ] = apply_svlm( x, w, b );
    Y_train_predict = [Y_train_predict, y_hat];
    Y_train_scores = [Y_train_scores, y_score];
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
Y_test_scores = [];

for i =1:length(X_test)
    x = X_train(i, :);
    [ y_hat, y_score ] = apply_svlm( x, w, b );
    Y_test_predict = [Y_test_predict, y_hat]; 
    Y_test_scores = [Y_test_scores, y_score];
end

Y_test_class = y_test;
Y_test_predict = Y_test_predict';

%% testing confusion matrix
conf_mat_test = confusionmat(Y_test_class,Y_test_predict,'order',[1,0])

TP = conf_mat_test(1,1);
TN = conf_mat_test(2,2);
FN = conf_mat_test(2,1);
FP = conf_mat_test(1,2);
accuracy_test = (TP+TN)/sum(sum(conf_mat_test));
misclass_test = 1-accuracy_test
test_sensit = TP/(TP+FN)
test_specif = TN/(TN+FP)

%% ROC curve
[svm_X_test,svm_Y_test,svm_T_test,svm_AUC_test] = perfcurve(Y_test,Y_test_scores,1);
svm_AUC_test

[svm_X_train,svm_Y_train,svm_T_train,svm_AUC_train] = perfcurve(Y_train,Y_train_scores,1);
svm_AUC_train


%% ROC curve for logistic regression
% score from main 1
[lg_X_test,lg_Y_test,lg_T_test,lg_AUC_test] = perfcurve(Y_test,lg_test_scores,1);
lg_AUC_test

[lg_X_train,lg_Y_train,lg_T_train,lg_AUC_train] = perfcurve(Y_train,lg_train_scores,1);
lg_AUC_train

%% NB 
[NB_X_test,NB_Y_test,NB_T_test,NB_AUC_test] = perfcurve(Y_test,NB_testscores,1);
NB_AUC_test

[NB_X_train,NB_Y_train,NB_T_train,NB_AUC_train] = perfcurve(Y_train,NB_trainscores,1);
NB_AUC_train

%% plot ROC for testing data set
plot(lg_X_train,lg_Y_train)
hold on
plot(NB_X_train,NB_Y_train)
hold on
plot(svm_X_train,svm_Y_train)
legend('Logistic Regression','Naive Bayes','SVM','Location','Best')
xlabel('False positive rate'); ylabel('True positive rate');
title('ROC Curves for training: Logistic Regression, Naive Bayes, and SVM Classification')
hold off

%% plot ROC for testing data set
plot(lg_X_test,lg_Y_test)
hold on
plot(NB_X_test,NB_Y_test)
hold on
plot(svm_X_test,svm_Y_test)
legend('Logistic Regression','Naive Bayes','SVM','Location','Best')
xlabel('False positive rate'); ylabel('True positive rate');
title('ROC Curves for testing: Logistic Regression, and Naive Bayes, and SVM Classification')
hold off
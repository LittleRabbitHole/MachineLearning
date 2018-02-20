%% prob3: ROC curve for logistic regression
% score from main 1
lg_test_scores = Y_test_hat;
lg_train_scores = Y_train_hat;

[lg_X_test,lg_Y_test,lg_T_test,lg_AUC_test] = perfcurve(Y_test,lg_test_scores,1);
lg_AUC_test

[lg_X_train,lg_Y_train,lg_T_train,lg_AUC_train] = perfcurve(Y_train,lg_train_scores,1);
lg_AUC_train

%% NB 
NB_trainscores = Y_train_nbscores;
NB_testscores = Y_test_nbscores;

[NB_X_test,NB_Y_test,NB_T_test,NB_AUC_test] = perfcurve(Y_test,NB_testscores,1);
NB_AUC_test

[NB_X_train,NB_Y_train,NB_T_train,NB_AUC_train] = perfcurve(Y_train,NB_trainscores,1);
NB_AUC_train

%% plot ROC for testing data set
plot(lg_X_train,lg_Y_train)
hold on
plot(NB_X_train,NB_Y_train)
legend('Logistic Regression','Naive Bayes','Location','Best')
xlabel('False positive rate'); ylabel('True positive rate');
title('ROC Curves for training: Logistic Regression, and Naive Bayes Classification')
hold off

%% plot ROC for testing data set
plot(lg_X_test,lg_Y_test)
hold on
plot(NB_X_test,NB_Y_test)
legend('Logistic Regression','Naive Bayes','Location','Best')
xlabel('False positive rate'); ylabel('True positive rate');
title('ROC Curves for testing: Logistic Regression, and Naive Bayes Classification')
hold off
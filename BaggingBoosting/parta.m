%% load data
load hw10_test.txt
load hw10_train.txt
tr_x = hw10_train(:, 1:65);
tr_y = hw10_train(:, 66);
test_x = hw10_test(:, 1:65);
test_y = hw10_test(:, 66);

%% base SVM model
[test_y_head]  = SVML_base(tr_x, tr_y, test_x);
[tr_y_head]  = SVML_base(tr_x, tr_y, tr_x);

%% errors on base model - training confusion matrix
conf_mat_train = confusionmat(tr_y,double(tr_y_head),'order',[1,0]);

TP = conf_mat_train(1,1);
TN = conf_mat_train(2,2);
FN = conf_mat_train(2,1);
FP = conf_mat_train(1,2);
accuracy_train = (TP+TN)/sum(sum(conf_mat_train));
misclass_train = 1-accuracy_train;

%% errors on base model - test confusion matrix
conf_mat_test = confusionmat(test_y,double(test_y_head),'order',[1,0]);

TP = conf_mat_test(1,1);
TN = conf_mat_test(2,2);
FN = conf_mat_test(2,1);
FP = conf_mat_test(1,2);
accuracy_test = (TP+TN)/sum(sum(conf_mat_test));
misclass_test = 1-accuracy_test;

%% bagging or boosting

train_error_T = [];
test_error_T = [];

for T = 1:10
    %for train 20 times and get the average error
    misclass_train_all = 0; misclass_test_all = 0;
    
    para = sprintf('[@SVML_base,%d,[]]',T);
    for i = 1:20
        %for bagging
        %[test_y_head] = Bag_classifier(tr_x,tr_y,test_x,para);
        %[tr_y_head] = Bag_classifier(tr_x,tr_y,tr_x,para);
        
        %for boosting
        [test_y_head] = Boost_classifier(tr_x,tr_y,test_x,para);
        [tr_y_head] = Boost_classifier(tr_x,tr_y,tr_x,para);
        
        %train
        conf_mat_train = confusionmat(tr_y,double(tr_y_head),'order',[1,0]);
        accuracy_train = (conf_mat_train(1,1)+conf_mat_train(2,2))/sum(sum(conf_mat_train));
        misclass_train = 1-accuracy_train;
        misclass_train_all = misclass_train_all + misclass_train;
        %test
        conf_mat_test = confusionmat(test_y,double(test_y_head),'order',[1,0]);
        accuracy_test = (conf_mat_test(1,1)+conf_mat_test(2,2))/sum(sum(conf_mat_test));
        misclass_test = 1-accuracy_test;
        misclass_test_all = misclass_test_all + misclass_test;
    end
    
    mean_train_error = misclass_train_all/20; 
    mean_test_error = misclass_test_all/20;
    
    %update the error on each T
    train_error_T = [train_error_T, mean_train_error];
    test_error_T = [test_error_T, mean_test_error];
end    

%% plot bagging/boosting error
plot(train_error_T)
hold on 
plot(test_error_T)
legend('train error','test error','Location','Best')
xlabel('T - Number of models'); ylabel('Error rate');
%title('Bagging errors')
title('Boosting errors')
hold off
load pima_train_norm.txt
load pima_test_norm.txt

m_train = size(pima_train_norm, 2);
X_train = pima_train_norm(:,1:(m_train-1));
Y_train = pima_train_norm(:,m_train);

m_test = size(pima_test_norm, 2);
X_test = pima_test_norm(:,1:(m_test-1));
Y_test = pima_test_norm(:,m_test);


%% iterative learning graph

col_ones1 = ones(size(X_train, 1), 1);
X_train = horzcat(col_ones1, X_train);           % add a column of ones on the left to X
W = ones(size(X_train, 2), 1);            % initialize W to 1 to start with 
%W = 0* ones(size(X_train, 2), 1);            % initialize W to 0 to start with 

col_ones2 = ones(size(X_test, 1), 1);
X_test = horzcat(col_ones2, X_test);           % add a column of ones on the left to X

pgraph = init_progress_graph

for k = 1:1:5000                       %%% number of steps
    sum_err = 0;                    %%% initialize batch error function gradient
    for row = 1:1:size(X_train, 1)
        x = X_train(row,:)';
        y = Y_train(row,:);
        f = 1/(1 + exp(-(W'*x)));
        err = (y - f) * x;          % error (on-line gradient)
        sum_err = sum_err + err;    % update batch error function gradient
    end
    %alpha = 0.5;
    alpha = 2/sqrt(k);
    W = W + (alpha * sum_err);
    
    % calculate training error
    Y_train_hat = 1./(1 + exp(-(W'*X_train'))); %element wise
    Y_trainclass_hat = [Y_train_hat>=0.5];
    conf_mat_train = confusionmat(Y_train,double(Y_trainclass_hat),'order',[1,0]);
    accuracy_train = (conf_mat_train(1,1)+conf_mat_train(2,2))/sum(sum(conf_mat_train));
    misclass_train = 1-accuracy_train;
    traine = misclass_train;
    
    % calculate testing error
    Y_test_hat = 1./(1 + exp(-(W'*X_test')));
    Y_testclass_hat = [Y_test_hat>=0.5];
    conf_mat_test = confusionmat(Y_test,double(Y_testclass_hat),'order',[1,0]);
    accuracy_test = (conf_mat_test(2,2)+conf_mat_test(1,1))/sum(sum(conf_mat_test));
    misclass_test = 1-accuracy_test;
    teste = misclass_test;
 
    % graph
    if mod(k, 100) == 0
        pgraph = add_to_progress_graph(pgraph, k, traine, teste)
    end
end

%%
misclass_train
misclass_test
%%
TP = conf_mat_test(1,1);
TN = conf_mat_test(2,2);
FN = conf_mat_test(2,1);
FP = conf_mat_test(1,2);
accuracy_test = (TP+TN)/sum(sum(conf_mat_test));
misclass_test = 1-accuracy_test
test_sensit = TP/(TP+FN)
test_specif = TN/(TN+FP)


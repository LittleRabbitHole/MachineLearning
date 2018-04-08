%%% BASE DT classifier with simplt tree
%%% learns on the training set, after learning applies the model to the
%%% test set
 
function [test_y]  = DT_base_simple(tr_x, tr_y, test_x, params)

%%%%%%%%%% Learning DT %%%%%%%%%%%%%%%

%% calls DT to learn the model

tree = fitctree(tr_x,tr_y, 'MaxNumSplits',1, 'splitcriterion','gdi','prune', 'off');
%%% now we apply the model to test data and make a decision
test_y=predict(tree, test_x);

return;

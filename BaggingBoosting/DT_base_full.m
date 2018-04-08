%%% BASE DT classifier
%%% learns on the training set, after learning applies the model to the
%%% test set
 
function [test_y]  = DT_base_full(tr_x, tr_y, test_x, params)

%%%%%%%%%% Learning DT %%%%%%%%%%%%%%%

%% calls DT to learn the model

tree = fitctree(tr_x,tr_y, 'splitcriterion','gdi', 'prune', 'off');
%%% now we apply the model to test data and make a decision
test_y=predict(tree, test_x);

return;

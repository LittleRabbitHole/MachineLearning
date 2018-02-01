function [data_train, data_test] = divideset1( data, p_train )
%function seperate dataset to training/testing data based on the p_train
%loop over each row
%decide whether to select the row based on the p_train
selection_ID = [];
for row=1:size(data,1)
    selected = randsample([0 1],1,true,[1-p_train p_train]);
    if selected == 1;
        selection_ID = [selection_ID, row];
    end
end
data_train = data(selection_ID,:);
data_test = data;
data_test(selection_ID,:) = [];
%length_train = length(selection_ID);
end


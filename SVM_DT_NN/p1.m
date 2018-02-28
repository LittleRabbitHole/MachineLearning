%% input data
load pima_train.txt
X_train = pima_train(:, 1:8);
y_train = pima_train(:, 9);
[w, b] = svml(X_train,Y_train,1);
w
b

%%
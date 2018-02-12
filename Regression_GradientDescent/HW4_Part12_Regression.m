%% prob 1 housing.txt regression using normal equation
load housing.txt
features = housing(:, 1:13);
prices = housing(:, 14);

%% correlation among features
cor_vec = []; 
for i = 1:13
    cor_i = corr2(features(:,i), prices);
    cor_vec = [cor_vec, cor_i];
end

%% linear: correlation scatter plot
scatter(features(:,6), prices)
xlabel('V6: RM')
ylabel('Median Price')

% non-linear
scatter(features(:,13), prices)
xlabel('V13: LSTAT')
ylabel('Median Price')

% correlation matrix
corr_mat = corrcoef(housing);

%% optimization and find the coefficient
load housing_train.txt
X_train = housing_train(:,1:13);
Y_train = housing_train(:,14);

W = LR_solve( X_train,  Y_train);

%% prediction
load housing_test.txt
X_test = housing_test(:,1:13);
Y_test = housing_test(:,14);

Y_hat = LR_predict ( X_test, W );

%% MSR on training/test 
main4_2




%% prob 1 housing.txt
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

%% non-linear
scatter(features(:,13), prices)
xlabel('V13: LSTAT')
ylabel('Median Price')

%% correlation matrix


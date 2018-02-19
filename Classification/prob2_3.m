%% load data
load pima_train.txt;
load pima_test.txt;

data_train = pima_train;
p_y_1 = sum(data_train(:,9))/length(data_train(:,9));
p_y_0 = 1 - (sum(data_train(:,9))/length(data_train(:,9)));


Y_predict = [];

for i =1:length(data_train)
    x = data_train(i, :);
    y_hat = predict_NB(x);
    Y_predict = [Y_predict, y_hat];
    
end

data_test = pima_test;


m = size(data_train, 2);

x = data_train(1,1:8)
y = data_train(1,9)

pred_0 = (log(exppdf(x(1), exp_0_1_muhat))+ log(exppdf(x(5), exp_0_5_muhat)) + log(exppdf(x(7), exp_0_7_muhat)) + log(exppdf(x(8), exp_0_8_muhat)) + log(normpdf(x(2),norm_0_2_mu,norm_0_2_sigma)) + log(normpdf(x(3),norm_0_3_mu,norm_0_3_sigma))+ log(normpdf(x(4),norm_0_4_mu,norm_0_4_sigma)) + log(normpdf(x(6),norm_0_6_mu,norm_0_6_sigma)))+ log(p_y_0)
pred_1 = (log(exppdf(x(1), exp_1_1_muhat))+ log(exppdf(x(5), exp_1_5_muhat)) + log(exppdf(x(7), exp_1_7_muhat)) + log(exppdf(x(8), exp_1_8_muhat)) + log(normpdf(x(2),norm_1_2_mu,norm_1_2_sigma)) + log(normpdf(x(3),norm_1_3_mu,norm_1_3_sigma))+ log(normpdf(x(4),norm_1_4_mu,norm_1_4_sigma)) + log(normpdf(x(6),norm_1_6_mu,norm_1_6_sigma)))+ log(p_y_1)

pred_0 >= pred_1
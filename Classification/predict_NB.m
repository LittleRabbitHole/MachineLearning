function [yhat, y_prob] = predict_NB( x )
%predict NB predict based on the attribute distribution
exp_0_1_muhat = 3.2419; exp_1_1_muhat = 4.7100;
exp_0_5_muhat = 67.7168; exp_1_5_muhat = 103.7200;
exp_0_7_muhat = 0.4164; exp_1_7_muhat = 0.5491;
exp_0_8_muhat = 31.1032; exp_1_8_muhat = 37.1200;
norm_0_2_mu = 109.6254; norm_0_2_sigma = 26.2304;
norm_0_3_mu = 67.5339; norm_0_3_sigma = 18.6683;
norm_0_4_mu = 19.7316; norm_0_4_sigma = 14.5828;
norm_0_6_mu = 30.3059; norm_0_6_sigma = 7.7258;

norm_1_2_mu = 141.3950; norm_1_2_sigma = 33.6655;
norm_1_3_mu = 70.1900; norm_1_3_sigma =21.6213;
norm_1_4_mu = 22.9350; norm_1_4_sigma =17.8275;
norm_1_6_mu = 35.2580; norm_1_6_sigma = 7.3286;

p_y_1 = 0.3711; p_y_0 = 0.6289;

log_pred_0 = (log(exppdf(x(1), exp_0_1_muhat))+ log(exppdf(x(5), exp_0_5_muhat)) + log(exppdf(x(7), exp_0_7_muhat)) + log(exppdf(x(8), exp_0_8_muhat)) + log(normpdf(x(2),norm_0_2_mu,norm_0_2_sigma)) + log(normpdf(x(3),norm_0_3_mu,norm_0_3_sigma))+ log(normpdf(x(4),norm_0_4_mu,norm_0_4_sigma)) + log(normpdf(x(6),norm_0_6_mu,norm_0_6_sigma)))+ log(p_y_0);
log_pred_1 = (log(exppdf(x(1), exp_1_1_muhat))+ log(exppdf(x(5), exp_1_5_muhat)) + log(exppdf(x(7), exp_1_7_muhat)) + log(exppdf(x(8), exp_1_8_muhat)) + log(normpdf(x(2),norm_1_2_mu,norm_1_2_sigma)) + log(normpdf(x(3),norm_1_3_mu,norm_1_3_sigma))+ log(normpdf(x(4),norm_1_4_mu,norm_1_4_sigma)) + log(normpdf(x(6),norm_1_6_mu,norm_1_6_sigma)))+ log(p_y_1);
yhat = log_pred_1>log_pred_0;

y_prob_1 = (exppdf(x(1), exp_1_1_muhat)*exppdf(x(5), exp_1_5_muhat)*exppdf(x(7), exp_1_7_muhat)*exppdf(x(8), exp_1_8_muhat)*normpdf(x(2),norm_1_2_mu,norm_1_2_sigma)*normpdf(x(3),norm_1_3_mu,norm_1_3_sigma)*normpdf(x(4),norm_1_4_mu,norm_1_4_sigma)*normpdf(x(6),norm_1_6_mu,norm_1_6_sigma))*(p_y_1);
y_prob_0 = (exppdf(x(1), exp_0_1_muhat)*exppdf(x(5), exp_0_5_muhat)*exppdf(x(7), exp_0_7_muhat)*exppdf(x(8), exp_0_8_muhat)*normpdf(x(2),norm_0_2_mu,norm_0_2_sigma)*normpdf(x(3),norm_0_3_mu,norm_0_3_sigma)*normpdf(x(4),norm_0_4_mu,norm_0_4_sigma)*normpdf(x(6),norm_1_6_mu,norm_0_6_sigma))*(p_y_0);
y_prob = y_prob_1/(y_prob_1+y_prob_0);
end


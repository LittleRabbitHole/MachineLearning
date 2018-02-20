%% load data
load pima_train.txt;
load pima_test.txt;

data_train = pima_train;
data_test = pima_test;

%% application of expfit and normfit functions
m = size(data_train, 2);

%%% class_0 : all inputs (x) with label class 0
data_ones_ind = data_train(:,m)== 1;
class_1 = data_train(data_ones_ind,:);

%%% class_1 : all inputs (x) with label class 1
data_zeros_ind = data_train(:,m)== 0;
class_0 = data_train(data_zeros_ind,:);

%% fit the exponential distribution for attribute 1,5,7,8
%% attribute 1
%%% p(x_1|y=0, \mu_0_1)
[exp_0_1_muhat, exp_0_1_muci] = expfit(class_0(:,1));
%%% p(x_1|y=1, \mu_1_1)
[exp_1_1_muhat, exp_1_1_muci] = expfit(class_1(:,1));

exp_0_1_muhat
exp_1_1_muhat
%% attribute 5
%%% p(x_5|y=0, \mu_0_5)
[exp_0_5_muhat, exp_0_5_muci] = expfit(class_0(:,5));
%%% p(x_5|y=1, \mu_1_5)
[exp_1_5_muhat, exp_1_5_muci] = expfit(class_1(:,5));

exp_0_5_muhat
exp_0_5_muci

exp_1_5_muhat
exp_1_5_muci

%% attribute 7
%%% p(x_7|y=0, \mu_0_7)
[exp_0_7_muhat, exp_0_7_muci] = expfit(class_0(:,7));
%%% p(x_7|y=1, \mu_1_7)
[exp_1_7_muhat, exp_1_7_muci] = expfit(class_1(:,7));

exp_0_7_muhat
exp_0_7_muci

exp_1_7_muhat
exp_1_7_muci
%% attribute 8
%%% p(x_8|y=0, \mu_0_8)
[exp_0_8_muhat, exp_0_8_muci] = expfit(class_0(:,8));
%%% p(x_8|y=1, \mu_1_8)
[exp_1_8_muhat, exp_1_8_muci] = expfit(class_1(:,8));

exp_0_8_muhat
exp_0_8_muci

exp_1_8_muhat
exp_1_8_muci

%% fitting the normal distribution for [2 3 4 6]
%% attribute 2
%%% p(x_2|y=0,mu_0_2,sigma_0_2)
[norm_0_2_mu,norm_0_2_sigma,muci_0_2,sci_0_2] = normfit(class_0(:,2));
%%% p(x_2|y=1,mu_1_2,sigma_1_2)
[norm_1_2_mu,norm_1_2_sigma,muci_1_2,sci_1_2] = normfit(class_1(:,2));

%% attribute 3
%%% p(x_3|y=0,mu_0_3,sigma_0_3)
[norm_0_3_mu,norm_0_3_sigma,muci_0_3,sci_0_3] = normfit(class_0(:,3));
%%% p(x_3|y=1,mu_1_3,sigma_1_3)
[norm_1_3_mu,norm_1_3_sigma,muci_1_3,sci_1_3] = normfit(class_1(:,3));

%% attribute 4
%%% p(x_4|y=0,mu_0_4,sigma_0_4)
[norm_0_4_mu,norm_0_4_sigma,muci_0_4,sci_0_4] = normfit(class_0(:,4));
%%% p(x_4|y=1,mu_1_4,sigma_1_4)
[norm_1_4_mu,norm_1_4_sigma,muci_1_4,sci_1_4] = normfit(class_1(:,4));

%% attribute 6
%%% p(x_6|y=0,mu_0_6,sigma_0_6)
[norm_0_6_mu,norm_0_6_sigma,muci_0_6,sci_0_6] = normfit(class_0(:,6));
%%% p(x_6|y=1,mu_1_6,sigma_1_6)
[norm_1_6_mu,norm_1_6_sigma,muci_1_6,sci_1_6] = normfit(class_1(:,6));


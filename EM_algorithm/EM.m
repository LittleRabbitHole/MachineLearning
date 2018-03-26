%%%% load the train and test data (both are normalized)
load customer_train.txt;
load customer_test.txt;
tr_data = customer_train;
test_data = customer_test;

data_col= size(tr_data,2);
n_features = data_col - 1;

%% p(x1 =k)5
p_x1k1 =  size(tr_data(tr_data(:,1)==1,:),1)/(size(tr_data,1) - size(tr_data(tr_data(:,1)==0,:),1));
p_x1k2 =  size(tr_data(tr_data(:,1)==2,:),1)/(size(tr_data,1) - size(tr_data(tr_data(:,1)==0,:),1));
p_x1k3 =  size(tr_data(tr_data(:,1)==3,:),1)/(size(tr_data,1) - size(tr_data(tr_data(:,1)==0,:),1));
p_x1k4 =  size(tr_data(tr_data(:,1)==4,:),1)/(size(tr_data,1) - size(tr_data(tr_data(:,1)==0,:),1));
p_x1k5 =  size(tr_data(tr_data(:,1)==5,:),1)/(size(tr_data,1) - size(tr_data(tr_data(:,1)==0,:),1));
p_x1k = [p_x1k1, p_x1k2, p_x1k3, p_x1k4, p_x1k5];

%% p(x2 =k)3
p_x2k1 =  size(tr_data(tr_data(:,2)==1,:),1)/(size(tr_data,1) - size(tr_data(tr_data(:,2)==0,:),1));
p_x2k2 =  size(tr_data(tr_data(:,2)==2,:),1)/(size(tr_data,1) - size(tr_data(tr_data(:,2)==0,:),1));
p_x2k3 =  size(tr_data(tr_data(:,2)==3,:),1)/(size(tr_data,1) - size(tr_data(tr_data(:,2)==0,:),1));
p_x2k = [p_x2k1, p_x2k2, p_x2k3];

%% p(x3 =k)3
p_x3k1 =  size(tr_data(tr_data(:,3)==1,:),1)/(size(tr_data,1) - size(tr_data(tr_data(:,3)==0,:),1));
p_x3k2 =  size(tr_data(tr_data(:,3)==2,:),1)/(size(tr_data,1) - size(tr_data(tr_data(:,3)==0,:),1));
p_x3k3 =  size(tr_data(tr_data(:,3)==3,:),1)/(size(tr_data,1) - size(tr_data(tr_data(:,3)==0,:),1));
p_x3k = [p_x3k1, p_x3k2, p_x3k3];

%% p(x4 =k)4
p_x4k1 =  size(tr_data(tr_data(:,4)==1,:),1)/(size(tr_data,1) - size(tr_data(tr_data(:,4)==0,:),1));
p_x4k2 =  size(tr_data(tr_data(:,4)==2,:),1)/(size(tr_data,1) - size(tr_data(tr_data(:,4)==0,:),1));
p_x4k3 =  size(tr_data(tr_data(:,4)==3,:),1)/(size(tr_data,1) - size(tr_data(tr_data(:,4)==0,:),1));
p_x4k4 =  size(tr_data(tr_data(:,4)==4,:),1)/(size(tr_data,1) - size(tr_data(tr_data(:,4)==0,:),1));
p_x4k = [p_x4k1, p_x4k2, p_x4k3, p_x4k4];

%% p(x5 =k)5
p_x5k1 =  size(tr_data(tr_data(:,5)==1,:),1)/(size(tr_data,1) - size(tr_data(tr_data(:,5)==0,:),1));
p_x5k2 =  size(tr_data(tr_data(:,5)==2,:),1)/(size(tr_data,1) - size(tr_data(tr_data(:,5)==0,:),1));
p_x5k3 =  size(tr_data(tr_data(:,5)==3,:),1)/(size(tr_data,1) - size(tr_data(tr_data(:,5)==0,:),1));
p_x5k4 =  size(tr_data(tr_data(:,5)==4,:),1)/(size(tr_data,1) - size(tr_data(tr_data(:,5)==0,:),1));
p_x5k5 =  size(tr_data(tr_data(:,5)==5,:),1)/(size(tr_data,1) - size(tr_data(tr_data(:,5)==0,:),1));
p_x5k = [p_x5k1, p_x5k2, p_x5k3, p_x5k4, p_x5k5];

%% p(x6 =k)4
p_x6k1 =  size(tr_data(tr_data(:,6)==1,:),1)/(size(tr_data,1) - size(tr_data(tr_data(:,6)==0,:),1));
p_x6k2 =  size(tr_data(tr_data(:,6)==2,:),1)/(size(tr_data,1) - size(tr_data(tr_data(:,6)==0,:),1));
p_x6k3 =  size(tr_data(tr_data(:,6)==3,:),1)/(size(tr_data,1) - size(tr_data(tr_data(:,6)==0,:),1));
p_x6k4 =  size(tr_data(tr_data(:,6)==4,:),1)/(size(tr_data,1) - size(tr_data(tr_data(:,6)==0,:),1));
p_x6k = [p_x6k1, p_x6k2, p_x6k3, p_x6k4];

%%
p_xk = cell(1,6);
p_xk{1} = p_x1k;
p_xk{2} = p_x2k;
p_xk{3} = p_x3k;
p_xk{4} = p_x4k;
p_xk{5} = p_x5k;
p_xk{6} = p_x6k;

%% initialize parameters
p_y = [0.25, 0.25, 0.25, 0.25];

% size(theta_x) = (num of hidden class, num of product catogry)
theta_x1 = [0.2,	0.2,	0.2,	0.2,	0.2;
            0.2,	0.2,	0.2,	0.2,	0.2;
            0.2,	0.2,	0.2,	0.2,	0.2;
            0.2,	0.2,	0.2,	0.2,	0.2];

theta_x2 = [1/3,	1/3,	1/3;
            1/3,	1/3,	1/3;
            1/3,	1/3,	1/3;
            1/3,	1/3,	1/3];

theta_x3 = [1/3,	1/3,	1/3;
            1/3,	1/3,	1/3;
            1/3,	1/3,	1/3;
            1/3,	1/3,	1/3];

theta_x4 = [1/4,    1/4,    1/4,    1/4;
            1/4,    1/4,    1/4,    1/4;
            1/4,    1/4,    1/4,    1/4;
            1/4,    1/4,    1/4,    1/4];

theta_x5 = [0.2,	0.2,	0.2,	0.2,	0.2;
            0.2,	0.2,	0.2,	0.2,	0.2;
            0.2,	0.2,	0.2,	0.2,	0.2;
            0.2,	0.2,	0.2,	0.2,	0.2];

theta_x6 = [1/4,    1/4,    1/4,    1/4;
            1/4,    1/4,    1/4,    1/4;
            1/4,    1/4,    1/4,    1/4;
            1/4,    1/4,    1/4,    1/4];

%%
theta_xi = cell(1,6);
theta_xi{1} = theta_x1;
theta_xi{2} = theta_x2;
theta_xi{3} = theta_x3;
theta_xi{4} = theta_x4;
theta_xi{5} = theta_x5;
theta_xi{6} = theta_x6;
% index: theta_xi{xi} = [k, xi]
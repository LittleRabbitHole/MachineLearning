%%%% load the train and test data (both are normalized)
load customer_train.txt;
load customer_test.txt;
tr_data = customer_train;
test_data = customer_test;

data_col= size(tr_data,2);
n_features = data_col - 1;
N = size(tr_data,1);

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
s = rng;

py1 = 0.25*rand(1); py2= 0.25*rand(1); py3= 0.25*rand(1);
p_y = [py1, py2, py3, 1-(py1+py2+py3)];

% size(theta_x) = (num of hidden class, num of product catogry)
% p(Xi = k|C = j)
%x1
t1_11 = 1/5*rand(1); t1_12 = 1/5*rand(1); t1_13 = 1/5*rand(1); t1_14 = 1/5*rand(1);
t1_21= 1/5*rand(1); t1_22 = 1/5*rand(1); t1_23= 1/5*rand(1); t1_24= 1/5*rand(1);
t1_31= 1/5*rand(1); t1_32= 1/5*rand(1);	t1_33= 1/5*rand(1); t1_34= 1/5*rand(1);
t1_41= 1/5*rand(1); t1_42= 1/5*rand(1);	t1_43= 1/5*rand(1); t1_44= 1/5*rand(1);

theta_x1 = [t1_11,	t1_12,	t1_13,	t1_14,	1-(t1_11+t1_12+t1_13+t1_14);
            t1_21,	t1_22,	t1_23,	t1_24,	1-(t1_21+t1_22+t1_23+t1_24);
            t1_31,	t1_32,	t1_33,	t1_34,	1-(t1_31+t1_32+t1_33+t1_34);
            t1_41,	t1_42,	t1_43,	t1_44,	1-(t1_41+t1_42+t1_43+t1_44)];
%x2
t2_11 = 1/3*rand(1); t2_12 = 1/3*rand(1); 
t2_21= 1/3*rand(1); t2_22 = 1/3*rand(1); 
t2_31= 1/3*rand(1); t2_32= 1/3*rand(1);	
t2_41= 1/3*rand(1); t2_42= 1/3*rand(1);	

theta_x2 = [t2_11,	t2_12,	1-(t2_11+t2_12);
            t2_21,	t2_22,	1-(t2_21+t2_22);
            t2_31,	t2_32,	1-(t2_31+t2_32);
            t2_41,	t2_42,	1-(t2_41+t2_42)];

%x3
t3_11 = 1/3*rand(1); t3_12 = 1/3*rand(1); 
t3_21= 1/3*rand(1); t3_22 = 1/3*rand(1); 
t3_31= 1/3*rand(1); t3_32= 1/3*rand(1);	
t3_41= 1/3*rand(1); t3_42= 1/3*rand(1);	

theta_x3 = [t3_11,	t3_12,	1-(t3_11+t3_12);
            t3_21,	t3_22,	1-(t3_21+t3_22);
            t3_31,	t3_32,	1-(t3_31+t3_32);
            t3_41,	t3_42,	1-(t3_41+t3_42)];

%x4
t4_11 = 1/4*rand(1); t4_12 = 1/4*rand(1); t4_13 = 1/4*rand(1);  
t4_21= 1/4*rand(1); t4_22 = 1/4*rand(1); t4_23 = 1/4*rand(1);
t4_31= 1/4*rand(1); t4_32= 1/4*rand(1);	t4_33 = 1/4*rand(1);
t4_41= 1/4*rand(1); t4_42= 1/4*rand(1);	t4_43 = 1/4*rand(1);

theta_x4 = [t4_11,    t4_12,    t4_13,    1-t4_11-t4_12-t4_13;
            t4_21,    t4_22,    t4_23,    1-t4_21-t4_22-t4_23;
            t4_31,    t4_32,    t4_33,    1-t4_31-t4_32-t4_33;
            t4_41,    t4_42,    t4_43,    1-t4_41-t4_42-t4_43];

%x5
t5_11 = 1/5*rand(1); t5_12 = 1/5*rand(1); t5_13 = 1/5*rand(1); t5_14 = 1/5*rand(1);
t5_21= 1/5*rand(1); t5_22 = 1/5*rand(1); t5_23= 1/5*rand(1); t5_24= 1/5*rand(1);
t5_31= 1/5*rand(1); t5_32= 1/5*rand(1);	t5_33= 1/5*rand(1); t5_34= 1/5*rand(1);
t5_41= 1/5*rand(1); t5_42= 1/5*rand(1);	t5_43= 1/5*rand(1); t5_44= 1/5*rand(1);

theta_x5 = [t5_11,	t5_12,	t5_13,	t5_14,	1-(t5_11+t5_12+t5_13+t5_14);
            t5_21,	t5_22,	t5_23,	t5_24,	1-(t5_21+t5_22+t5_23+t5_24);
            t5_31,	t5_32,	t5_33,	t5_34,	1-(t5_31+t5_32+t5_33+t5_34);
            t5_41,	t5_42,	t5_43,	t5_44,	1-(t5_41+t5_42+t5_43+t5_44)];

%x6
t6_11 = 1/4*rand(1); t6_12 = 1/4*rand(1); t6_13 = 1/4*rand(1);  
t6_21= 1/4*rand(1); t6_22 = 1/4*rand(1); t6_23 = 1/4*rand(1);
t6_31= 1/4*rand(1); t6_32= 1/4*rand(1);	t6_33 = 1/4*rand(1);
t6_41= 1/4*rand(1); t6_42= 1/4*rand(1);	t6_43 = 1/4*rand(1);

theta_x6 = [t6_11,    t6_12,    t6_13,    1-t6_11-t6_12-t6_13;
            t6_21,    t6_22,    t6_23,    1-t6_21-t6_22-t6_23;
            t6_31,    t6_32,    t6_33,    1-t6_31-t6_32-t6_33;
            t6_41,    t6_42,    t6_43,    1-t6_41-t6_42-t6_43];

%%
theta_xi = cell(1,6);
theta_xi{1} = theta_x1;
theta_xi{2} = theta_x2;
theta_xi{3} = theta_x3;
theta_xi{4} = theta_x4;
theta_xi{5} = theta_x5;
theta_xi{6} = theta_x6;
% index: theta_xi{xi} = [k, xi]
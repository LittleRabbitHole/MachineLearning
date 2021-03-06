%%%% load the train and test data (both are normalized)
load customer_train.txt;
load customer_test.txt;
tr_data = customer_train;
test_data = customer_test;

data_col= size(tr_data,2);
n_features = data_col - 1;
N = size(tr_data,1);

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

%
theta_xi = cell(1,6);
theta_xi{1} = theta_x1;
theta_xi{2} = theta_x2;
theta_xi{3} = theta_x3;
theta_xi{4} = theta_x4;
theta_xi{5} = theta_x5;
theta_xi{6} = theta_x6;
% index: theta_xi{xi} = [k, xi]

%% iteration, using the EM_iteraction function
delta = 100;
deltas = [];
thetas0 = [];
thetas1 = [];
[ N_cj_new, N_cjik_new, Q_theta0 ] = EM_interation( p_y, theta_xi, tr_data );
 
while delta >= 0.01 
    %[ N_cj_new, N_cjik_new, Q_theta0 ] = EM_interation(p_y, theta_xi, tr_data );
    p_y =  N_cj_new
    theta_xi = N_cjik_new;
    [ N_cj_new, N_cjik_new, Q_theta1 ] = EM_interation( p_y, theta_xi, tr_data );
    thetas1 = [thetas1, Q_theta1];
    delta = abs(Q_theta1 -  Q_theta0)
    deltas = [deltas, delta];
    Q_theta0 = Q_theta1;
    thetas0 = [thetas0, Q_theta0];
end

N_cj_new
N_cjik_new

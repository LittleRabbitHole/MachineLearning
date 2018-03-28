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

% p(x2 =k)3
p_x2k1 =  size(tr_data(tr_data(:,2)==1,:),1)/(size(tr_data,1) - size(tr_data(tr_data(:,2)==0,:),1));
p_x2k2 =  size(tr_data(tr_data(:,2)==2,:),1)/(size(tr_data,1) - size(tr_data(tr_data(:,2)==0,:),1));
p_x2k3 =  size(tr_data(tr_data(:,2)==3,:),1)/(size(tr_data,1) - size(tr_data(tr_data(:,2)==0,:),1));
p_x2k = [p_x2k1, p_x2k2, p_x2k3];

% p(x3 =k)3
p_x3k1 =  size(tr_data(tr_data(:,3)==1,:),1)/(size(tr_data,1) - size(tr_data(tr_data(:,3)==0,:),1));
p_x3k2 =  size(tr_data(tr_data(:,3)==2,:),1)/(size(tr_data,1) - size(tr_data(tr_data(:,3)==0,:),1));
p_x3k3 =  size(tr_data(tr_data(:,3)==3,:),1)/(size(tr_data,1) - size(tr_data(tr_data(:,3)==0,:),1));
p_x3k = [p_x3k1, p_x3k2, p_x3k3];

% p(x4 =k)4
p_x4k1 =  size(tr_data(tr_data(:,4)==1,:),1)/(size(tr_data,1) - size(tr_data(tr_data(:,4)==0,:),1));
p_x4k2 =  size(tr_data(tr_data(:,4)==2,:),1)/(size(tr_data,1) - size(tr_data(tr_data(:,4)==0,:),1));
p_x4k3 =  size(tr_data(tr_data(:,4)==3,:),1)/(size(tr_data,1) - size(tr_data(tr_data(:,4)==0,:),1));
p_x4k4 =  size(tr_data(tr_data(:,4)==4,:),1)/(size(tr_data,1) - size(tr_data(tr_data(:,4)==0,:),1));
p_x4k = [p_x4k1, p_x4k2, p_x4k3, p_x4k4];

% p(x5 =k)5
p_x5k1 =  size(tr_data(tr_data(:,5)==1,:),1)/(size(tr_data,1) - size(tr_data(tr_data(:,5)==0,:),1));
p_x5k2 =  size(tr_data(tr_data(:,5)==2,:),1)/(size(tr_data,1) - size(tr_data(tr_data(:,5)==0,:),1));
p_x5k3 =  size(tr_data(tr_data(:,5)==3,:),1)/(size(tr_data,1) - size(tr_data(tr_data(:,5)==0,:),1));
p_x5k4 =  size(tr_data(tr_data(:,5)==4,:),1)/(size(tr_data,1) - size(tr_data(tr_data(:,5)==0,:),1));
p_x5k5 =  size(tr_data(tr_data(:,5)==5,:),1)/(size(tr_data,1) - size(tr_data(tr_data(:,5)==0,:),1));
p_x5k = [p_x5k1, p_x5k2, p_x5k3, p_x5k4, p_x5k5];

% p(x6 =k)4
p_x6k1 =  size(tr_data(tr_data(:,6)==1,:),1)/(size(tr_data,1) - size(tr_data(tr_data(:,6)==0,:),1));
p_x6k2 =  size(tr_data(tr_data(:,6)==2,:),1)/(size(tr_data,1) - size(tr_data(tr_data(:,6)==0,:),1));
p_x6k3 =  size(tr_data(tr_data(:,6)==3,:),1)/(size(tr_data,1) - size(tr_data(tr_data(:,6)==0,:),1));
p_x6k4 =  size(tr_data(tr_data(:,6)==4,:),1)/(size(tr_data,1) - size(tr_data(tr_data(:,6)==0,:),1));
p_x6k = [p_x6k1, p_x6k2, p_x6k3, p_x6k4];

%
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

%
theta_xi = cell(1,6);
theta_xi{1} = theta_x1;
theta_xi{2} = theta_x2;
theta_xi{3} = theta_x3;
theta_xi{4} = theta_x4;
theta_xi{5} = theta_x5;
theta_xi{6} = theta_x6;
% index: theta_xi{xi} = [k, xi]

%%
delta = 100;
deltas = [];
thetas0 = [];
thetas1 = [];
[ N_cj_new, N_cjik_new, Q_theta0 ] = EM_interation( p_xk, p_y, theta_xi, tr_data );
ite = 200;

while ite > 1
%while delta >= 0.01 
    %[ N_cj_new, N_cjik_new, Q_theta0 ] = EM_interation( p_xk, p_y, theta_xi, tr_data );
    ite = ite - 1;
    p_y =  N_cj_new
    theta_xi = N_cjik_new;
    [ N_cj_new, N_cjik_new, Q_theta1 ] = EM_interation( p_xk, p_y, theta_xi, tr_data );
    thetas1 = [thetas1, Q_theta1];
    delta = abs(Q_theta1 -  Q_theta0)
    deltas = [deltas, delta];
    Q_theta0 = Q_theta1;
    thetas0 = [thetas0, Q_theta0];
end

N_cj_new
N_cjik_new

%%
x6s =[];
x6theta = N_cjik_new{6};

for l = 1:size(test_data,1)
    d1_y = test_data(l,6);
    x6theta = N_cjik_new{6}(:, d1_y);

    d1 = test_data(1,1:5);
    for d_xi = 1:size(d1,2) %d_xi = 1,2,3,4,5,6 as index of x dimension
        k_xi = d1(1, d_xi); %k_xi = d1(1), d1(2), d1(3), d1(4), d1(5), d1(6)
        if k_xi > 0
            c1_theta_xid1 = [c1_theta_xid1,N_cjik_new{d_xi}(1, k_xi)]; %class 1 for xi: theta_xi(c, k, xi)
            c2_theta_xid1 = [c2_theta_xid1,N_cjik_new{d_xi}(2, k_xi)]; %class 2
            c3_theta_xid1 = [c3_theta_xid1,N_cjik_new{d_xi}(3, k_xi)];
            c4_theta_xid1 = [c4_theta_xid1,N_cjik_new{d_xi}(4, k_xi)];
        else
            c1_theta_xid1 = [c1_theta_xid1,1];
            c2_theta_xid1 = [c2_theta_xid1,1];
            c3_theta_xid1 = [c3_theta_xid1,1];
            c4_theta_xid1 = [c4_theta_xid1,1];       

        end
    end    
    % Ej
    all_cj = [p_y(1)*prod(c1_theta_xid1), p_y(2)*prod(c2_theta_xid1), p_y(3)*prod(c3_theta_xid1), p_y(1)*prod(c4_theta_xid1)];
    sump_cj = sum(all_cj);
    p_c1_dthata = N_cj_new(1)*prod(c1_theta_xid1)/sump_cj;
    p_c2_dthata = N_cj_new(2)*prod(c2_theta_xid1)/sump_cj;
    p_c3_dthata = N_cj_new(3)*prod(c3_theta_xid1)/sump_cj;
    p_c4_dthata = N_cj_new(4)*prod(c4_theta_xid1)/sump_cj;
    p_cj_dthata = [p_c1_dthata, p_c2_dthata, p_c3_dthata, p_c4_dthata];

    %second half
    dtheta = []; %(5features, 4classes)
    for d_xi = 1:size(d1,2) %d_xi = 1,2,3,4,5,6 as index of x dimension
        %E_ijk{d_xi} = cat(3, []);%,zeros(N, 4),zeros(N, 4),zeros(N, 4),zeros(N, 4),zeros(N, 4)); %{xi} = [ndata*nclass for k=1],[k=2],[c3],[c4]
        %e_ijk_dxi = [];
        k_xi = d1(1, d_xi); %k_xi = d1(1), d1(2), d1(3), d1(4), d1(5), d1(6)
        if k_xi ~= 0
            dtheta_ijk = N_cjik_new{d_xi}(:, k_xi)';
            %E_ijk{d_xi}(l,:,ki_xi) = e_ijk;
        else % if missing, expect the k   
            e_ijk = p_cj_dthata;
            ek_xi = find(e_ijk == max(e_ijk(:)));
            dtheta_ijk = N_cjik_new{d_xi}(:, ek_xi)';
        end
        dtheta = [dtheta; dtheta_ijk];
    end 


    p1 = sum(x6theta(1,:)*sum(prod(dtheta,1)))/sum(sum(x6theta*sum(prod(dtheta,1))));
    p2 = sum(x6theta(2,:)*sum(prod(dtheta,1)))/sum(sum(x6theta*sum(prod(dtheta,1))));
    p2 = sum(x6theta(3,:)*sum(prod(dtheta,1)))/sum(sum(x6theta*sum(prod(dtheta,1))));
    p3 = sum(x6theta(4,:)*sum(prod(dtheta,1)))/sum(sum(x6theta*sum(prod(dtheta,1))));
    p = [p1,p2,p3,p4];
    x6 = find(p == max(p(:)));
    x6s = [x6s, x6];
end

%%
crosstab(x6s', test_data(:,6))

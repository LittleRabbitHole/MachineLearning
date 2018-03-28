%N_cj_new N_cjik_new we get from main8_1a.m

% prediction
x6s =[];
x6theta = N_cjik_new{6};
ps = [];

for l = 1:size(test_data,1)
    %d1_y = test_data(l,6);
    %x6theta = N_cjik_new{6}(:, d1_y);
    c1_theta_xid1 = [];
    c2_theta_xid1 = [];
    c3_theta_xid1 = [];
    c4_theta_xid1 = [];
    
    %estimate the hidden class
    d1 = test_data(l,1:5);
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
    % E of hidden class
    all_cj = [p_y(1)*prod(c1_theta_xid1), p_y(2)*prod(c2_theta_xid1), p_y(3)*prod(c3_theta_xid1), p_y(1)*prod(c4_theta_xid1)];
    sump_cj = sum(all_cj);
    p_c1_dthata = N_cj_new(1)*prod(c1_theta_xid1)/sump_cj;
    p_c2_dthata = N_cj_new(2)*prod(c2_theta_xid1)/sump_cj;
    p_c3_dthata = N_cj_new(3)*prod(c3_theta_xid1)/sump_cj;
    p_c4_dthata = N_cj_new(4)*prod(c4_theta_xid1)/sump_cj;
    p_cj_dthata = [p_c1_dthata, p_c2_dthata, p_c3_dthata, p_c4_dthata];

    %extract parameters for each data point
    dtheta = []; %(5features, 4classes)
    for d_xi = 1:size(d1,2) %d_xi = 1,2,3,4,5,6 as index of x dimension
        k_xi = d1(1, d_xi); %k_xi = d1(1), d1(2), d1(3), d1(4), d1(5), d1(6)
        if k_xi ~= 0
            dtheta_ijk = N_cjik_new{d_xi}(:, k_xi)';
            %E_ijk{d_xi}(l,:,ki_xi) = e_ijk;
        else % if missing, expect the k   
            %e_ijk = p_cj_dthata;
            %ek_xi = find(e_ijk == max(e_ijk(:)));
            %dtheta_ijk = N_cjik_new{d_xi}(:, ek_xi)';
            dtheta_ijk = [1,1,1,1];
        end
        dtheta = [dtheta; dtheta_ijk];
    end 
    %N_cj_new
    %N_cjik_new
    
    %estimate the x6
    sumall = ((x6theta(:,1)'.*prod(dtheta,1)) + (x6theta(:,2)'.*prod(dtheta,1)) + (x6theta(:,3)'.*prod(dtheta,1)) + (x6theta(:,4)'.*prod(dtheta,1)));
    sumpk = sum(N_cj_new .* sumall);
    pk1 = sum(N_cj_new .*((x6theta(:,1)'.*prod(dtheta,1))))/sumpk;
    pk2 = sum(N_cj_new .*((x6theta(:,2)'.*prod(dtheta,1))))/sumpk;
    pk3 = sum(N_cj_new .*((x6theta(:,3)'.*prod(dtheta,1))))/sumpk;
    pk4 = sum(N_cj_new .*((x6theta(:,4)'.*prod(dtheta,1))))/sumpk;
    p = [pk1,pk2,pk3,pk4];
    ps = [ps; p];
    x6 = find(p == max(p(:)));
    x6s = [x6s, x6];
end

%% results

crosstab(x6s, test_data(:,6))

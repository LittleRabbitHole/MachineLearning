% p(c_l = j | D_l, theta') = p(c_l = j, D_l, theta')/sum(p(c_l = 1-j, D_l, theta'))
% d1 = tr_data(1,:); %[k_x1, k_x2, ..., k_x6]

%% Nc=j
p_cj_Dsthata = [];
E_ijk = cell(1,6) %{xi} = [n of data point, # of c different classes, # of values xi can take]
%loop over data points
for l = 1:size(tr_data,1)
    d1 = tr_data(l,:);
    c1_theta_xid1 = [];
    c2_theta_xid1 = [];
    c3_theta_xid1 = [];
    c4_theta_xid1 = [];
   
     %loop over festure dimensions
    for d_xi = 1:size(d1,2) %d_xi = 1,2,3,4,5,6 as index of x dimension
       k_xi = d1(1, d_xi); %k_xi = d1(1), d1(2), d1(3), d1(4), d1(5), d1(6)
       if k_xi > 0
           c1_theta_xid1 = [c1_theta_xid1,theta_xi{d_xi}(1, k_xi)]; %class 1 for xi: theta_xi(c, k, xi)
           c2_theta_xid1 = [c2_theta_xid1,theta_xi{d_xi}(2, k_xi)]; %class 2
           c3_theta_xid1 = [c3_theta_xid1,theta_xi{d_xi}(3, k_xi)];
           c4_theta_xid1 = [c4_theta_xid1,theta_xi{d_xi}(4, k_xi)];
       else
           c1_theta_xid1 = [c1_theta_xid1,1];
           c2_theta_xid1 = [c2_theta_xid1,1];
           c3_theta_xid1 = [c3_theta_xid1,1];
           c4_theta_xid1 = [c4_theta_xid1,1];       
       
       end
    end    
    % Ej
    sump_cj = (prod(c1_theta_xid1)+ prod(c2_theta_xid1)+prod(c3_theta_xid1)+ prod(c4_theta_xid1));
    p_c1_dthata = prod(c1_theta_xid1)/sump_cj;
    p_c2_dthata = prod(c2_theta_xid1)/sump_cj;
    p_c3_dthata = prod(c3_theta_xid1)/sump_cj;
    p_c4_dthata = prod(c4_theta_xid1)/sump_cj;
    p_cj_dthata = [p_c1_dthata, p_c2_dthata, p_c3_dthata, p_c4_dthata];
    % Ej
    p_cj_Dsthata = [p_cj_Dsthata; p_cj_dthata];
    
    %second half
    for d_xi = 1:size(d1,2) %d_xi = 1,2,3,4,5,6 as index of x dimension
        E_ijk{d_xi} = cat(3, [],[],[],[],[],[]); %{xi} = [ndata*nclass for k=1],[k=2],[c3],[c4]
        e_ijk_dxi = [];
        k_xi = d1(1, d_xi); %k_xi = d1(1), d1(2), d1(3), d1(4), d1(5), d1(6)
        for ki_xi = 1:max(tr_data(:,d_xi)) %loop over values x can take
            if ki_xi == k_xi & ki_xi > 0
                e_ijk = p_cj_dthata;
            elseif ki_xi == 0   
                p_k_cd = (p_xk{d_xi}(k_xi))*(sump_cj)/(sum(p_xk{d_xi}*(sump_cj)));
                e_ijk = p_cj_dthata*p_k_cd;
            else
                e_ijk = [0, 0, 0, 0];
            end
            %append e_ijk
            %E_ijk{d_xi}(:,:,ki_xi) = [1, E_ijk{d_xi}(:,:,ki_xi); e_ijk]
            e_ijk_dxi = [e_ijk_dxi; e_ijk]
        end    
    end

    
end



N_cj = sum(p_cj_Dsthata)
partA = sum(N_cj.* log(p_y))
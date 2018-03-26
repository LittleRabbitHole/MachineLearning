% p(c_l = j | D_l, theta') = p(c_l = j, D_l, theta')/sum(p(c_l = 1-j, D_l, theta'))
% d1 = tr_data(1,:); %[k_x1, k_x2, ..., k_x6]
k_max = [5,3,3,4,5,4];
%% Nc=j
E_cj_Dsthata = [];
E_ijk = cell(1,6); %{xi} = [n of data point, # of c different classes, # of values xi can take]
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
    sump_cj = p_y(1)*prod(c1_theta_xid1)+ p_y(2)*prod(c2_theta_xid1)+p_y(3)*prod(c3_theta_xid1)+ p_y(1)*prod(c4_theta_xid1);
    p_c1_dthata = p_y(1)*prod(c1_theta_xid1)/sump_cj;
    p_c2_dthata = p_y(2)*prod(c2_theta_xid1)/sump_cj;
    p_c3_dthata = p_y(3)*prod(c3_theta_xid1)/sump_cj;
    p_c4_dthata = p_y(4)*prod(c4_theta_xid1)/sump_cj;
    p_cj_dthata = [p_c1_dthata, p_c2_dthata, p_c3_dthata, p_c4_dthata];
    % Ej
    E_cj_Dsthata = [p_cj_Dsthata; p_cj_dthata];
    
    %second half
    for d_xi = 1:size(d1,2) %d_xi = 1,2,3,4,5,6 as index of x dimension
        E_ijk{d_xi} = cat(3, []);%,zeros(N, 4),zeros(N, 4),zeros(N, 4),zeros(N, 4),zeros(N, 4)); %{xi} = [ndata*nclass for k=1],[k=2],[c3],[c4]
        %e_ijk_dxi = [];
        k_xi = d1(1, d_xi); %k_xi = d1(1), d1(2), d1(3), d1(4), d1(5), d1(6)
        for ki_xi = 1:k_max(d_xi) %loop over values x can take
            E_ijk{d_xi} = cat(3, E_ijk{d_xi}, zeros(N, 4));
            if ki_xi == k_xi & ki_xi > 0
                e_ijk = p_cj_dthata;
            elseif ki_xi == 0   
                p_k_cd = (p_xk{d_xi}(k_xi))*(sump_cj)/(sum(p_xk{d_xi}*(sump_cj)));
                e_ijk = p_cj_dthata*p_k_cd;
            else
                e_ijk = [0, 0, 0, 0];
            end
            %append e_ijk
            E_ijk{d_xi}(l,:,ki_xi) = e_ijk;
            %e_ijk_dxi = [e_ijk_dxi; e_ijk]
        end    
    end  
end


%%
N_cj = sum(E_cj_Dsthata)
N_cjik = cell(1,6);
%(num of hidden class, num of product catogry)
N_cjik{1} = reshape(sum(E_ijk{1}), 4, 5);
N_cjik{2} = reshape(sum(E_ijk{2}), 4, 3);
N_cjik{3} = reshape(sum(E_ijk{3}), 4, 3);
N_cjik{4} = reshape(sum(E_ijk{4}), 4, 4);
N_cjik{5} = reshape(sum(E_ijk{5}), 4, 5);
N_cjik{6} = reshape(sum(E_ijk{6}), 4, 4);
partA = sum(N_cj.* log(p_y))
partB = sum(sum(N_cjik{1}.*log(theta_x1))) + sum(sum(N_cjik{2}.*log(theta_x2))) + sum(sum(N_cjik{3}.*log(theta_x3))) + sum(sum(N_cjik{4}.*log(theta_x4))) + sum(sum(N_cjik{5}.*log(theta_x5))) + sum(sum(N_cjik{6}.*log(theta_x6)));
Q_theta0 = partA + partB;

%% M step
N_cj_new = N_cj/sum(N_cj);
N_cjik_new = cell(1,6);

N_cjik_new{1} = N_cjik{1}/sum(N_cjik{1});
N_cjik_new{2} = reshape(sum(E_ijk{2}), 4, 3);
N_cjik_new{3} = reshape(sum(E_ijk{3}), 4, 3);
N_cjik_new{4} = reshape(sum(E_ijk{4}), 4, 4);
N_cjik_new{5} = reshape(sum(E_ijk{5}), 4, 5);
N_cjik_new{6} = reshape(sum(E_ijk{6}), 4, 4);

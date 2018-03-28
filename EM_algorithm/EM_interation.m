function [ N_cj_new, N_cjik_new, Q_theta ] = EM_interation( p_y, theta_xi, tr_data )
% p(c_l = j | D_l, theta') = p(c_l = j, D_l, theta')/sum(p(c_l = 1-j, D_l, theta'))
% d1 = tr_data(1,:); %[k_x1, k_x2, ..., k_x6]
k_max = [5,3,3,4,5,4];
N = size(tr_data,1);
%% Nc=j
E_cj_Dsthata = [];
E_ijk = cell(1,6); %{xi} = [n of data point, # of c different classes, # of values xi can take]
E_ijk{1} = cat(3, zeros(N, 4), zeros(N, 4),zeros(N, 4),zeros(N, 4),zeros(N, 4));
E_ijk{2} = cat(3, zeros(N, 4), zeros(N, 4),zeros(N, 4));
E_ijk{3} = cat(3, zeros(N, 4), zeros(N, 4),zeros(N, 4));
E_ijk{4} = cat(3, zeros(N, 4), zeros(N, 4),zeros(N, 4),zeros(N, 4));
E_ijk{5} = cat(3, zeros(N, 4), zeros(N, 4),zeros(N, 4),zeros(N, 4),zeros(N, 4));
E_ijk{6} = cat(3, zeros(N, 4), zeros(N, 4),zeros(N, 4),zeros(N, 4));

%% loop over data points
p_cj_Dsthata = [];
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
    c_theta_xid1 = [c1_theta_xid1; c2_theta_xid1; c3_theta_xid1; c4_theta_xid1];
    % Ej
    all_cj = [p_y(1)*prod(c1_theta_xid1), p_y(2)*prod(c2_theta_xid1), p_y(3)*prod(c3_theta_xid1), p_y(1)*prod(c4_theta_xid1)];
    sump_cj = sum(all_cj);
    p_c1_dthata = p_y(1)*prod(c1_theta_xid1)/sump_cj;
    p_c2_dthata = p_y(2)*prod(c2_theta_xid1)/sump_cj;
    p_c3_dthata = p_y(3)*prod(c3_theta_xid1)/sump_cj;
    p_c4_dthata = p_y(4)*prod(c4_theta_xid1)/sump_cj;
    p_cj_dthata = [p_c1_dthata, p_c2_dthata, p_c3_dthata, p_c4_dthata];
    % Ej
    E_cj_Dsthata = [E_cj_Dsthata; p_cj_dthata];
    
    %second half
    for d_xi = 1:size(d1,2) %d_xi = 1,2,3,4,5,6 as index of x dimension
        k_xi = d1(1, d_xi); %k_xi = d1(1), d1(2), d1(3), d1(4), d1(5), d1(6)
        for ki_xi = 1:k_max(d_xi) %loop over values x can take
            if k_xi == ki_xi
                e_ijk = p_cj_dthata;
                E_ijk{d_xi}(l,:,ki_xi) = e_ijk;
            elseif k_xi == 0 %x_dxi = ki_xi  
                rest = 1:k_max(d_xi);
                rest(ki_xi) = [];
                p_k_cdA = p_y.* c_theta_xid1(:, ki_xi)' .* prod(c_theta_xid1(:, rest),2)';
                p_k_cdB1 = [];
                for j = 1:k_max(d_xi)
                    j_rest = 1:k_max(d_xi);
                    j_rest(j) = [];
                    p_k_cdB1 = [p_k_cdB1 ; theta_xi{d_xi}(:, j)' .* prod(c_theta_xid1(:, j_rest),2)'];
                    %p_k_cd = (p_xk{d_xi}(ki_xi))*(all_cj)./((sum(p_xk{d_xi}))*(all_cj));
                    %p_k_cd = sum((p_xk{d_xi}(ki_xi))*(all_cj))/(sum(p_xk{d_xi}*(sump_cj)));
                    %p_k_cd = (p_xk{d_xi}(ki_xi))*(sump_cj)/(sum(p_xk{d_xi}*(sump_cj)));
                end
                p_k_cdB1 = sum(p_k_cdB1, 1);
                p_k_cdB = p_y.*p_k_cdB1;
                p_k_cd = p_k_cdA./p_k_cdB;
                e_ijk = p_cj_dthata.*p_k_cd;
                E_ijk{d_xi}(l,:,ki_xi) = e_ijk;
            else
                e_ijk = [0, 0, 0, 0];
                E_ijk{d_xi}(l,:,ki_xi) = e_ijk;
            end
            %append e_ijk
            %E_ijk{d_xi}(l,:,ki_xi) = e_ijk;
            %e_ijk_dxi = [e_ijk_dxi; e_ijk]
        end    
    end  
end


%%
N_cj = sum(E_cj_Dsthata);
N_cjik = cell(1,6);
%(num of hidden class, num of product catogry)
N_cjik{1} = reshape(sum(E_ijk{1}), 4, 5);
N_cjik{2} = reshape(sum(E_ijk{2}), 4, 3);
N_cjik{3} = reshape(sum(E_ijk{3}), 4, 3);
N_cjik{4} = reshape(sum(E_ijk{4}), 4, 4);
N_cjik{5} = reshape(sum(E_ijk{5}), 4, 5);
N_cjik{5}(N_cjik{5}==0)=1;
N_cjik{6} = reshape(sum(E_ijk{6}), 4, 4);
partA = sum(N_cj.* log(p_y));
partB = sum(sum(N_cjik{1}.*log(theta_xi{1}))) + sum(sum(N_cjik{2}.*log(theta_xi{2}))) + sum(sum(N_cjik{3}.*log(theta_xi{3}))) + sum(sum(N_cjik{4}.*log(theta_xi{4}))) + sum(sum(N_cjik{5}.*log(theta_xi{5}))) + sum(sum(N_cjik{6}.*log(theta_xi{6})));
Q_theta = partA + partB;

% M step
N_cj_new = N_cj/sum(N_cj);
N_cjik_new = cell(1,6);

N_cjik_new{1} = N_cjik{1}./repmat(sum(N_cjik{1},2),1,size(N_cjik{1},2));
N_cjik_new{2} = N_cjik{2}./repmat(sum(N_cjik{2},2),1,size(N_cjik{2},2));
N_cjik_new{3} = N_cjik{3}./repmat(sum(N_cjik{3},2),1,size(N_cjik{3},2));
N_cjik_new{4} = N_cjik{4}./repmat(sum(N_cjik{4},2),1,size(N_cjik{4},2));
N_cjik_new{5} = N_cjik{5}./repmat(sum(N_cjik{5},2),1,size(N_cjik{5},2));
N_cjik_new{6} = N_cjik{6}./repmat(sum(N_cjik{6},2),1,size(N_cjik{6},2));


end


%% read data 
load example.txt;
%example = [1, -1, 1, -1] %Fever, Paleness,Cough,HighWBCcount.
data = example;

%%
prediction = [];
for row=1:size(data,1)
    example = data(row,:);
    % fever
    if example(1) == 1
        para_f = [p_FT_PT, p_FT_PF];
    elseif example(1) == 0
        para_f = [p_FF_PT, p_FF_PF];
    else
        para_f = [1, 1];
    end

    % Paleness
    if example(2) == 1
        para_pale = [p_PalT_PT, p_PalT_PF];
    elseif example(2) == 0
        para_pale = [p_PalF_PT, p_PalF_PF];
    else
        para_pale = [1,1];
    end

    % Cough
    if example(3) == 1
        para_c = [p_CT_PT, p_CT_PF];
    elseif example(3) == 0
        para_c = [p_CF_PT, p_CF_PF];
    else
        para_c = [1, 1];
    end

    % HighWBCcount
    if example(4) == 1
        para_w = [p_WT_PT, p_WT_PF];
    elseif example(4) == 0
        para_w = [p_WF_PT, p_WF_PF];
    else
        para_w = [1, 1];
    end

    % final result for one example
    joint_all = p_pt * para_f(1) * para_pale(1) * para_c(1) * para_w(1);
    joint_condition = p_pt * para_f(1) * para_pale(1) * para_c(1) * para_w(1) + (1-p_pt) * para_f(2) * para_pale(2) * para_c(2) * para_w(2);
    P_PT_example = joint_all/joint_condition;
    
    % prediction result
    prediction = [prediction, P_PT_example];
end

%% results
prediction
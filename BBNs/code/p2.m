%%%% load the train and test data (both are normalized)
load pneumonia.tex;

%% learn para
p_pt = sum(pneumonia(:,5))/size(pneumonia,1);

% data_pt: pneumonia = T data subset
data_pt = pneumonia(pneumonia(:,5)==1,:);
% data_pf: pneumonia = F data subset
data_pf = pneumonia(pneumonia(:,5)==0,:);

%% fever
%P(Fever=T|Pneumonia = T)
p_FT_PT =  size(data_pt(data_pt(:,1)==1,:),1)/size(data_pt,1); 
%P(Fever=F|Pneumonia = T)
p_FF_PT = 1 - p_FT_PT;
%P(Fever=T|Pneumonia = F)
p_FT_PF =  size(data_pf(data_pf(:,1)==1,:),1)/size(data_pf,1); 
%P(Fever=F|Pneumonia = F)
p_FF_PF = 1 - p_FT_PF;

%% Paleness
%P(Palen=T|Pneumonia = T)
p_PalT_PT =  size(data_pt(data_pt(:,2)==1,:),1)/size(data_pt,1); 
%P(Palen=F|Pneumonia = T)
p_PalF_PT = 1 - p_PalT_PT;
%P(Palen=T|Pneumonia = F)
p_PalT_PF =  size(data_pf(data_pf(:,2)==1,:),1)/size(data_pf,1); 
%P(Palen=F|Pneumonia = F)
p_PalF_PF = 1 - p_PalT_PF;
load pima.txt;
m = size(pima, 2)
pima_ones_ind = pima(:,m)== 1;
pima_ones = pima(pima_ones_ind,:);

pima_zeros_ind = pima(:,m)== 0;
pima_zeros = pima(pima_zeros_ind,:);

histogram_analysis(pima_ones(:,2))
histogram_analysis(pima_zeros)



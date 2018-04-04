function [ auc_score ] = AUC_score( x, y )

[X,Y,T,AUC] = perfcurve(y,x,0);
auc_score = AUC;

end


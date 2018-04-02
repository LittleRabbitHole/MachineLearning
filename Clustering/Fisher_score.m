function [ fisher_score ] = Fisher_score( x, y )

new_d = [x, y];
group1 = new_d(new_d(:,2)==1);
group0 = new_d(new_d(:,2)==0);
fisher_score = (mean(group1) - mean(group0))^2/((std(group1))^2 + (std(group0))^2);

end


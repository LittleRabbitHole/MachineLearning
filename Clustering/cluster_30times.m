function [ clusterID, bestID, MinDist] = cluster_30times( data, ite, Name, Value)
n = ite;
cluster = cell(1,30);
group_size = [];
measures = [];
while n>1
    n = n-1;
    [idx,C,sumd] = kmeans(data,2, Name,Value); 
    cluster{n} = idx;
    ngroup1 = size(idx(idx==1),1);
    ngroup2 = size(idx(idx==2),1);
    group_size = [group_size; [ngroup1, ngroup2]];
    sum = sumd(1) + sumd(2);
    measures = [measures; sum];
end
bestID = find(measures == min(measures(:)));
MinDist = min(measures(:));
clusterID = cluster{bestID};
end


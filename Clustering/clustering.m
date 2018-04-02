%% prob 1
data = [0, 0; 0,5; 6,7; 7,0];
sz=50;
scatter(data(:,1),data(:,2), sz, 'filled')

%% part a
g1_mean = data(1,:);
g2_mean = data(4,:);

%(0,5)
v1a = data(2,:) - g1_mean;
dis1a = sqrt(v1a*v1a'); %5

v2a = data(2,:) - g2_mean;
dis2a = sqrt(v2a*v2a'); %8.60

%(6,7)
v1b = data(3,:) - g1_mean;
dis1b = sqrt(v1b*v1b'); %9.22

v2b = data(3,:) - g2_mean;
dis2b = sqrt(v2b*v2b'); %7.07

%% part b
g1_mean = [3,3];
g2_mean = [7,0];

%(0,0)
v1a = data(1,:) - g1_mean;
dis1a = sqrt(v1a*v1a'); %4.24

v1b = data(1,:) - g2_mean;
dis1b = sqrt(v1b*v1b'); %7

%(0,5)
v2a = data(2,:) - g1_mean;
dis2a = sqrt(v2a*v2a'); %3.61

v2b = data(2,:) - g2_mean;
dis2b = sqrt(v2b*v2b'); %8.60

%(6,7)
v3a = data(3,:) - g1_mean;
dis3a = sqrt(v3a*v3a'); %5

v3b = data(3,:) - g2_mean;
dis3b = sqrt(v3b*v3b'); %7.07

%(7,0)

%% prob 2
load clustering_data.txt
data = clustering_data;

%% part a
n=31;
cluster = cell(1,30);
group_size = [];
measures = [];
while n>1
    n = n-1
    [idx,C,sumd] = kmeans(data,2); 
    cluster{n} = idx;
    ngroup1 = size(idx(idx==1),1);
    ngroup2 = size(idx(idx==2),1);
    group_size = [group_size; [ngroup1, ngroup2]];
    sum = sumd(1) + sumd(2)
    measures = [measures; sum];
end

group_size
find(measures == min(measures(:))) %14
clusterID = cluster{14};

%% part b
% using 'Start' = 'cluster' as initilization points method
[ cluster, bestID, MinDist] = cluster_30times( data, 31, 'Start','cluster')
MinDist
bestID
%cluster;

%% part b 1000 times competitions
m=100;
min_dists = [];
while m > 0
   m = m-1;
   [ cluster1, bestID_1, MinDist_1] = cluster_30times( data, 31, 'Start', 'plus');
   [ cluster2, bestID_2, MinDist_2] = cluster_30times( data, 31, 'Start', 'cluster');
   min_dists = [min_dists; [MinDist_1, MinDist_2]];
end    

%% t test for two means
[h,p] = ttest(min_dists(:,1),min_dists(:,2))
%no significant different
% p = 0.4253

%% part c
load class_labels.txt
%cluster
ngroup1 = size(clusterID(clusterID==1),1);
ngroup2 = size(clusterID(clusterID==2),1);
if ngroup1 >= ngroup2
    clusterID(clusterID==1) = 0;
    clusterID(clusterID==2) = 1;
else
    clusterID(clusterID==2) = 0;
    clusterID(clusterID==1) = 1;
end

crosstab(clusterID, class_labels)

%% prob 3
load Data.txt
data = Data;

scores = [];
for i = 1:70
    x = data(:,i);
    y = data(:, 71);
    fs = Fisher_score(x,y);
    scores(i) = fs;
end

[val ind] = sort(scores,'descend');
ind(1:20)
val(1:20)

%% AUC score

AUC_scores = [];
for i = 1:70
    x = data(:,i);
    y = data(:, 71);
    [X,Y,T,AUC] = perfcurve(y,x,0);
    AUC_scores(i) = AUC;
end

[val ind] = sort(AUC_scores,'descend');
ind(1:20)
val(1:20)


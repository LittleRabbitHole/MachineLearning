%% prob 1
load mean_study_data.txt
data = mean_study_data;

% part 1
m = mean(data)
stand_dev = std(data)

% part 2, 3, 4
% 1000 subsamples size = 25
means = [];
for i =  1:1000
    newdata = subsample( data, 25);
    means = [means, mean(newdata)];
end
hist(means, 20)
title('Histogram of 1000 mean values, k=25')
mean(means)
std(means)

%part 5
% 1000 subsamples size = 40
means_40 = [];
for i =  1:1000
    newdata = subsample( data, 40);
    means_40 = [means_40, mean(newdata)];
end
hist(means_40, 20)
title('Histogram of 1000 mean values, k=40')
mean(means_40)
std(means_40)

% part 6
sample25 = data(1:25);
mean(sample25)
[h,p,ci,stats] = ttest(sample25)

%% prob 2
load resampling_data.txt
data = resampling_data;
[data_train, data_test] = kfold_crossvalidation( data, 10,1 );

% part 2
mean_tests = [];
std_tests = [];
for m =  1:10
    [data_train, data_test] = kfold_crossvalidation( data, 10,m );
    test_mean = mean(data_test);
    test_std = std(data_test);
    mean_tests= [mean_tests, test_mean];
    std_tests = [std_tests, test_std];
end
mean(mean_tests)
std(std_tests)

%% prob 4
load coint.txt
data = coint;
% part a
ML_mu = sum(data)/100

% part b
% prior 
X = 0:.01:1;
prior_y = betapdf(X,1,1);
% posterior
posterior_y = betapdf(X,1+sum(data),1+(100-sum(data)));

figure
plot(X,prior_y,'Color','r','LineWidth',2)
hold on
plot(X,posterior_y,'LineStyle','-.','Color','b','LineWidth',2)
legend({'prior','posterior'},'Location','NorthEast');
hold off

% part c
Y_MAP = betapdf(0.65,1+sum(data),1+(100-sum(data)))

x=0.65;
y = Y_MAP;

figure
plot(X,posterior_y,'LineStyle','-.','Color','b','LineWidth',2)
hold on
plot(x,y,'r*','MarkerSize',10);
legend('posterior','Location','NorthEast');
hold off

% part d
% prior 
X = 0:.01:1;
prior_y = betapdf(X,4,2);
% posterior
posterior_y = betapdf(X,4+sum(data),2+(100-sum(data)));

figure
plot(X,prior_y,'Color','r','LineWidth',2)
hold on
plot(X,posterior_y,'LineStyle','-.','Color','b','LineWidth',2)
legend({'prior','posterior'},'Location','NorthEast');
hold off

Y_MAP = betapdf(0.6538,4+sum(data),2+(100-sum(data)))

x=0.6538;
y = Y_MAP;

figure
plot(X,posterior_y,'LineStyle','-.','Color','b','LineWidth',2)
hold on
plot(x,y,'r*','MarkerSize',10);
legend('posterior','Location','NorthEast');
hold off



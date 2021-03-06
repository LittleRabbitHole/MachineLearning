%% Multivariate Gaussian
load gaussian.txt
x = gaussian.';
scatter(x(1,:), x(2,:))

%% ML estimation for Multivariate Gaussian 
mu = mean(x, 2)
M = repmat(mu, 1,size(x,2));
Sigma = (1/49)*(x-M)*(x-M).';

%% plot
x1 = -10:.5:10; x2 = 0:.5:15;
[X1,X2] = meshgrid(x1,x2);
F = mvnpdf([X1(:) X2(:)],mu.', Sigma);
F = reshape(F,length(x2),length(x1));
surf(x1,x2,F);
caxis([min(F(:))-.5*range(F(:)),max(F(:))]);
xlabel('x1'); ylabel('x2'); zlabel('Probability Density');

%% separate each measurement
d1 = x(1,:);
d2 = x(2,:);
mu_d1 = mean(d1);
mu_d2 = mean(d2);
Sigma_d1= (1/49)*sum((d1 - mu_d1).^2);
Sigma_d2= (1/49)*sum((d2 - mu_d2).^2);

%% which better? mutlivariate Gaussian model or two separate univariate Gaussian models
Prob_data = mvnpdf(gaussian, mu.', Sigma);

prob_estimation = 1;%1.9465e-89
for i = 1:size(Prob_data,1)
    prob_estimation = prob_estimation*Prob_data(i);
end

prob_x1 = normpdf(gaussian(:,1), mu_d1, Sigma_d1);
prob_x2 = normpdf(gaussian(:,2), mu_d2, Sigma_d2);
prob_x1x2 = prob_x1.*prob_x2;

prob_estimation_x1x2 = 1; %2.5148e-103
for i = 1:size(prob_x1x2,1)
    prob_estimation_x1x2 = prob_estimation_x1x2*prob_x1x2(i);
end

%% Poisson distribution
x = 0:20;
y_2 = poisspdf(x, 2);
plot(x, y_2)

y_6 = poisspdf(x, 6);
plot(x, y_6)

%% ML estimation for Poisson distribution
load poisson.txt
ML_lamda = (1/size(poisson,1))*sum(poisson)

x = 0:20;
y_ML = poisspdf(x, ML_lamda);
plot(x, y_ML)
title('ML estimation density function plot')

%% The conjugate prior for defining the Poisson distribution as Gamma distribution
x = 0:20;
a1=1; b1=2;
prior_y1 = gampdf(x,a,b);
plot(x, prior_y1)
title('Gamma prior plot: a=1, b=2')

a2=3; b2=5;
prior_y2 = gampdf(x,a2,b2);
plot(x, prior_y2)
title('Gamma prior plot: a=3, b=5')

%% posterior
x = 0:12;
a1=1; b1=2;
post_a1 = a1 + sum(poisson);
n = size(poisson,1);
post_b1 = b1/(n*b1 + 1);
post_y1 = gampdf(x, post_a1, post_b1);
plot(x, post_y1)
title('Gamma posterior plot of a=1, b=2')

a2=3; b2=5;
post_a2 = a2 + sum(poisson);
post_b2 = b2/(n*b2 + 1);
post_y2 = gampdf(x, post_a2, post_b2);
plot(x, post_y2)
title('Gamma posterior plot of a=3, b=5')

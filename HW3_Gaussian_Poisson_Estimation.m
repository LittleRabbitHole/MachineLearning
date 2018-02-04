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
mu_d1 = mean(d1)
mu_d2 = mean(d2)
Sigma_d1= (1/49)*sum((d1 - mu_d1).^2)
Sigma_d2= (1/49)*sum((d2 - mu_d2).^2)

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


clear; 
close all; 
clc

ds = datastore('house_prices_data_training_data (1).csv','TreatAsMissing','NA',.....
    'MissingValue',0,'ReadSize',25000);
data = read(ds);
x = data{:,4:21};
x = featureNormalize(x);

Corr_x = corr(x);

x_cov=cov(x);

%x = featureNormalize(x);

[U S V] =  svd(x_cov);

EigenValues = diag(S);

m = size(EigenValues,1);

for i=1:m
    k=i;
    alpha = 1-((sum(EigenValues(1:i,:)))/sum(EigenValues));
    if (alpha < 0.001)
        break;
    end
end
k;

R = U(:,1:k)'*x';
%R = U(1:k,:)'*x';

approximateDataOut = (U(1:k)*R)';

%error = (1/m)*sum((approximateDataOut)-(R));

R = R';
[m,n] = size(R);
theta = zeros(n,1);
Alpha = 0.01;
iteration =100;
y=data{:,3};
[theta, J]=gradientDescentMulti(R, y, theta, Alpha, iteration)
% after i did the gradientDescentMulti it didn't gave me an output!!

kmean(x)
%kmean(R)


%%
%max_iterations = 10;
%centroids = initCentroids(x, k);

%for i=1:max_iterations
%  indices = getClosestCentroids(x, centroids);
%  centroids = computeCentroids(x, indices, k);
%end

%%

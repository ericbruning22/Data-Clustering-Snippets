clc;
close all;
clear;
rng default; % For reproducibility
count = 0;
%get dataset
load fisheriris;
%get features we want
X = meas(:,3:4);
Y = zeros(150,1);
Y(1:50) = 3;
Y(51:100) = 2;
Y(101:150) = 1;

figure;
plot(X(:,1),X(:,2),'.');
plot(X(1:50,1),X(1:50,2),'g.','MarkerSize',12)
hold on
plot(X(51:100,1),X(51:100,2),'b.','MarkerSize',12)
plot(X(101:150,1),X(101:150,2),'r.','MarkerSize',12)
xlabel 'Sepal Length (cm)';
ylabel 'Sepal Width (cm)'; 
legend('Setosa','Vesircolor','Virginica',...
       'Location','NW')
title 'Original Fisher Iris Data';

%kmedoids
opts = statset('Display','final');
[idx,C] = kmedoids(X,3,...
    'Replicates',10,'Options',opts);

%plot results
figure;
%plot data
plot(X(idx==1,1),X(idx==1,2),'r.','MarkerSize',12)
hold on
plot(X(idx==2,1),X(idx==2,2),'b.','MarkerSize',12)
plot(X(idx==3,1),X(idx==3,2),'g.','MarkerSize',12)
plot(C(:,1),C(:,2),'kx',...
     'MarkerSize',15,'LineWidth',3) 
%x and y labels
xlabel 'Petal Lengths (cm)';
ylabel 'Petal Widths (cm)'; 
%legend
legend('Cluster 1','Cluster 2','Cluster3','Centroids',...
       'Location','NW')
%title
title 'K-Medoids Clustering'
hold off

%calcuate error
err = immse(Y,idx);

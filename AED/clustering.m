%% 1.a) CARGAMOS DATOS DEL PROBLEMA:
clc; close all; clear all;
addpath('D:/');
load data.mat
x = predictors(916,:);
x_r_i = response(916);
%% 1.b) Num Clusters
% E1 =evalclusters(predictors,'kmeans','DaviesBouldin','klist',[1:6]);
%% 2.a) Kmeans cluster
K = 4;
X = predictors;
%[idx,C] = kmeans(predictors,K,'Replicates',5);
%     ,'Options',opts);
opts = statset('Display','final');
[idx,C] = kmeans(predictors,K,'Distance','cityblock','Replicates',100,'Options',opts);
%% Plot a clustered results:
response_num = str2num(response);
subplot(2,1,1), hist(response_num,4), title('Ideal response'), ylabel('Nº Patrones'),xlabel('Cluster');
subplot(2,1,2), hist(idx,4),title('K-Means resoponse'), ylabel('NºPatrones'),xlabel('Cluster');





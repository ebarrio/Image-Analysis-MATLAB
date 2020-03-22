% Eladio Barrio Querol, Ivan Valcarcel Bustos

clear all; clc; close all

%% Load the data

load data.mat

%% Records and features

[Nrecords,Nfeatures]=size(predictors)
%predictors
age=predictors(:,1);
Node_stage=predictors(:,2); 
Histology=predictors(:,3);
Node_ratio=predictors(:,4);
Pathological_size=predictors(:,5);
Oestrogen=predictors(:,6);

%If we need how many cases are for the different variables we can do the crosstab
%with the response

cross_age=crosstab(age,response);
heatmap(cross_age)
%crosstab(Oestrogen,response)

%% Missing values
[row,column]=find(isnan(predictors)); %NotANumber

% Records that contain a NaN
predictors(row,:)

%We can confirm that does not exist any NaN on the data, so we don't need
%to imputate or remove.

%% Search of atypical data.

age=predictors(:,1);
Node_stage=predictors(:,2); 
Histology=predictors(:,3);
Node_ratio=predictors(:,4);
Pathological_size=predictors(:,5);
Oestrogen=predictors(:,6);

%Zage=abs(age-mean(age))/std(age); % Normalization of feature 'age'
Zpredictors=abs(predictors-mean(predictors))./std(predictors); % This normalizes all the data (take into account that it is pointless for qualitative features: gender, smoker)


std1=numel(find(Zpredictors>1)) % # cases with values further than one standard deviation from the mean value (normal values), number of elements
std2=numel(find(Zpredictors>2)) % # cases with values further than two standard deviations from the mean value (interesting values, likely to be very informative)
std3=numel(find(Zpredictors>3)) % # cases with values further than three standard deviations from the mean value (oftentimes considered as outliers)

% If we want to remove a record (e.g., an outlier) -> []. Ex:
% data(1,:)=[] % it removes row 1. 
%In our case, we do not have any outlier.

%% CLUSTERING.

%K-Means-> Calculates the euclidean distance. The drawback of this
%technique of clustering is that you need the number of clusters.

%We know that the number of clusters is 3, but we can do this:

%E=evalclusters(predictors,'kmeans','DaviesBouldin','klist',[1:6])



%% Fuzzycm
Centres=ChooseInitialCentres(predictors,917);
[class,U,centres,error] = fuzzycm(predictors,3,1.5,Centres);
% With respect to the output arguments, "Class" produces the cluster labels and U is the fuzzy-membership matrix.
% When the syntaxis is [class,U,centres,error] =fuzzycm(Data,c,m,InitCentres), 
% it also gives "centres", that represents the cluster prototypes , and "error" which is a error measure of the match between records and cluster prototypes.


%% 1.a) CARGAMOS DATOS DEL PROBLEMA:
clc; close all; clear all;
addpath('D:/');
load .mat
%% 1.b) GENERACIÓN DEL MODELO 1:
M1 = fitctree(predictors,response,'OptimizeHyperparameters', 'auto');
disp('Tree ready');
%% 1.c) IMPORTANCIA DE LAS VARIABLES EN EL MODELO
imp1 = predictorImportance(M1);
figure;
bar(imp1);
title('Predcitor Importance Estimates'), ylabel('Estimates'), xlabel('Predictors');

%% 2.a) GENERACIÓN DEL MODELO 2:
rng(1);
M2 = fitctree(predictors,response,'CrossVal', 'on');
disp('Tree ready');
%% 2.b) VISUALIZACIÓN DEL ARBOL DE DECISIONES
view(M2.Trained{1},'Mode','graph')

%% 3.a) SEPARACIÓN CONJUNTOS DE ENTRENAMIENTO Y DE VALIDACIÓN
number_instances=length(predictors);
number_training_instances=round((2/3)*number_instances);
number_test_instances=number_instances-number_training_instances;
rand('state',0);random_index=randperm(number_instances);

training_data=predictors(random_index(1:number_training_instances),:);
training_response = response (random_index(1:number_training_instances));
validation_data=predictors(random_index(number_training_instances+1:number_instances),:);
validation_ideal_response = response(random_index(number_training_instances+1:number_instances));

%% 3.b) ENTRENAMIENTO CON LOS DATOS DE ENTRENAMIENTO
%M3 = fitctree(training_data,training_response,'CrossVal', 'on');
M3 = fitctree(training_data,training_response,'OptimizeHyperparameters', 'auto');
validation_get_response = predict(M3,validation_data);
VS = validation_ideal_response , validation_get_response;

%% 3.c) MATRIZ DE CONFUSIÓN
C = confusionmat(validation_ideal_response,validation_get_response);
confusionchart(C);

clc; close all; clear all;
%     1. Sepal length in cm
%     2. Sepal width in cm
%     3. Petal length in cm
%     4. Petal width in cm

% create table
mytable=array2table(meas,'variablenames',{'sp','sw','pl','pw'});
mytable.outcome=species;

% Drink some vino
load wine_dataset.mat
wineclass=wineTargets';
vino(wineclass(:,1)>0)=1;
vino(wineclass(:,2)>0)=2;
vino(wineclass(:,3)>0)=3;

wineTable=array2table(wineInputs');
wineTable.origin=categorical(vino');



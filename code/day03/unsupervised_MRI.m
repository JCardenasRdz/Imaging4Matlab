clear all; close all; clc;
%load
load ../../data/Su8686_Mouse_MRI_data.mat
%extract S2
Slice02=VTR(:,:,2:3:end);
%reshape into matrix form
Slice02_MatrixForm=reshape(Slice02,[],10);
% run Kmeans with two groups
K=2;
Index=kmeans(Slice02_MatrixForm(:,1:9:10),K);
% reshape and display index
imshow(reshape(Index,128,128),[]);
colormap(hsv(K));


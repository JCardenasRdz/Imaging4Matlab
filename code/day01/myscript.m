% clear screen and variables
clc;
clear all;

% load mri data
load mri.mat

% resize data
I=squeeze(D);

% make a subplot
figure(1);
subplot(2,2,1);
    imshow(I(:,:,10), [prctile(I(:),5) prctile(I(:),95)] ); 
    
subplot(2,2,2);
    imshow(I(:,:,16), [prctile(I(:),5) prctile(I(:),95)] ); 

subplot(2,2,3);
    imshow(I(:,:,20), [prctile(I(:),5) prctile(I(:),95)] ); 
    
 subplot(2,2,4);
    imshow(I(:,:,27), [prctile(I(:),5) prctile(I(:),95)] );    

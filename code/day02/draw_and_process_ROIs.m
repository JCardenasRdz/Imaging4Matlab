clear all; close all; clc;
load ../../data/Su8686_Mouse_MRI_data.mat

%%
imshow(VTR(:,:,end),[]);
tumor_binary_mask=roipolyold;
close;

%%
imshow(tumor_binary_mask,[])
I=VTR(:,:,end);

%% Repeat process for all slices

for image_number=1:30
 I=VTR(:,:,image_number);   
   all_voxels_in_ROI=I(tumor_binary_mask);
   average_signal(image_number)=mean(all_voxels_in_ROI);
   
end

% extract and normalize signal for slice 01
signal_for_slice_01=average_signal(1:3:end);
normalized_signal=signal_for_slice_01./max(signal_for_slice_01);

% define inline function
t1func=@(xdata,T1Rate) 1-exp(-xdata.*T1Rate);

%perform fitting
myT1fitting = fitnlm(Repetition_Time,normalized_signal,t1func,1/3);

























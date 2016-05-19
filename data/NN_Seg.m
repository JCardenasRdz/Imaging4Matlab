clear all; clc;
load Su8686_Mouse_MRI_data.mat

% Define ROI Tumor
S1=VTR(:,:,1:3:end);
subplot(131); imshow(max(S1,[],3),[]);colormap('jet'); tumormask=roipoly; 
subplot(132); imshow(max(S1,[],3),[]);colormap('parula'); tissuemask=roipoly; 
subplot(133); imshow(max(S1,[],3),[]); colormap('hot'); noisemask=roipoly; 
close all;

% Extract signal for each region
S1_matrix=reshape(S1,[],10);
Tumor_data=S1_matrix(tumormask,:);
Tissue_data=S1_matrix(tissuemask,:);
Noise_data=S1_matrix(noisemask,:);

% Allocate Group
G=[ones(length(Tumor_data),1); ones(length(Tissue_data),1).*2;...
    ones(length(Noise_data),1).*3 ];
G2=[G==1,G==2,G==3];

% Allocate Table
%TableSlice1=array2table([Tumor_data;Tissue_data;Noise_data]);
%TableSlice1.Target=categorical(G);

%% Construct Neural Net
% Create a Pattern Recognition Network

inputs=[Tumor_data;Tissue_data;Noise_data]';
targets=G2';

hiddenLayerSize = 10;
net = patternnet(hiddenLayerSize);

% Set up Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

% Train the Network
[net,tr] = train(net,inputs,targets);

% Test the Network
outputs = net(inputs);
errors = gsubtract(targets,outputs);
performance = perform(net,targets,outputs);

% View the Network
view(net)

% Plots
% Uncomment these lines to enable various plots.
close all;
figure, plotperform(tr)
 figure, plottrainstate(tr)
 figure, plotconfusion(targets,outputs)
 figure, ploterrhist(errors)

%% Apply network to Slice 02
S2_matrix=reshape(VTR(:,:,1:3:end),10,[]);
Predicted_Group=net.sim(S2_matrix);

%% Display output for each group
figure();
for q=1:3
    subplot(1,3,q);
    imshow(reshape(PRED(q,:),128,128),[0 1]); colormap('jet');
    title(num2str(q));
    colormap('jet');
end
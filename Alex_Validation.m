clc;
clear
close all;
imds = imageDatastore(fullfile('Test'),...
'IncludeSubfolders',true,'FileExtensions','.jpg','LabelSource','foldernames');
labelCount = countEachLabel(imds);
load AlexnetTransfer.mat
load inputSize.mat
imdsValidation = imds;
augimdsValidation = augmentedImageDatastore(inputSize(1:2),imdsValidation,'ColorPreprocessing','gray2rgb');
[YPred,scores] = classify(AlexnetTransfer,augimdsValidation);
YValidation = imdsValidation.Labels;
accuracy = mean(YPred == YValidation);
fprintf('Accuracy of the Alexnet is: %f', accuracy*100);
cfmatrix2(YValidation,YPred);
% Confusion matrix
plotconfusion(YValidation,YPred);
 title('Alexnet');


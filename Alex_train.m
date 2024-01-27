clc;
clear;
close all;
imds = imageDatastore(fullfile('Train'),...
'IncludeSubfolders',true,'FileExtensions','.jpg','LabelSource','foldernames');
labelCount = countEachLabel(imds);
imdsTrain = imds;
net = alexnet;
layersTransfer = net.Layers(1:end-3);
numClasses = numel(categories(imdsTrain.Labels));
layers = [
    layersTransfer
    fullyConnectedLayer(numClasses,'WeightLearnRateFactor',20,'BiasLearnRateFactor',20)
    softmaxLayer
    classificationLayer];
inputSize = net.Layers(1).InputSize;
save inputSize.mat inputSize;
augimdsTrain = augmentedImageDatastore(inputSize(1:2),imdsTrain,
'ColorPreprocessing','gray2rgb');
options = trainingOptions('sgdm', ...
    'MiniBatchSize',10, ...
    'MaxEpochs',50, ...
    'InitialLearnRate',1e-4, ...
    'Shuffle','every-epoch', ...
    'ValidationFrequency',50, ...
    'Verbose',false, ...
    'Plots','training-progress');
AlexnetTransfer = trainNetwork(augimdsTrain,layers,options);
save AlexnetTransfer.mat AlexnetTransfer;
imdsValidation = imds;
augimdsValidation = augmentedImageDatastore(inputSize(1:2),imdsValidation,
'ColorPreprocessing','gray2rgb');
[YPred,scores] = classify(AlexnetTransfer,augimdsValidation);
YValidation = imdsValidation.Labels;
accuracy = mean(YPred == YValidation);
fprintf('Accuracy of the Alexnet is: %f', accuracy*100);
 %Confusion matrix
 plotconfusion(YValidation,YPred);
 title('Alexnet');

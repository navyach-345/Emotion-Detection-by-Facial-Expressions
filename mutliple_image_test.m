clc;
clear;
close all;
close all hidden;

load AlexnetTransfer.mat
load inputSize.mat

folder = 'Test Expressions';
imds = imageDatastore(fullfile(folder),...
'IncludeSubfolders',true,'FileExtensions','.jpg','LabelSource','foldernames');
labelCount = countEachLabel(imds);
lab = char(labelCount.Label);
[p q] = size(lab);


for i = 1:p
    label = char(labelCount.Label(i));
    subFolder = [label '\'];
    filenames = dir(fullfile(subFolder, '*.jpg'));
    total_images = numel(filenames); 
   
    
    for k = 1:total_images
        I = filenames(k).name;
        fname = [subFolder  I];
        im = imread(fname);
        
        imValidation = augmentedImageDatastore(inputSize(1:2),im, 'ColorPreprocessing','gray2rgb');

        predictedLabels = classify(AlexnetTransfer,imValidation)';

        pred = char(predictedLabels);

        switch pred
            case "anger"
            str = "Anger";
            figure,imshow(im);title(str);
            msgbox("Anger");
        case "disgust"
            str = "Disgust";
            figure,imshow(im);title(str);
            msgbox("Disgust");
        case "happiness"
            str = "Happiness";
            figure,imshow(im);title(str);
            msgbox("Happiness");
        case "neutral"
            str = "Neutral";
            figure,imshow(im);title(str);
            msgbox("Neutral")
        case "sadness"
            str = "Sadness";
            figure,imshow(im);title(str);
            msgbox("Sadness");
        case "surprise"
            str = "Surprise";
            figure,imshow(im);title(str);
            msgbox("Surprise");
        otherwise
            print('In correct image provided');
        end
            
    end
end

final = 1;
        






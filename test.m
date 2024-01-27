clc;
clear;
close all;


load AlexnetTransfer.mat
load inputSize.mat

[filename pathname] = uigetfile('.jpg', 'Select image');
im = imread([pathname filename]);
%imshow(im);title(pred);

%figure, imshow(im);title('Input Image');
 

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
        print('Incorrect image provided');
end
        

final = 1;
        
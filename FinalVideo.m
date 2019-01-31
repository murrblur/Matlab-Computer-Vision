% David Murray. University of Oklahoma: Computer Vision, 2019.
%% Live face recognition via webcam.
clear
load('C:\Users\Dave\Desktop\Computer Vision\Final Project\bag.mat','bag','training_set','test_set');
load('C:\Users\Dave\Desktop\Computer Vision\Final Project\trainedFacesModel2NamesCompact.mat','trainedFacesModel2NamesCompact');
load('C:\Users\Dave\Desktop\Computer Vision\Final Project\trainedFaceModel2Names.mat','trainedFaceModel2Names');

% MODEL: COMPACT - SVM Quadratic
% Trained Model Stats:
% PCA disabled.

faceDetector = vision.CascadeObjectDetector('UpperBody');
faceDetector.MergeThreshold = 7;
cam = webcam();
% Capture one frame to get its size.
videoFrame = snapshot(cam);
frameSize = size(videoFrame);

% Create the video player object.
videoPlayer = vision.VideoPlayer('Position', [500 500 [frameSize(2), frameSize(1)]+30]);

runLoop = true;
numPts = 0;
frameCount = 0;
train_name = cellstr(char('none'));
while runLoop && frameCount < 4000
    featureVector = [];
    videoFrame = snapshot(cam);
    videoFrameGray = rgb2gray(videoFrame);
    frameCount = frameCount + 1;
    bbox = step(faceDetector, videoFrame);
    bbox_minSize = 200;
    step(videoPlayer, videoFrame);
    if (~isempty(bbox) && (any(bbox(3:4) > bbox_minSize)))
        featureVector10 = double(encode(bag,videoFrame));  % bag of features
        featureVector20 = double(encode(bag,bbox));
        featureVector30 = double(encode(bag,videoFrameGray));
       
        featureVector1 = array2table(featureVector10,'VariableNames',trainedFaceModel2Names.RequiredVariables);
        featureVector2 = array2table(featureVector20,'VariableNames',trainedFaceModel2Names.RequiredVariables);
        featureVector3 = array2table(featureVector30,'VariableNames',trainedFaceModel2Names.RequiredVariables);
        cellTable = array2table(train_name,'VariableNames',{'person'});
        featureVector1Final = horzcat(featureVector1,cellTable);

        %featureVector1Final = array2table(featureVector1Final,'RowNames');
        bestGuess1 = trainedFaceModel2Names.predictFcn(featureVector1)
        bestGuess2 = trainedFaceModel2Names.predictFcn(featureVector2)
        bestGuess3 = trainedFaceModel2Names.predictFcn(featureVector3)
        if (train_name == bestGuess1)
            step(videoPlayer, videoFrame);
            % we need at least 2 inputs for the retraining classifier
            % function: trainClassifierFinal
            secondfeature = double(encode(bag,videoFrame));  % bag of features
            featureVector4 = array2table(secondfeature,'VariableNames',trainedFaceModel2Names.RequiredVariables);
            featureVector4 = horzcat(featureVector4,cellTable);
            featureVector1Final = vertcat(featureVector1Final,featureVector4);
            [trainedFaceModel2Names, validationAccuracy] = trainClassifierFinal(featureVector1Final);
        end
        
        label = ['Best Guess:',char(bestGuess1)];
        videoFrame = insertObjectAnnotation(videoFrame, 'rectangle', bbox, label);
    end
    step(videoPlayer, videoFrame);
    runLoop = isOpen(videoPlayer);
end

% Clean up.
clear cam;
release(videoPlayer);
release(faceDetector);


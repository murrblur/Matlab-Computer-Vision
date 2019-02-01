% David Murray. University of Oklahoma: Computer Vision, 2019.
%% Live face recognition via webcam. 
clear
load('C:\Users\Dave\Desktop\Computer Vision\Final Project\trainedModelColors.mat','trainedModelColors');
load('C:\Users\Dave\Desktop\Computer Vision\Final Project\trainedModelColorsCompact.mat','trainedModelColorsCompact');

%load('C:\Users\Dave\Desktop\Computer Vision\Final Project\bag.mat','bag')
%load('C:\Users\Dave\Desktop\Computer Vision\Final Project\trainedFaceModel3names.mat','trainedFaceModel3names');
faceDetector = vision.CascadeObjectDetector();
%faceDetector.MergeThreshold = 7;
cam = webcam();
% Capture one frame to get its size.
videoFrame = snapshot(cam);
frameSize = size(videoFrame);

% Create the video player object.
videoPlayer = vision.VideoPlayer('Position', [500 500 [frameSize(2), frameSize(1)]+30]);

runLoop = true;
numPts = 0;
frameCount = 0;
done = 0;
still_classifying = true;
while runLoop && frameCount < 1000
    featureVector = [];
    bestGuess = [];
    scores = [];
    videoFrame = snapshot(cam);
    videoFrameGray = rgb2gray(videoFrame);
    frameCount = frameCount + 1;
    bbox = step(faceDetector, videoFrame);
    bbox_minSize = 200;
    train_name = input('Who would you like to train the classifier for?');
    if (~isempty(bbox) && (any(bbox(3:4) > bbox_minSize)))
        featureVector = double(encode(bag,videoFrameGray));  % bag of features
        featureVector = array2table(featureVector,'VariableNames',trainedFaceModel3names.RequiredVariables);
        bestGuess = trainedFaceModel3names.predictFcn(featureVector);            
        [guess, scores] = predict(trainedFaceModel3names,featureVector);
        disp(scores);
        label = ['Best Guess:',char(bestGuess)];
        videoFrame = insertObjectAnnotation(videoFrame, 'rectangle', bbox, label);
        if isequal(bestGuess,train_name)
            if strcmp(train_name, 'Barrett')
                currentPath = 'C:\Users\Dave\Desktop\Computer Vision\Final Project\Face Detection\People_train\Barrett'
            end
            if strcmp(train_name, 'David')
                currentPath = 'C:\Users\Dave\Desktop\Computer Vision\Final Project\Face Detection\People_train\David'
            end
            if strcmp(train_name, 'Garrett')
                currentPath = 'C:\Users\Dave\Desktop\Computer Vision\Final Project\Face Detection\People_train\Garrett'
            end
            if strcmp(train_name, 'Talon')
                currentPath = 'C:\Users\Dave\Desktop\Computer Vision\Final Project\Face Detection\People_train\Talon'
            end
            for j = 1:10
                baseFileName = strcat(num2str(j),'train.png'); 
                filename = fullfile(currentPath, baseFileName);
                imwrite(videoFrame,filename); 
            end
        end
            
    end
    if strcmp(train_name, 'done')
        new_data = imageSet('C:\Users\Dave\Desktop\Computer Vision\Final Project\Face Detection\People_train\','recursive');
        bag_new = bagOfFeatures(new_data,'VocabularySize',250,...
            'PointSelection','Detector');
        imagefeatures = double(encode(bag_new,new_data));
        TrainData = array2table(imagefeatures);
        person = categorical(repelem({new_data.Description}', [new_data.Count], 1));
        TrainData.person = person;
        [trainedFaceModel3names, validationAccuracy] = trainClassifier(TrainData);
    end
    step(videoPlayer, videoFrame);
    runLoop = isOpen(videoPlayer);
end

% Clean up.
clear cam;
release(videoPlayer);
release(faceDetector);


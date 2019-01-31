% David Murray. University of Oklahoma: Computer Vision, 2019.
%% Live face recognition via webcam. 
clear

load('C:\Users\Dave\Desktop\Computer Vision\Final Project\trainedModelColors.mat','trainedModelColors');
load('C:\Users\Dave\Desktop\Computer Vision\Final Project\trainedModelColorsCompact.mat','trainedModelColorsCompact');

objectDetector = vision.CascadeObjectDetector();
% connect to IP camera
%url=('http://192.168.1.134:8020/videoView');
cam = webcam();
videoFrame = snapshot(cam);   % snapshot()
frameSize = size(videoFrame);
% Create the video player object.
videoPlayer = vision.VideoPlayer('Position', [500 500 [frameSize(2), frameSize(1)]+30]);

runLoop = true;
numPts = 0;
frameCount = 0;
while runLoop && frameCount < 3000
    videoFrame = snapshot(cam);
    videoFrameGray = rgb2gray(videoFrame);
    frameCount = frameCount + 1;
    bbox_minSize = 200;
    featureVector = ColorHist(videoFrame);
    [guess2, scores] = predict(trainedModelColorsCompact,featureVector)
    secondVector = array2table(secondVector);
    featureVector = array2table(featureVector,'VariableNames',trainedModelColors.RequiredVariables);
    bestGuess = trainedModelColors.predictFcn(featureVector);
    label = ['Best Guess:',char(bestGuess)]
    step(videoPlayer, videoFrame);
    runLoop = isOpen(videoPlayer);
end
% Clean up.
clear cam;
release(videoPlayer);
release(objectDetector);

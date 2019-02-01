%% Load photos and gather features via bag of words.
imset = imageSet('C:\Users\Dave\Desktop\Computer Vision\Final Project\Face Detection\people','recursive');
[training_set,test_set] = partition(imset,[0.8 0.2]);

bag = bagOfFeatures(training_set,'VocabularySize',250,...
    'PointSelection','Detector');
imagefeatures = double(encode(bag,training_set));
FaceData = array2table(imagefeatures);
person = categorical(repelem({training_set.Description}', [training_set.Count], 1));
FaceData.person = person; 

save('bag.mat','bag','training_set','test_set','FaceData'):

%% Test accuracy on test_set.

testfeatures = double(encode(bag,test_set));
testfeatures = array2table(testfeatures,'VariableNames',trainedFaceModel.RequiredVariables);
actualPerson = categorical(repelem({test_set.Description}', [test_set.Count], 1));

predictedOutcome = trainedFaceModel.predictFcn(testfeatures);

correctPredictions = (predictedOutcome == actualPerson);
validationAccuracy = sum(correctPredictions)/length(predictedOutcome) %#ok

%% Visualize how the classifier works

ii = randi(size(test_set,2));
jj = randi(test_set(ii).Count);
img = read(test_set(ii),jj);
imshow(img)

imagefeatures = double(encode(bag, img));
[bestGuess, score] = predict(trainedFaceModel.ClassificationSVM,imagefeatures);
if strcmp(char(bestGuess),test_set(ii).Description)
	titleColor = [0 0.8 0];
else
	titleColor = 'r';
end
title(sprintf('Best Guess: %s; Actual: %s',...
	char(bestGuess),test_set(ii).Description),...
	'color',titleColor)
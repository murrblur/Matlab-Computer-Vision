% load
load('C:\Users\Dave\Desktop\Computer Vision\Final Project\bag.mat','bag','training_set','test_set','FaceData');
CompactMdl = load('C:\Users\Dave\Desktop\Computer Vision\Final Project\trainedFacesModel2NamesCompact.mat');
load('C:\Users\Dave\Desktop\Computer Vision\Final Project\trainedFaceModel2Names.mat','trainedFacesModel2Names');

%% Test accuracy on test_set.
testfeatures = double(encode(bag,test_set));
testfeatures = array2table(testfeatures,'VariableNames',trainedFacesModel2Names.RequiredVariables);
actualPerson = categorical(repelem({test_set.Description}', [test_set.Count], 1));

predictedOutcome = trainedFaceModel2Names.predictFcn(testfeatures);

correctPredictions = (predictedOutcome == actualPerson);
validationAccuracy = sum(correctPredictions)/length(predictedOutcome) %#ok

%% Visualize how the classifier works

ii = randi(size(test_set,2));
jj = randi(test_set(ii).Count);
img = read(test_set(ii),jj);
imshow(img)

imagefeatures = double(encode(bag, img));
imagefeatures = table2array(imagefeatures);

[bestGuess, score] = predict(CompactMdl,imagefeatures);
if strcmp(char(bestGuess),test_set(ii).Description)
	titleColor = [0 0.8 0];
else
	titleColor = 'r';
end
title(sprintf('Best Guess: %s; Actual: %s',...
	char(bestGuess),test_set(ii).Description),...
	'color',titleColor)
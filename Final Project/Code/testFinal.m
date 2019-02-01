ii = randi(size(test_set,2));
jj = randi(test_set(ii).Count);
img = read(test_set(ii),jj);
imshow(img)

imagefeatures = double(encode(bag, img));
[bestGuess, score] = predict(trainedFacesModel2NamesCompact.ClassificationSVM,imagefeatures);
if strcmp(char(bestGuess),test_set(ii).Description)
	titleColor = [0 0.8 0];
else
	titleColor = 'r';
end
title(sprintf('Best Guess: %s; Actual: %s',...
	char(bestGuess),test_set(ii).Description),...
	'color',titleColor)
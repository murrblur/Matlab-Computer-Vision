%% DAVID MURRAY COMPUTER VISION 2019.

% Train Support Vector Machine (SVM) to recognize faces via classification
% learner application. 
% Trained SVM: trainedFaceModel
   
%% Load photos and gather features via bag of words.

imset = imageSet('C:\Users\Dave\Desktop\Computer Vision\Final Project\Face Detection\people','recursive');
path = ('C:\Users\Dave\Desktop\Computer Vision\Final Project\Face Detection\');
% new parent folder for resized images or manually People_resized directory inside Face Detection folder.
people_resized = mkdir(path,'people_resized');

for i = 1:size(imset,2)
    if (i == 1)
        currentPath = 'C:\Users\Dave\Desktop\Computer Vision\Final Project\Face Detection\People_resized\Barrett'
    end
    if (i == 2)
        currentPath = 'C:\Users\Dave\Desktop\Computer Vision\Final Project\Face Detection\People_resized\David'
    end
    if (i == 3)
        currentPath = 'C:\Users\Dave\Desktop\Computer Vision\Final Project\Face Detection\People_resized\Garrett'
    end
    if (i == 4)
        currentPath = 'C:\Users\Dave\Desktop\Computer Vision\Final Project\Face Detection\People_resized\Talon'
    end
    for j = 1:imset(i).Count
        img = read(imset(i),j);
        img_resized = imresize(img, [360 640]);
        baseFileName = strcat(num2str(j),'image.png'); % Whatever....
        filename = fullfile(currentPath, baseFileName);
        imwrite(img_resized,filename);    
    end
end

imset_resized = imageSet('C:\Users\Dave\Desktop\Computer Vision\Final Project\Face Detection\People_resized','recursive');
[training_set,test_test] = partition(imset,[0.95 0.05]);

bag = bagOfFeatures(training_set,'VocabularySize',250,...
    'PointSelection','Detector');

imagefeatures = double(encode(bag,training_set));
FaceData = array2table(imagefeatures);
person = categorical(repelem({training_set.Description}', [training_set.Count], 1));
FaceData.person = person;

save('bag.mat','bag','training_set','test_set','FaceData');

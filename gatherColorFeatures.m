imset = imageSet('C:\Users\Dave\Desktop\Computer Vision\Final Project\Color Detector\Objects','recursive');
Features = [];
for i = 1:size(imset,2)
    for j = 1:imset(i).Count
        img = read(imset(i),j);
        %img = imresize(img,[360 640]);
        colorFeatures = ColorHist(img);
        Features = vertcat(colorFeatures,Features);
    end

end

imageType = categorical(repelem({imset.Description}',[imset.Count], 1));
objects = array2table(Features);
objects.class = imageType;





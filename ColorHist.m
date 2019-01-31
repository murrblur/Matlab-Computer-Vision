function ColorFeatures = ColorHist(im)
   
ColorFeatures = [imhist(im(:,:,1),30)', imhist(im(:,:,2),30)', imhist(im(:,:,3),30)'];

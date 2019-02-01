Computer Vision
1. White balancing.  Average R G B color channels.
2. Hybrid composite of 2 images. LPF(image1) + HPF(image2) = composite.
3. Image Pyramid to combine halves of 2 images.  Image mask to blend images.
4. Histogram of Oriented Gradients (HOG).  
5. Panorama.  Stitch two images.  Find matching features, estimate homography with RANSAC, projective transformation of image1. 
              Composite = stitch(image1Transformed, image2).
Final Project: Use quality data.  The classificationLearner app will train accurate models with quality data, but it is important to check the confusion matrix and Region of Convergence to find the best model.

Move 'input' of FaceRecognizer_Live outside while loop.  Train one person, close the video and train the next person.  Take more than 2 frames to train.

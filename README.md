Computer Vision
1. White balancing.  Average R G B color channels.
2. Hybrid composite of 2 images. LPF(image1) + HPF(image2) = composite.
3. Image Pyramid to combine halves of 2 images.  Image mask to blend images.
4. Histogram of Oriented Gradients (HOG).  
5. Panorama.  Stitch two images.  Find matching features, estimate homography with RANSAC, projective transformation of image1. 
              Composite = stitch(image1Transformed, image2).

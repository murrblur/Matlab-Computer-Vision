addpath('C:\Users\Dave\Desktop\Computer Vision\Project 5');
imnames={'IMAG4688.jpg','IMAG4689.jpg'};

I1=imread(imnames{1});
I2=imread(imnames{2});
I1_gray = rgb2gray(I1);
I2_gray = rgb2gray(I2);

% Find row and column locations of corner points in images
[r1, c1, r2, c2] = detect_features(I1_gray, I2_gray);
% corner1 = corner(I1_gray,'harris');
% r1 = corner1(:,1);
% c1 = corner1(:,2);
% corner2 = corner(I2_gray,'harris');
% r2 = corner2(:,1);
% c2 = corner2(:,2);

% Create feature descriptions for each point.  Find corner points in the
% 'neighborhood' radius of each point.
numMatches = 150;
neighborhoodRadius = 20; 
featDescriptions_1 = describe_features(I1_gray, neighborhoodRadius, r1, c1);
featDescriptions_2 = describe_features(I2_gray, neighborhoodRadius, r2, c2);

distances = pdist2(featDescriptions_1, featDescriptions_2);
[~,distance_idx] = sort(distances(:), 'ascend');
BestMatches = distance_idx(1:numMatches);
[~,distance_idx] = sort(distances(:), 'ascend');
[img1_matchedFeature, img2_matchedFeature] = ind2sub(size(distances),BestMatches);

match_r1 = r1(img1_matchedFeature);
match_c1 = c1(img1_matchedFeature);
match_r2 = r2(img2_matchedFeature);
match_c2 = c2(img2_matchedFeature);
% refined lists of matching points in both pictures
xy1 = [match_c1, match_r1, ones(numMatches,1)]';
xy2 = [match_c2, match_r2, ones(numMatches,1)]';
xx = affine_fit(xy1,xy2);
%figure(1)
%visualize_match(xy1,xy2,I1,I2);
%title('Matching Points without RANSAC')

xy1 = xy1';
xy2 = xy2';
% RANSAC
[H, inlierIndices] = estimate_homography(xy1,xy2);
numMatches = length(inlierIndices);
match_c1_H = match_c1(inlierIndices);
match_c2_H = match_c2(inlierIndices);
match_r1_H = match_r1(inlierIndices);
match_r2_H = match_r2(inlierIndices);
% New Matching Points
xy3 = [match_c1_H, match_r1_H, ones(numMatches,1)]';
xy4 = [match_c2_H, match_r2_H, ones(numMatches,1)]';
xx_ransac = affine_fit(xy3,xy4);
%figure(2)
%visualize_match(xy3,xy4,I1,I2);
%title('Matching Points with RANSAC')

%T = maketform('projective',xx_ransac);
T = projective2d(H);
img1Transformed = imwarp(I1,T);

figure(3)
compositeImg1 = stitch(img1Transformed,I2,H);
imshow(compositeImg1);
title('Projective Transform')

%figure(4)
%[wholeImg,NewImage,offsets]=draw_align_image(H,img1Transformed,I2);
save('DAVID_MURRAY_Project5');

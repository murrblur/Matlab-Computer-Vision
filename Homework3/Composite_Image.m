addpath('C:\Users\Dave\Desktop\Computer Vision\Project 3\');
addpath('C:\Users\Dave\Desktop\Computer Vision\Final Project\Presentation');
%%image0 = input(prompt1);
image1 = imread('bradd_pitt.png');
%%image02 = input(prompt2);
image2 = imread('IMG_0946.jpg');
[M N ~] = size(image1);
image2 = imresize(image2, [M N]);
pyr_cat = zeros(1,4);
pyr_dog = zeros(1,4);
% gaussian pyramid: cat
%for pyr = 1:4
h = fspecial('Gaussian', [2 2], 10);  % image1 convolved with gauss kernel
gauss_cat_1 = imfilter(image1,h);
figure(1)
imshow(image1);

edge_cat = image1 - gauss_cat_1;
pyr_cat = impyramid(edge_cat,'reduce');
pyr_cat = impyramid(edge_cat,'reduce');
pyr_cat = impyramid(edge_cat,'reduce');

figure(2)
imshow(image2)
gauss_dog_1 = imfilter(image2,h);  % image2 convolved with gauss kernel
edge_dog = image2 - gauss_dog_1;
pyr_dog = impyramid(edge_dog,'reduce');
pyr_dog = impyramid(edge_dog,'reduce');
pyr_dog = impyramid(edge_dog,'reduce');
image2_reduce = impyramid(gauss_dog_1,'reduce');

image2_reduce = impyramid(gauss_dog_1,'reduce');
pyr_dog = image2_reduce + pyr_dog;

image1_reduce = impyramid(gauss_cat_1,'reduce');
image1_reduce = impyramid(gauss_cat_1,'reduce');
image1_reduce = impyramid(gauss_cat_1,'reduce');
cat_blend = pyr_cat + image1_reduce;
[M N ~] = size(cat_blend);
%image1_reduce = impyramid(image1_reduce,'reduce');

pyr_blend = horzcat(cat_blend(:,1:1:N/2,:),pyr_dog(:,N/2:1:N,:));
pyr_blend = impyramid(pyr_blend,'expand');
pyr_blend = impyramid(pyr_blend,'expand');
pyr_blend = impyramid(pyr_blend,'expand');
figure(3)
imshow(pyr_blend);




% DAVID MURRAY
% 113818946
% HOG - PROJECT 4

oimg=imread('C:\Users\Dave\Desktop\Computer Vision\Project 4\gantrycrane.png');
imgheight=256;
img=imresize(oimg,[imgheight,imgheight/size(oimg,1)*size(oimg,2)]);
[x y]=ndgrid(22:2:132,32:4:256);   %max_height 300px -- need square list = size(:,1)*dims
list=[x(:) y(:)];
size(img)
tic;
%data = load('gantrycrane_hog.mat');
h = hog(img,list,16);
toc; % compute hog at the locations in the list
visualize_hog_list(h,list,img);
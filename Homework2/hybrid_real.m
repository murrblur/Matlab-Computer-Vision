addpath('C:\Users\Dave\Desktop\Computer Vision\');

%%image0 = input(prompt1);
image1 = imread('cat.jpg');
%%image02 = input(prompt2);
image2 = imread('dog.jpg');
%cutoff_frequency = 0; %% 0.2hz$$$$$$$$$$$$$$
h_size = size('cat.jpg');
large_1d_blur_filter = fspecial('Gaussian', [3 3], 0.5);

figure(3)
imshow(image1);
figure(7)
imshow(image2);
% Remove the high frequencies from image1 by blurring it. 
low_frequencies = imfilter(image1, large_1d_blur_filter,'replicate','same');
low_frequencies = imfilter(low_frequencies, large_1d_blur_filter,'replicate','same'); 
figure(1)
imshow(low_frequencies);

% Remove the low frequencies from image2. 
low_frequencies2 = imfilter(image2, large_1d_blur_filter);
low_frequencies2 = imfilter(low_frequencies2, large_1d_blur_filter);
figure(2)
imshow(low_frequencies2);

high_frequencies = imsubtract(image1, low_frequencies2);

% Combine the high frequencies and low frequencies
hybrid_image = low_frequencies+low_frequencies2;
hybrid_image_2 = low_frequencies2+high_frequencies;

fused_image = imfuse(low_frequencies2,high_frequencies);
%fused_image = fused_image(1:2:end,1:2:end,:);
figure(4)
image(hybrid_image);
%%%%%%%%%%%%%%%%%%%%% Final Image %%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(5)
image(hybrid_image_2);
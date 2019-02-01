function [wholeImg,NewImage,offsets]=draw_align_image(xx,I1c,I2c)


[NewImage,offsets] = real_warp_image(I1c,xx);
wholeImg=zeros(size(NewImage));
size(NewImage)
size(wholeImg)
wholeImg((1:size(I2c,1))+offsets(2),(1:size(I2c,2))+offsets(1),:)=I2c;
%wholeImg = imresize(wholeImg,size(NewImage));
size(wholeImg)
S=sum(wholeImg,3);
mask=zeros(size(S));
mask(S>0)=mask(S>0)+1;
S=sum(NewImage,3);
mask(S>0)=mask(S>0)+1;
mask(mask==0)=1;
wholeImg=wholeImg+NewImage;
wholeImg=wholeImg./repmat(mask,[1,1,3]);

figure;
imshow(uint8(wholeImg)); 

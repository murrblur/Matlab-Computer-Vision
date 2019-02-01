function hog=visualize_hog_list(hog,list,I)
scaling_factor=0.3;
if exist('I','var')
    figure;
    imshow(I);
    w=size(I,1)/size(hog,1);
end
sum(hog,3)
hog=hog./repmat(sum(hog,3),[1,1,size(hog,3)]);
[x,y]=meshgrid(w*((1:size(hog,1))-0.5),w*((1:size(hog,2))-0.5));
%[x(:) y(:)] = list;
for angleid=1:size(hog,3)
    angle=(angleid-1)*2*pi/size(hog,1);
    nx=x+hog(:,:,angleid)'.*w*scaling_factor*sin(angle);
    ny=y+hog(:,:,angleid)'.*w*scaling_factor*cos(angle);
    h=line([y(:)';ny(:)'],[x(:)';nx(:)']);
    set(h,'color',[1 1 1]);
end
if exist('I','var')
    truesize(gcf,[256 256/size(I,1)*size(I,2)]);
end


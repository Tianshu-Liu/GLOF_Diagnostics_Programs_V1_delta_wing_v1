
function [I_masked,BW]=masking_image_region_fun(Im,NumPoints,value_background)


%Im=imread('PSP_sublimation_La_Sant.tif');

I=double(Im);

figure(1);
imagesc(I);
colormap(gray);
axis('image');
title('Image');

%NumPoints=4;
%value_background=100;

[xc,yc]=ginput(NumPoints);
c=round(xc);
r=round(yc);

BW = roipoly(I,c,r);
BW=double(BW);

I_masked=BW.*I+value_background*(ones(size(BW))-BW);

figure(2);
imagesc(I_masked);
axis image;
colormap(gray);
title('Masked Image');

















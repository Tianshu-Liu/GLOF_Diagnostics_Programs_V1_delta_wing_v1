function [xc,yc]=clicking_target_fun4Tracking(imag,No_targets,bk_size_0,ImagesNew)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% centroids by mouse selection
%
% Inputs:
%       (1) 'imag', image name after loading an image file 
%       (2) 'No_targets', total number of targets to be selected (clicked)
%       (3) 'bk_size_0', bolck size for initial searching a target (such as 10 pixels)
%
% Outputs:
%       [xc,yc], two-column array of target centroids in pixels
%
% Developed by Western Michigan University for NASA Langley Research Center
% Email: tianshu.liu@wmich.edu or aburner@cox.net to report bugs or suggest improvements
% Version date: August 28, 2006
% Primary author: Tianshu Liu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% open the file where the x, y data will be stored
Dummy = inputdlg('Name of the File Where the x,y Data will be Stored');
FileName=char(Dummy);
fname = fopen (FileName,'wt');
%[pathstr, name, ext, versn] = fileparts(FirstImage);

% convert rgb image to intensity image
if isrgb(imag)==1
    I=rgb2gray(imag);
elseif isgray(imag)==1
    I=imag;
end
                
% show image

imshow(I);
imag_size=size(I);
title(strcat('Click on','.. ', num2str(No_targets), ' Targets'));

% click targets and calculate their centroids by calling 'locating_target1_fun.m'
i=1;
while (i<=No_targets)
	[x_p,y_p]=ginput(1);
	row_p=round(y_p);
	col_p=round(x_p);

    [xc1_shifted,yc1_shifted]=locating_target1_fun(I,row_p,col_p,bk_size_0);%Function locates centroid of target
    
    xc(i)=xc1_shifted;
    yc(i)=yc1_shifted;
    
% superimpose the calculated centroids on targets    
  
	hold on;
	plot(round(xc(i)),round(yc(i)),'+r');
	i=i+1;  
end

dummy=[xc; yc];
fprintf(fname, '%10.5f %10.5f\n', dummy);%write to a file the centroid of the targets

[rows cols] = size(ImagesNew);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


for k=2:rows
    numfig=num2str(k);
    imag = imread(ImagesNew(k,:));
    I=imag;
    i=1;
    while (i<=No_targets)
        row_p=round(yc(i));
        col_p=round(xc(i));
        [xc1_shifted,yc1_shifted]=locating_target1_fun(I,row_p,col_p,bk_size_0);%Function locates centroid of target
        xc(i)=xc1_shifted;
        yc(i)=yc1_shifted;
        i=i+1;  
    end
    dummy=[xc; yc];
    fprintf(fname,'%10.5f %10.5f\n', dummy);%write to a file the centroid of the targets
end

fclose(fname);



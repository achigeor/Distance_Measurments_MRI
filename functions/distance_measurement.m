function [ dist  ] =distance_measurement ( image , measurement_type )

%  length_measurement Finds the requested distance, given the correct MRI image
%  image : Input image name, in string format
%  measurement_type : The name of distance you want to measure, in string 
%  format. Types = 'nose' or 'ear'
%
% Tested in R2013b and later

%% Read MRI Image
img= dicomread(image);
info = dicominfo(image);
imtool(img,[]);

%% Ask user for measuring points
switch measurement_type
    case 'nose'
        promt = 'Please examine the image, and enter the starting point of measurement (nose fiducial) in vector form [StartX StartY]: ';
        start_point = input(promt);
        start_point
        promt = 'Please examine the image, and enter the ending point of measurement (occipital bone fiducial) in vector form [EndX EndY]:  ';
        end_point = input(promt);
        end_point
    case 'ear'
        promt = 'Please examine the image, and enter the starting point of measurement (left ear fiducial) in vector form [StartX StartY]: ';
        start_point = input(promt);
        start_point
        promt = 'Please examine the image, and enter the ending point of measurement (right ear fiducial) in vector form [EndX EndY]:  ';
        end_point = input(promt);
        end_point
end
        

%% Image Segmentation
se = strel('disk',10);                            %create mask for morphological image closing
closed = imclose(img,se);                    %morphological image closing
bwclose = edge(closed);                      %find edges of the image using canny's method
bwclose = imclose(bwclose,se);         %2nd morpholigal image closing
bwclose = imfill(bwclose,'holes');          %fill holes, if any

%repeat above steps to ensure correct segmentation
se = strel('disk',20);                          
bwclose = imclose(bwclose,se);

outer_edge = bwperim(bwclose);       %find the outer edge of the given image

%% Measurement
pts = regionprops(outer_edge,'pixellist');
outer_edge_pixels = pts.PixelList;
%imtool(outer_edge);

dist = measure(outer_edge_pixels,start_point,end_point,measurement_type);
dist = (info.PixelSpacing*dist)/10;

switch measurement_type
    case 'nose'
        str = ['Nose to occipital bone distance accross scalp is: ',  num2str(dist(1)),  'cm' ];
        disp(str);
    case 'ear'
        str = ['Left to right ear distance accross scalp is: '  num2str(dist(1))  'cm' ];
        disp(str);
end

        
end


function [ perimeter ] = perimeter_measurement( img_ind )
%perimeter_measurement Finds the perimeter of the head,given a set of MRI images. 
%img_ind : Input images indexes, in vector form

% Tested in R2013b and later

img_ind = sort(img_ind);

%% Read MRI Images
for j = img_ind(1):img_ind(end)
    
    if j ~= img_ind
        continue
    end
    img= dicomread(['IM' num2str(j)]);
    info = dicominfo((['IM' num2str(j)]));

%% Image Segmentation
    se = strel('disk',10);                            %create mask for morphological image closing
    closed = imclose(img,se);                    %morphological image closing
    bwclose = edge(closed);                      %find edges of the image using canny's method
    bwclose = imclose(bwclose,se);         %2nd morpholigal image closing
    %bwclose = imclose(edge(img),se);       %to be checked 
    bwclose = imfill(bwclose,'holes');          %fill holes, if any

    %repeat above steps to ensure correct segmentation
    se = strel('disk',20);                          
    bwclose = imclose(bwclose,se);

    outer_edge = bwperim(bwclose);       %find the outer edge of the given image


%% Measurement
    pts = regionprops(outer_edge,'pixellist');
    outer_edge_pixels = pts.PixelList;
    %imtool(outer_edge);
    perimeter(j-(img_ind(1)-1)) = measure(outer_edge_pixels,[0 0],[0 0],'perimeter');
end

%% Find perimeter and display to user
perimeter = (info.PixelSpacing*perimeter)/10;
perimeter = max(perimeter(1,:));
disp(['Head perimeter of subject is: ' num2str(perimeter)  'cm']); 

end


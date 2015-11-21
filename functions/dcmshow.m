function [  ] = dcmshow( img_ind )
%dcmshow Simple function that displays a DICOM image
%   img_ind: Image index
%   Image names must be in the format: "IM#"

img_ind = sort(img_ind);

for j = img_ind(1):img_ind(end)
    if j ~= img_ind
        continue
    end
img= dicomread(['IM' num2str(j)]);
imtool(img,[]);

end
end


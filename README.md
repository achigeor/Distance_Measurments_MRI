# Distance_Measurments_MRI

================================================================

To measure distance across the scalp use the distance_measurement(image, measurement_type)function. 
Inputs are the name of the image, and the measurement type(nose or ear) both in string format. Output is the distance in cm.

To measure the perimeter of a subjects head, use the perimeter_measurement(img_ind) function.
Inputs are the indexes of MRI DICOM images(in vector form) the user wants to use for finding the perimeter. Output is the maximum perimeter calculated from given images.


The user can view a DICOM image, or a set of DICOM images, using the dcmshow(img_ind) function. Inputs are the indexes of MRI DICOM images(in vector form).

================================================================

In order to use the functions from any folder, the user should add the folder to MATLAB PATH.

STEPS

1)Extract the .zip to a folder of your choice.

2)Get the full path to to the functions folder e.g:          
C:\path\to\folder\functions

3)Open MATLAB and add the path to MATLAB PATH with command                          addpath('C:\path\to\folder\functions');

4)Go to a folder with MRI images, and use the function you wish

================================================================

All functions have been tested in R2013b and R2015a versions.

================================================================

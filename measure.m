function [ sum ] = measure(t, startp, endp ,measurement_type)
%measure Measures length of user defined arc, in pixels
%   t: Pixel List
%   startp: Starting point [StartX StartY], use 0 vector for perimeter
%   endp: Ending point [EndX EndY], use 0 vector for perimeter
%
% Tested in R2013b and later


%% Initialization 
if strcmp(measurement_type,'nose') || strcmp(measurement_type,'ear')
    startx = startp(1);
    starty = startp(2);
    endx = endp(1);
    endy = endp(2);
    row1 = find ((t(:,2) == starty));                 %find rows that include starty
    dist = t(row1,1)-startx;
    [minimum ind] = min(dist);                      %find closest x in those rows, in order to get the right pixel
    start_row = find(t(:,1) ==  t(row1(ind),1))  %find rows that include this x, and start counting from start_row(1)
    for j = 1:size(start_row,1)
        if t(start_row(j),2) == starty
            start_point = start_row(j)
        end
    end
        
    row2 = find( (t(:,2) == endy));
    dist2 = t(row2,1) - endx;
    [minimum2 ind2] = min(abs(dist2));
    endx = t(row2(ind2),1);
end
    sum = 0;

%% Measuring according to case
switch measurement_type
    case 'nose'
        for i=start_point:size(t,1)-1

            if ( t(i,2)> starty &&  t(i,1)<endx-1 )% define the section of starty with endx-1 as a reference point (works for fiducials at the bottom of the head)
                  continue
             end

             if (t(i,1) ==t(i+1,1) || t(i,2)==t(i+1,2))
                sum = sum+1;
            else
                sum = sum+sqrt(2);
            end

        end
        
    case 'ear'
        for i=1:size(t,1)-1
            
            if ( t(i,2)<= endy) || ( t(i,2)<=starty)
          
                if (t(i,1) ==t(i+1,1) || t(i,2)==t(i+1,2))
                    sum = sum+1;
                else
                    sum = sum+sqrt(2);
                end

            end
        end
        
    case 'perimeter'
        for i=1:size(t,1)-1
                if (t(i,1) ==t(i+1,1) || t(i,2)==t(i+1,2))
                    sum = sum+1;
                else
                    sum = sum+sqrt(2);
                end
        end
end
    
end
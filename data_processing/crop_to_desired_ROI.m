function [ output_args ] = crop_to_desired_ROI(input_image,outer_bound_radius1, coordinates_1,coordinates_2,offset)
%CROP_TO_DESIRED_ROI Summary of this function goes here
%   Detailed explanation goes here
X=dicomread(input_image);
[area1,xs1,ys1]=calculate_area_of_polygon(coordinates_1,0.25);
[area2,xs2,ys2]=calculate_area_of_polygon(coordinates_2,0.25);
if area1>area2
    large_ROI=area1;
    xs=xs1;
    ys=ys1;
else
    large_ROI=area2;
    xs=xs2;
    ys=ys2;
end

%find centroid of the largest ROI
c_x=mean(xs);
c_y=mean(ys);
[radius,rx,ry]=calculate_radius(outer_bound_radius1);
%crop image according to the radius

cropped_image=imcrop(X,[c_x-(radius*2) c_y-(radius*2) 10 10]);
% image(X)
% hold on
% imshow(X,[])
% plot(xs1', ys1' ,'r');
% plot(xs2', ys2' ,'b');
% plot(c_x, c_y ,'*');

subplot(1,2,1)
hold on
imshow(X,[])
plot(c_x-radius, c_y-radius ,'*');
hold off
title('Original Image')
subplot(1,2,2)
imshow(cropped_image,[])
title('Cropped Image')

end


function [radius,xs,ys]=calculate_radius(coordinates)
ys=[];
xs=[];
for i=1:size(coordinates,2)
    if mod(i,2) %even is Y coordinate
      xs=[xs coordinates(i)];
    else
      ys=[ys coordinates(i)];
    end
end
radius=sqrt(power((xs(1)-xs(2)),2)+power((ys(1)-ys(2)),2));
end

function [area,xs,ys]=calculate_area_of_polygon(coordinates,scaling)
ys=[];
xs=[];
for i=1:size(coordinates,2)
    if mod(i,2) %even is Y coordinate
      xs=[xs coordinates(i)];
    else
      ys=[ys coordinates(i)];
    end
end
area=polyarea(xs,ys)*0.25*0.25;
end
%test_call

%crop_to_desired_ROI('/Users/irma/Documents/MATLAB/DATA/Plaques/Plaques_raw/Embolic_infarct/PATIENTS/Bai_Shuan_Ping/study/PLAQUE_T2_FRFSE/IM-0001-0001.dcm',[249.22089	279.24363 248.632844	281.52068], [241.428941	283.526657	242.785567	279.817568	245.466746	277.585839	248.862508	277.360305 251.991106	278.494615 254.185859	280.880501	253.611552	284.869647	250.298122	287.770457	246.985926	288.690721 243.388783	287.51662],[243.677767	283.171227 245.127858	281.576206 248.483596	281.828358 251.256536	282.182195 249.237324	286.080684 245.450913	286.087479],10)
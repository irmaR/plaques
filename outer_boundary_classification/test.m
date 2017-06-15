close all;
image_path='/Users/irma/Documents/MATLAB/CODE/plaques/outer_boundary_classification/test.jpg';
outer_boundary_coords=[257	245;	261.235847	247.76807 ;262.594135	251.045429;	260.09831	252.184905;	256.423018	252.370196;	252.224721	252.593348;	253.14325	248.323318;	254.728077	246.505488]
inner_boundary_coords=[255	242;	250.903767	244.025426;	247.198172	246.813437;	245.940916	250.229574;	246.925574	255.44305;	252.001112	258.30998;	255.056105	259.017643;	258.461032	259.171315;	261.969577	256.835587;	264.191728	252.99832;	263.323667	246.469101;	260.497944	243.732361];

% Read the DICOM image
%Y = dicomread(image_path);
% convert to a double positive image
%P = im2double(Y);
% derive a negative image
% save adjusted posative as jpg
%imwrite(imadjust(P), 'test.jpg', 'jpg');


cx=65;cy=65;ix=128;iy=128;r=30;
cx2=65;cy2=65;ix2=128;iy2=128;r2=26;
[x,y]=meshgrid(-(cx-1):(ix-cx),-(cy-1):(iy-cy));
[x2,y2]=meshgrid(-(cx2-1):(ix2-cx2),-(cy2-1):(iy2-cy2));
c_mask=((x.^2+y.^2)<=r^2);
c_mask2=((x2.^2+y2.^2)<=r2^2);
inner_boundary=(c_mask2)*50;
outer_boundary=(c_mask-c_mask2)*20;
image_boundaries=inner_boundary+outer_boundary;
indices=find(image_boundaries==0);
random_values_other=rand(size(indices,1),1)*10;
image_boundaries(indices)=random_values_other;

[neigh_x1,neigh_y1]=get_neighbour_outer_boundary(65,35,5,cx,cy)
image_boundaries(neigh_x1,neigh_y1)=50;

[neigh_x2,neigh_y2]=get_neighbour_outer_boundary(95,65,5,cx,cy)
image_boundaries(neigh_x2,neigh_y2)=50;

[neigh_x3,neigh_y3]=get_neighbour_outer_boundary(65,95,5,cx,cy)
image_boundaries(neigh_x3,neigh_y3)=50;

[neigh_x4,neigh_y4]=get_neighbour_outer_boundary(37,65,5,cx,cy)
image_boundaries(neigh_x4,neigh_y4)=50;



imagesc(image_boundaries)
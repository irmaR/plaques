function [neighbours_x,neighbours_y]=get_neighbour_outer_boundary(pixel_x_coordinate,pixel_y_coordinate,nr_neighbours,center_x,center_y)
neighbours_x=[];
neighbours_y=[];
[x,y]=get_N_neighbours(pixel_x_coordinate,pixel_y_coordinate,nr_neighbours)
counter=1;
for i=1:length(x)
if y(i)>=center_y
  if y(i)>=pixel_y_coordinate
      neighbours_x(counter)=x(i);
      neighbours_y(counter)=y(i);
      counter=counter+1;
  end
else
      if y(i)<=pixel_y_coordinate
      neighbours_x(counter)=x(i);
      neighbours_y(counter)=y(i);
      counter=counter+1;
      end
  end
end
end
   




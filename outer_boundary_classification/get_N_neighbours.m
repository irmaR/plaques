function [neigbours_x,neighbours_y]=get_N_neighbours(r,c,N)
  neigbours_x=[];
  neighbours_y=[];
  counter=1;
  for i=1:N
      neigbours_x(counter)=r-i; % Upper left.  r = row, c = column.
      neighbours_y(counter)=c-i;
      counter=counter+1;
  end
  for i=1:N
      neigbours_x(counter)=r-i; % Upper left.  r = row, c = column.
      neighbours_y(counter)=c;
      counter=counter+1;
  end
  for i=1:N
      neigbours_x(counter)=r-i; % Upper left.  r = row, c = column.
      neighbours_y(counter)=c-i;
      counter=counter+1;
  end
  for i=1:N
      neigbours_x(counter)=r; % Upper left.  r = row, c = column.
      neighbours_y(counter)=c-i;
      counter=counter+1;
  end
  for i=1:N
      neigbours_x(counter)=r; % Upper left.  r = row, c = column.
      neighbours_y(counter)=c+i;
      counter=counter+1;
  end
  for i=1:N
      neigbours_x(counter)=r+i; % Upper left.  r = row, c = column.
      neighbours_y(counter)=c;
      counter=counter+1;
  end
  for i=1:N
      neigbours_x(counter)=r+i; % Upper left.  r = row, c = column.
      neighbours_y(counter)=c-i;
      counter=counter+1;
  end

end
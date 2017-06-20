function [features]=extract_features_image(I,roi1,roi2,radius,offset)
X=dicomread(I);
features=[]
cropped_image = crop_to_desired_ROI(X,roi1,roi2,radius,offset);
filtered_image=apply_filter(cropped_image);
cropped_image = crop_to_desired_ROI(filtered_image,roi1,roi2,radius,0);
size(cropped_image)

figure
imshow(cropped_image)
end


function [filtered]=apply_filter(cropped_image)
F=makeSfilters;
for i=1:size(F,3)
  responses(:,:,i)=conv2(double(cropped_image),F(:,:,i));
  size(responses(:,:,i))
  [N,edges] = histcounts(responses(:,:,i),10);
  %figure
  %imshow(responses(:,:,i))
end
filtered=mean(responses(:,:,:),3)
end
clear all
%load features
load('/Users/irma/Documents/MATLAB/data/Plaques/data_plaques.mat')

%scale features
[nSmp,nFea] = size(fea);
for i = 1:nSmp
     %scale values to [0,1] interval
     %mtgray(i,:)=mat2gray(fea(i,:));
     whitened(i,:)=whiten(double(fea(i,:)),1E-8);
end





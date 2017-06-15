clc;
clear all;
path_to_fold='/Users/irma/Documents/MATLAB/data/Plaques/Plaques_5_5/fold_1.mat'
path_to_output='/Users/irma/Documents/MATLAB/data/Plaques/Plaques_5_5/Results/KDR/'

load(path_to_fold)


%preprocess training data
fea_train=[];
pl_length_train=[];
inner_boundary_train=[];
outer_boundary_train=[];

fea_test=[];
pl_length_test=[];
inner_boundary_test=[];
outer_boundary_test=[];

counter=1;
%get training data for this fold
patients_keys=keys(patients_train);
for i=1:length(patients_keys)
    patient=patients_keys(i);
    all_images=patients_train(patient{1});
    all_pl_lengths=plaque_length_train(patient{1});
    all_in_bound=plaque_inner_boundary_train(patient{1});
    all_out_bound=plaque_outer_boundary_train(patient{1});
    for j=1:size(all_images,2)
       %get feature matrix
       fea_train(counter,:)=all_images{j};
       pl_length_train(counter,:)=all_pl_lengths{j};
       inner_boundary_train(counter,:)=all_in_bound{j};
       outer_boundary_train(counter,:)=all_out_bound{j};
       counter=counter+1;
    end
end

%get test data for this fold
counter=1;
patients_keys=keys(patients_test);
for i=1:length(patients_keys)
    patient=patients_keys(i);
    all_images=patients_test(patient{1});
    all_pl_lengths=plaque_length_test(patient{1});
    all_in_bound=plaque_inner_boundary_test(patient{1});
    all_out_bound=plaque_outer_boundary_test(patient{1});
    for j=1:size(all_images,2)
       %get feature matrix
       fea_test(counter,:)=all_images{j};
       pl_length_test(counter,:)=all_pl_lengths{j};
       inner_boundary_test(counter,:)=all_in_bound{j};
       outer_boundary_test(counter,:)=all_out_bound{j};
       counter=counter+1;
    end
end

%normalize training data
%optimize parameters for the kernel ridge regression
%alphas=[0.01,0.02,0.03,0.04,0.05,0.06,0.07,0.08,0.09,0.1,0.2,0.3,0.4];
%sigmas=[0.1,0.2,0.5,0.8,1,1.5,1.8,2,2.5];

alphas=[0.01,0.7];
sigmas=[0.1,5];

fea_train = (fea_train - min(fea_train(:)))/(max(fea_train(:)) - min(fea_train(:)));
%fea_test = (fea_test - min(fea_train(:)))/(max(fea_train(:)) - min(fea_train(:)));
fea_test = (fea_test - min(fea_test(:)))/(max(fea_test(:)) - min(fea_test(:)));

MdlStd = fitrsvm(fea_train,pl_length_train);
MdlStd.ConvergenceInfo.Converged
yfit = predict(MdlStd,fea_test)

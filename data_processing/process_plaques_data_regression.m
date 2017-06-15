clear all;
clc;
path_to_embolic='/Users/irma/Documents/MATLAB/data/Plaques//Plaques_5_5/Embolic_infarct/'
path_to_non_embolic='/Users/irma/Documents/MATLAB/data/Plaques/Plaques_5_5/Non_embolic infarct/'

patients = containers.Map;
plaque_length = containers.Map;
plaque_inner_boundary = containers.Map;
plaque_outer_boundary = containers.Map;


%read embolic images
f=dir(sprintf('%s*.jpg',path_to_non_embolic));
csv_file=sprintf('%s/info.csv',path_to_non_embolic);
files={f.name}
emb_N=numel(files);
T = readtable(csv_file);

for k=1:numel(files)
  patient_name=strsplit(files{k},'.');
  patient_name=patient_name{1};
  
  files{k};
  for j=1:size(T,1)
      if strcmp(T(j,1).image_name,patient_name)
          row=T(j,:);
          break
      end
  end
  orig_patient_name=row.orig_patient_name{1};
  
  Im{k}=imread(sprintf('%s/%s',path_to_non_embolic,files{k}));
  fea(k,:)=reshape(Im{k}(:,:,1),[1,(size(Im{k},1)*size(Im{k},2))]);
  
  if isKey(patients,orig_patient_name)==0
      patients(orig_patient_name)={};
      plaque_length(orig_patient_name)={};
      plaque_inner_boundary(orig_patient_name)={};
      plaque_outer_boundary(orig_patient_name)={};
  end
  
  tmp=patients(orig_patient_name);
  tmp1=plaque_length(orig_patient_name);
  tmp2=plaque_inner_boundary(orig_patient_name);
  tmp3=plaque_outer_boundary(orig_patient_name);
    
  plaque_length_cl_a(k,1)=row.pl_length;
  plaque_inner_boundary_a(k,1)=row.pl_in_bound;
  plaque_outer_boundary_a(k,1)=row.pl_out_bound;
  
  tmp{size(tmp,2)+1}=fea(k,:);
  tmp1{size(tmp1,2)+1}=row.pl_length;
  %tmp1
  tmp2{size(tmp2,2)+1}=row.pl_in_bound;
  tmp3{size(tmp3,2)+1}=row.pl_out_bound;
  
   patients(orig_patient_name)=tmp;
   plaque_length(orig_patient_name)=tmp1;
   plaque_length(orig_patient_name);
   plaque_inner_boundary(orig_patient_name)=tmp2;
   plaque_outer_boundary(orig_patient_name)=tmp3;
end


%read non-embolic images
f=dir(sprintf('%s*.jpg',path_to_embolic));
csv_file=sprintf('%s/info.csv',path_to_embolic);
T = readtable(csv_file);
files={f.name}

for k=1:numel(files)
  files{k}
  patient_name=strsplit(files{k},'.');
  patient_name=patient_name{1};
  for j=1:size(T,1)
      if strcmp(T(j,1).image_name,patient_name)
          row=T(j,:);
          break
      end
  end
  orig_patient_name=row.orig_patient_name{1};
  Im{k+emb_N}=imread(sprintf('%s/%s',path_to_embolic,files{k}));
  fea(k+emb_N,:)=reshape(Im{k+emb_N}(:,:,1),[1,(size(Im{k+emb_N},1)*size(Im{k+emb_N},2))]);
  
  
  if isKey(patients,orig_patient_name)==0
      patients(orig_patient_name)={};
      plaque_length(orig_patient_name)={};
      plaque_inner_boundary(orig_patient_name)={};
      plaque_outer_boundary(orig_patient_name)={};
  end
  
  tmp=patients(orig_patient_name);
  tmp1=plaque_length(orig_patient_name);
  tmp2=plaque_inner_boundary(orig_patient_name);
  tmp3=plaque_outer_boundary(orig_patient_name);
   
  plaque_length_cl_a(k,1)=row.pl_length;
  plaque_inner_boundary_a(k,1)=row.pl_in_bound;
  plaque_outer_boundary_a(k,1)=row.pl_out_bound;
  
  tmp{size(tmp,2)+1}=fea(k,:);
  tmp1{size(tmp1,2)+1}=row.pl_length;
  tmp2{size(tmp2,2)+1}=row.pl_in_bound;
  tmp3{size(tmp3,2)+1}=row.pl_out_bound;
  
  patients(orig_patient_name)=tmp;
  plaque_length(orig_patient_name)=tmp1;
  plaque_length(orig_patient_name);
  plaque_inner_boundary(orig_patient_name)=tmp2;
  plaque_outer_boundary(orig_patient_name)=tmp3;
end

save('/Users/irma/Documents/MATLAB/data/Plaques/Plaques_5_5/data_plaques.mat','fea','plaque_length_cl_a','plaque_inner_boundary_a','plaque_outer_boundary_a','patients','plaque_length','plaque_inner_boundary','plaque_outer_boundary')



%separate in folds on a patient basis
for i=1:length(keys(patients))
   patients_test = containers.Map;
   plaque_length_test = containers.Map;
   plaque_inner_boundary_test = containers.Map;
   plaque_outer_boundary_test = containers.Map;
   fprintf('A novo Size: %d\n',length(keys(patients_test)))
   patients_train = containers.Map;
   plaque_length_train = containers.Map;
   plaque_inner_boundary_train = containers.Map;
   plaque_outer_boundary_train = containers.Map;
   
   patients_keys=keys(patients);
   patient_name=patients_keys(i);
   
   
   for j=1:length(keys(patients))
       patients_keys_all=keys(patients);
       patients_keys_1=patients_keys_all(j);

      
       if strcmp(patient_name{1},patients_keys_1)  
         fprintf('HERE!\n')
         patient_name{1},patients_keys_1
         patients_test(patients_keys_1{1})=patients(patient_name{1});
         plaque_length_test(patients_keys_1{1})=plaque_length(patient_name{1});
         plaque_inner_boundary_test(patients_keys_1{1})=plaque_inner_boundary(patient_name{1});
         plaque_outer_boundary_test(patients_keys_1{1})=plaque_outer_boundary(patient_name{1});
         fprintf('Size: %d\n',length(keys(patients_test)))
       else
         fprintf('Other patients!')  
         patients_train(patients_keys_1{1})=patients(patient_name{1});
         plaque_length_train(patients_keys_1{1})=plaque_length(patient_name{1});
         plaque_inner_boundary_train(patients_keys_1{1})=plaque_inner_boundary(patient_name{1});
         plaque_outer_boundary_train(patients_keys_1{1})=plaque_outer_boundary(patient_name{1});
          fprintf('Size test: %d\n',length(keys(patients_test)))
       end    
   end
   fprintf('Size Saving: %d\n',length(keys(patients_test)))
   fold=sprintf('%s/fold_%d.mat','/Users/irma/Documents/MATLAB/data/Plaques/Plaques_5_5/',i)
   save(fold,'patients_test','plaque_length_test','plaque_inner_boundary_test','plaque_outer_boundary_test','patients_train','plaque_length_train','plaque_inner_boundary_train','plaque_outer_boundary_train')

   
end





function [alpha,sigma]=optimize_parameters(alphas,sigmas,fea_train,Y)
performances=zeros(length(alphas),length(sigmas));
for i=1:length(alphas)
    for j=1:length(sigmas)
      performances(i,j)=LOO(fea_train,Y,alphas(i),sigmas(j))
    end
end
%choose the best parameters
[minp,ic] = max(performances,[],1);
[minminp,is] = max(minp);
ic=ic(is);
alpha = alphas(ic);
sigma = sigmas(is);
end


function [avg_perf]=LOO(fea_train,Y,sigma,alpha)
performances=[]; 
sigma,alpha
    for i=1:size(fea_train,1)
        Xtest=fea_train(i,:);
        Ytest=Y(i,:);
        Xtrain=fea_train(1:end~=i,:);
        Ytrain=Y(1:end~=i,:);
        Yhat=callKSR(Xtest, Xtrain, Ytrain,alpha,sigma)
        Ytest
        fit = gfit2(Yhat,Ytest,'4');
        performances(i)=fit
    end
performances
avg_perf=mean(performances)
end
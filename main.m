clear all;close all;clc;
dataset_name = 'standard';
ktimes = 5; % 5FCV,fixed
index = 1:30;
load([dataset_name,'.mat']);clear a;clear b;clear i;clear str1;clear str2;clear temp;
for i_index = 1:length(index)
    file_name = eval([dataset_name,'{',num2str(index(i_index)),',1}']);
    dataname =  strcat('BQPSO_C45_standard_',file_name);
    final_res = zeros(ktimes+2,3);
    for i_cv = 1:ktimes
        i_cv
        train_all = eval([dataset_name,'{',num2str(index(i_index)),',2}{',num2str(i_cv),',1}']);
        test_all = eval([dataset_name,'{',num2str(index(i_index)),',2}{',num2str(i_cv),',2}']);
        train=train_all(:,1:end-1);train_labels=train_all(:,end);
        test=test_all(:,1:end-1);test_labels=test_all(:,end);
        
        Max_iteration=100; % Maximum number of iterations
        noP=50; % Number of particles
        noV=size(train,1);
        
        for ij=1:6
            [gBest, gBestScore ]=BQPSO(noP,  noV, Max_iteration, train,train_labels);
            ACC_train(i_cv,ij)=gBestScore;
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            indexx=find(gBest~=0);
            Reduction(i_cv,ij)=((noV-length(indexx))./noV).*100;
            DT=train(indexx,:);
            Train_labels=train_labels(indexx);
            CLASS = knnclassify(test,DT,Train_labels,5);
            ACC_test(i_cv,ij)=(sum(CLASS==test_labels))./length(CLASS);
            
        end
        final_res(i_cv,1) = mean(ACC_train(i_cv,:));
        final_res(i_cv,2) = mean(ACC_test(i_cv,:));
        final_res(i_cv,3) = mean(Reduction(i_cv,:));
        
    end
    final_res(ktimes+1,:) = mean(final_res(1:ktimes,:));
    final_res(ktimes+2,:) = std(final_res(1:ktimes,:));
    save([dataname,'.mat'],'final_res');
end


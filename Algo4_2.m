%comparison of 4 algorithm in terms of average value of service.
%used with iteration4.m
global minv_cur;
global maxv_cur;

Num_acc=5000;


TskEvNum_E=zeros(1,Num_acc);
TskEvNum_H=zeros(1,Num_acc);
TskEvNum_G=zeros(1,Num_acc);
TskEvNum_R=zeros(1,Num_acc);

TskV_E=zeros(1,Num_acc);
TskV_H=zeros(1,Num_acc);
TskV_G=zeros(1,Num_acc);
TskV_R=zeros(1,Num_acc);

for i_Ag2=1:Num_acc
    clc;
    % print for debug
    ite4
    i_Ag2
    % end print for debug
    
    main;
    %tsk(1,1:4)=[i_tg,ts,min_vl,max_vl]; %tsk element 1-4 : gw,tasksize,minvalue,maxvalue
    tsk(1,3)=minv_cur;
    tsk(1,4)=maxv_cur;
    task_device_table_generation;
    
    pr_tab=Prf_table;
    
    Asmt_aftrE=Exhaustive(pr_tab);
    if any(Asmt_aftrE(:,1))
    TskEvNum_E(i_Ag2)=1;
    TskV_E(i_Ag2)=sum(TP_table(:,1).*Asmt_aftrE(:,1));
    end
    
    Asmt_aftrH=Huristic(pr_tab);
    if any(Asmt_aftrH(:,1))
    TskEvNum_H(i_Ag2)=1;
    TskV_H(i_Ag2)=sum(TP_table(:,1).*Asmt_aftrH(:,1));
    end
    
    Asmt_aftrG=Greedy(pr_tab);
    if any(Asmt_aftrG(:,1))
    TskEvNum_G(i_Ag2)=1;
    TskV_G(i_Ag2)=sum(TP_table(:,1).*Asmt_aftrG(:,1));
    end
    
    Asmt_aftrR=Radm(pr_tab);
    if any(Asmt_aftrR(:,1))
    TskEvNum_R(i_Ag2)=1;
    TskV_R(i_Ag2)=sum(TP_table(:,1).*Asmt_aftrR(:,1));
    end
    
end

TskEvPr_E=mean(TskEvNum_E);
TskEvPr_H=mean(TskEvNum_H);
TskEvPr_G=mean(TskEvNum_G);
TskEvPr_R=mean(TskEvNum_R);

mean_TskVe=mean(TskV_E);
mean_TskVh=mean(TskV_H);
mean_TskVg=mean(TskV_G);
mean_TskVr=mean(TskV_R);









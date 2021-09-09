%comparison of 4 algorithm in terms of average value of service.
%used with iteration5.m
global minv_curd;
global maxv_curd;

Num_acc=5000;


DevEvNum_E=zeros(1,Num_acc);
DevEvNum_H=zeros(1,Num_acc);
DevEvNum_G=zeros(1,Num_acc);
DevEvNum_R=zeros(1,Num_acc);

DeV_E=zeros(1,Num_acc);
DeV_H=zeros(1,Num_acc);
DeV_G=zeros(1,Num_acc);
DeV_R=zeros(1,Num_acc);

for i_Ag3=1:Num_acc
    clc;
    % print for debug
    ite5
    i_Ag3
    % end print for debug
    
    main;
    device(1,2)=minv_curd;   %device element 2-3 : min value, max value
    device(1,3)=maxv_curd;
    task_device_table_generation;
    
    pr_tab=Prf_table;
    
    Asmt_aftrE=Exhaustive(pr_tab);
    if any(Asmt_aftrE(1,:))
    DevEvNum_E(i_Ag3)=1;
    DeV_E(i_Ag3)=sum(DP_table(1,:).*Asmt_aftrE(1,:));
    else
    DevEvNum_E(i_Ag3)=0;
    DeV_E(i_Ag3)=maxv_curd;    
    end
    
    Asmt_aftrH=Huristic(pr_tab);
    if any(Asmt_aftrH(1,:))
    DevEvNum_H(i_Ag3)=1;
    DeV_H(i_Ag3)=sum(DP_table(1,:).*Asmt_aftrH(1,:));
    else
    DevEvNum_H(i_Ag3)=0;
    DeV_H(i_Ag3)=maxv_curd;    
    end
    
    
    Asmt_aftrG=Greedy(pr_tab);
    if any(Asmt_aftrG(1,:))
    DevEvNum_G(i_Ag3)=1;
    DeV_G(i_Ag3)=sum(DP_table(1,:).*Asmt_aftrG(1,:));
    else
    DevEvNum_G(i_Ag3)=0;
    DeV_G(i_Ag3)=maxv_curd;    
    end
    
    Asmt_aftrR=Radm(pr_tab);
    if any(Asmt_aftrR(1,:))
    DevEvNum_R(i_Ag3)=1;
    DeV_R(i_Ag3)=sum(DP_table(1,:).*Asmt_aftrR(1,:));
    else
    DevEvNum_R(i_Ag3)=0;
    DeV_R(i_Ag3)=maxv_curd;    
    end
end

DevEvPr_E=mean(DevEvNum_E);
DevEvPr_H=mean(DevEvNum_H);
DevEvPr_G=mean(DevEvNum_G);
DevEvPr_R=mean(DevEvNum_R);

mean_DeVe=mean(DeV_E);
mean_DeVh=mean(DeV_H);
mean_DeVg=mean(DeV_G);
mean_DeVr=mean(DeV_R);









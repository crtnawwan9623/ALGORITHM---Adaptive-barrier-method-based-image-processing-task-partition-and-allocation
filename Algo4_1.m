%comparison of 4 algorithm in terms of average value of service.

Num_acc=2000;
H_sum=0;
E_sum=0;
G_sum=0;
R_sum=0;

SM_H=zeros(1,Num_acc);
SM_G=zeros(1,Num_acc);
SM_R=zeros(1,Num_acc);

for i_Ag=1:Num_acc
    clc;
    D
    G
    i_Ag
    main;
    pr_tab=Prf_table;
    tic;
    H_v=value_of_service(pr_tab,Huristic(pr_tab));
    t_hv(i_Ag)=toc;
    tic;
    E_v=value_of_service(pr_tab,Exhaustive(pr_tab));
    %E_v=0;
    t_ev(i_Ag)=toc;
    tic;
    G_v=value_of_service(pr_tab,Greedy(pr_tab));
    t_gv(i_Ag)=toc;
    tic;
    R_v=value_of_service(pr_tab,Radm(pr_tab));
    t_rv(i_Ag)=toc;
    
    H_sum=H_sum+H_v;
    E_sum=E_sum+E_v;
    G_sum=G_sum+G_v;
    R_sum=R_sum+R_v;
    
    SM_H(i_Ag)=H_v/E_v;     %performance measure
    SM_G(i_Ag)=G_v/E_v;     %performance measure
    SM_R(i_Ag)=R_v/E_v;     %performance measure
    SM_E(i_Ag)=1; %E_v/E_v
    
    if (isnan(H_sum)==1) || (isnan(G_sum)==1) || (isnan(R_sum)==1)
        error('YesNaN')
    end
end
H_sum=H_sum/Num_acc;
E_sum=E_sum/Num_acc;
G_sum=G_sum/Num_acc;
R_sum=R_sum/Num_acc;

meansm_h=mean(SM_H);
meansm_g=mean(SM_G);
meansm_r=mean(SM_R);
meansm_e=mean(SM_E);

varsm_h=var(SM_H);
varsm_g=var(SM_G);
varsm_r=var(SM_R);
varsm_e=var(SM_E);

mean_thv=mean(t_hv);
mean_tev=mean(t_ev);
mean_tgv=mean(t_gv);
mean_trv=mean(t_rv);

var_thv=var(t_hv);
var_tev=var(t_ev);
var_tgv=var(t_gv);
var_trv=var(t_rv);












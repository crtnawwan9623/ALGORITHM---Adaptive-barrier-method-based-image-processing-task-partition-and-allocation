function [Qw_ini,ll_ini]=GDini(tt)

    global D;
    global tsk;
    ll_ini=[];
    Qw_ini=[];
    qkd_tmp=rand(1,D);
    qkd_tmpsum=sum(qkd_tmp);
    qkd_tmp1=qkd_tmp/qkd_tmpsum;
    for i_Gi=1:D
        tsktm_ini(i_Gi)=tsktm(tsk(tt,2)*qkd_tmp1(i_Gi),tsk(tt,1),i_Gi); 
    end
    ll_ini=max(tsktm_ini)+0.1;
    Qw_ini=qkd_tmp1(1:D-1);
    
end
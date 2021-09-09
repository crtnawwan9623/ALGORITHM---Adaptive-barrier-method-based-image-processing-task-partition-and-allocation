function [GDV,v3_sl,v3_v]=GD_ori(tt,rr,stp,Iternum,Qw_ini,ll_ini)
%return original gradient descent solution
% tt: tsk
% rr: weight parameter of barrier functions
% stp: step size
global D;
 global tsk;
 global j_tp1;
    % debug observation value initialization
    v3_sl=[];
    v3_v=[];
    
    % begin initialization of ll_old and Qw_old
    ll_old=[];
    Qw_old=[];
    qkd_tmp=rand(1,D);
    qkd_tmpsum=sum(qkd_tmp);
    qkd_tmp1=qkd_tmp/qkd_tmpsum;
    for i_GD=1:D
        tsktm_ini(i_GD)=tsktm(tsk(tt,2)*qkd_tmp1(i_GD),tsk(tt,1),i_GD); 
    end
    
     if (nargin==6)
        ll_old=ll_ini;
        Qw_old=Qw_ini;
     else
        ll_old=max(tsktm_ini)+0.1;
        Qw_old=qkd_tmp1(1:D-1);
     end
     % end initialization
     
     
    Fst_flag=1;
  %  Iternum=10;
    Iterct=0;
    ebs=0;
    Qw_new=zeros(1,D-1);
    cnt=0;
    v3_v(1)=v3obj(ll_old,Qw_old,tt,rr);
    v3_sl=[Qw_old,ll_old];
    
    while Fst_flag==1 || ((Iterct<=Iternum)&&(ebs > 1e-4))
         clc
       D
       j_tp1  % added for iteration_p1.m
       
        Fst_flag=0;
        Iterct=Iterct+1
        
        Qw_new=Qw_old;
        for i_GD=1:D-1
            Qw_new(i_GD)=Qw_old(i_GD)-stp*VqDertv(ll_old,Qw_old,i_GD,tt,rr);
            
            if Qw_new(i_GD)<0.01
                Qw_new(i_GD)=0.01;
            end
            
            if sum(Qw_new)>0.99
                 Qw_new(i_GD)=0;
                 Qw_new(i_GD)=0.99-sum(Qw_new);
            end
        end
        
        ll_new=ll_old-stp*VlDertv(ll_old,Qw_old,tt,rr);
        
        
 
        ebs=norm([Qw_new,ll_new]-[Qw_old,ll_old]);
        ebs=1;  % add for Iteration_p1.m  force iternum 100
        
        Qw_old=Qw_new;
        ll_old=ll_new;
   
        v3_sl=[v3_sl;Qw_new,ll_new];
        v3_v(Iterct+1)=v3obj(ll_new,Qw_new,tt,rr);
        
        % begin check boundary
%         flag_bd=0;
%         for i_GD=1:D-1
%             if abs(Qw_new(i_GD)-0.01)<=0.005
%                 flag_bd=1;
%             end
%         end
%         if flag_bd==1
%             [Qw_old,ll_old]=GDini(tt);
%             Fst_flag=1;
%             Iterct=0;
%             v3_sl=[];
%             v3_v=[];
%         end
        % end check boundary
        
    end
    GDV=[Qw_new,ll_new];
  %  plot(1:length(v3_v),v3_v);

end





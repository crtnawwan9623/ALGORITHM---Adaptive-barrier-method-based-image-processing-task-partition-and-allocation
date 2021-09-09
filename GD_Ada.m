function [GDV,v3_sl,v3_v]=GD_Ada(tt,rr,stp,Gm,Iternum,Qw_ini,ll_ini)
%return Adadelta gradient descent solution
% tt: tsk
% rr: weight parameter of barrier functions
% stp: first step size 
% Gm: wegiht parameter of previous average in Adadelta
global D;
global tsk;
global gRMSDetq;
global gRMSDetl;
global gRMSq;
global gRMSl;

global j_tp4;
global k_BM;


Ebc=1e-8;

 
    % begin initialization of ll_old and Qw_old
    ll_old=[];
    Qw_old=[];
    v3_sl=[];
    v3_v=[];
%     gRMSq=[];
%     gRMSl=[];
%     gRMSDetq=[];
%     gRMSDetl=[];
    
    qkd_tmp=rand(1,D);
    qkd_tmpsum=sum(qkd_tmp);
    qkd_tmp1=qkd_tmp/qkd_tmpsum;
    for i_GA=1:D
        tsktm_ini(i_GA)=tsktm(tsk(tt,2)*qkd_tmp1(i_GA),tsk(tt,1),i_GA); 
    end
    
     if (nargin==7)
        ll_old=ll_ini;
        Qw_old=Qw_ini;
     else
         ll_old=max(tsktm_ini)+0.1;
         Qw_old=qkd_tmp1(1:D-1);
     end
     % end initialization
     
     
    Fst_flag=1;
   % Iternum=40;
    Iterct=0;
    ebs=0;
    Qw_new=zeros(1,D-1);
    cnt=0;
    v3_v(1)=v3obj(ll_old,Qw_old,tt,rr);
    v3_sl=[Qw_old,ll_old];
    
    while Fst_flag==1 || ((Iterct<=Iternum)&&(ebs > 1e-4))
         clc
         D
         j_tp4  % added for iteration_p1.m
         k_BM   % added for Barrier_Method.m
         
        Fst_flag=0;
        Iterct=Iterct+1
        
        % begin Qw_new update
        Qw_new=Qw_old;
        for i_GA=1:D-1
            
            if Iterct == 1
                Eqkddev2(i_GA)=(VqDertv(ll_old,Qw_old,i_GA,tt,rr))^2;
            else
                Eqkddev2(i_GA)=Gm*Eqkddev2(i_GA)+(1-Gm)*((VqDertv(ll_old,Qw_old,i_GA,tt,rr))^2);
            end
            RMSq(i_GA)=sqrt(Eqkddev2(i_GA)+Ebc);
            
            if Iterct == 1
                detaq(i_GA)=stp;
                Edetaq2(i_GA)=detaq(i_GA).^2;
                RMSdtq(i_GA)=sqrt(Edetaq2(i_GA)+Ebc);
            end
            
            
            detaq(i_GA)=-(RMSdtq(i_GA)*VqDertv(ll_old,Qw_old,i_GA,tt,rr))/RMSq(i_GA);
            Qw_new(i_GA)=Qw_old(i_GA)+detaq(i_GA);
            
           % Qw_new(i)=Qw_old(i)-stp*VqDertv(ll_old,Qw_old,i,tt,rr);
            
            if Qw_new(i_GA)<0.01
                Qw_new(i_GA)=0.01;
            end
            
            if sum(Qw_new)>0.99
                 Qw_new(i_GA)=0;
                 Qw_new(i_GA)=0.99-sum(Qw_new);
            end
            
            detaq(i_GA)=Qw_new(i_GA)-Qw_old(i_GA);
            Edetaq2(i_GA)=Gm*Edetaq2(i_GA)+(1-Gm)*(detaq(i_GA).^2);
            RMSdtq(i_GA)=sqrt(Edetaq2(i_GA)+Ebc);
   
        end
        % end Qw_new update
        
        
        % begin ll_new update
            if Iterct == 1
                Eldev2=(VlDertv(ll_old,Qw_old,tt,rr))^2;
            else
                Eldev2=Gm*Eldev2+(1-Gm)*(VlDertv(ll_old,Qw_old,tt,rr))^2;
            end
            RMSl=sqrt(Eldev2+Ebc);
            
            if Iterct == 1
                detal=stp;
                Edetal2=detal.^2;
                RMSdtl=sqrt(Edetal2+Ebc);
            end
            
            detal=-(RMSdtl*VlDertv(ll_old,Qw_old,tt,rr))/RMSl;
            ll_new=ll_old+detal;
            
            Edetal2=Gm*Edetal2+(1-Gm)*(detal.^2);
            RMSdtl=sqrt(Edetal2+Ebc);
        % end ll_new update
        %ll_new=ll_old-stp*VlDertv(ll_old,Qw_old,tt,rr);
        
        
 
        ebs=norm([Qw_new,ll_new]-[Qw_old,ll_old]);
        ebs=1;  % add for Iteration_p1.m  force iternum 100
        
        Qw_old=Qw_new;
        ll_old=ll_new;
   
        v3_sl=[v3_sl;Qw_new,ll_new];
        v3_v(Iterct+1)=v3obj(ll_new,Qw_new,tt,rr);
        
        % begin check boundary
%         flag_bd=0;
%         for i_GA=1:D-1
%             if abs(Qw_new(i_GA)-0.01)<=0.005
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

%         gRMSq=[gRMSq;RMSq];
%         gRMSl=[gRMSl;RMSl];
%         gRMSDetq=[gRMSDetq;RMSdtq];
%         gRMSDetl=[gRMSDetl;RMSdtl];

    end
    GDV=[Qw_new,ll_new];
  %  plot(1:length(v3_v),v3_v);

end

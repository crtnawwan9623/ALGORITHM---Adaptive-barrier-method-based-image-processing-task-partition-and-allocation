% future figure 18
% average allocated ratio & average sigle device profits - number of device comparison of TPR Tmn Rdn
warning('off');
global D;
global j_tp4;
global tsk;
global device;
clc
tt=1;
rr=0.02;
stp_Ada=0.01;
Gm=0.9;
Iternum=100;      %internal iteration number of GD and GDA
Num_Cf=180;    % for each D, produce Num_Cf config
D=4;


D_g=[2,3,4,5,6,7,8,9,10];
%D_g=[2,6,10];
for j_tp4=170:Num_Cf

    for i_tp7=1:length(D_g) 
        
          D=D_g(i_tp7);
          mainp;
          device(1,1:6)=[2.5,0.4,0.8,10.4,34.7872,3.2113e-27];
          tsk(tt,2)=10;   % task size
        
         %begin solving by TPR(TimIniPlusRndLni)
            [TPR_v,TPR_sl]=TiminIniPlusRndIni(tt,rr,stp_Ada,Gm,Iternum)
            TPR_qg(i_tp7,j_tp4)=TPR_sl(1);
            
            E_tmp=energy_consp(tsk(tt,2)*TPR_sl(1),device(1,1),device(1,6));
            TPR_dpg(i_tp7,j_tp4)=dev_prf(1,E_tmp);
            
            TPR_vg(i_tp7,j_tp4)=TPR_v;
         %end solving by TPR
         
          % begin solving by timemin (only time min and no iteration)
            [qkd_tmp1,tim_ac_tmp]=timemin(tt);
            Tmn_qg(i_tp7,j_tp4)=qkd_tmp1(1);
            
            E_tmp=energy_consp(tsk(tt,2)*qkd_tmp1(1),device(1,1),device(1,6));
            Tmn_dpg(i_tp7,j_tp4)=dev_prf(1,E_tmp);
            
            Tmn_vg(i_tp7,j_tp4)=p_value_of_service(qkd_tmp1(1:D-1),tt); 
        % end solving by timemin
        
        % begin solving by random (only Rnd and no iteration)
            [minVoS_tmp,minVoS_sl_tmp]=RdnMinVoS(tt);
            Rdm_qg(i_tp7,j_tp4)=minVoS_sl_tmp(1);
            
            E_tmp=energy_consp(tsk(tt,2)*minVoS_sl_tmp(1),device(1,1),device(1,6));
            Rdm_dpg(i_tp7,j_tp4)=dev_prf(1,E_tmp);
            
            Rdm_vg(i_tp7,j_tp4)=minVoS_tmp;
        % end solving by random
    end
    save('figure18_tmp.mat');

end




%begin plot
            for k_tp7=1:length(D_g) 
                mean_TPRqg(k_tp7)=mean(TPR_qg(k_tp7,:));
                mean_TPRdpg(k_tp7)=mean(TPR_dpg(k_tp7,:));

                mean_Tmnqg(k_tp7)=mean(Tmn_qg(k_tp7,:));
                mean_Tmndpg(k_tp7)=mean(Tmn_dpg(k_tp7,:));

                mean_Rdmqg(k_tp7)=mean(Rdm_qg(k_tp7,:));
                mean_Rdmdpg(k_tp7)=mean(Rdm_dpg(k_tp7,:));
                
                mean_TPRg(k_tp7)=mean(TPR_vg(k_tp7,:));
                mean_Rdmg(k_tp7)=mean(Rdm_vg(k_tp7,:));
                mean_Tmng(k_tp7)=mean(Tmn_vg(k_tp7,:));
            end
            
            plot(D_g,mean_TPRqg,'r-x',D_g,mean_Tmnqg,'b-o',D_g,mean_Rdmqg,'k-s','markersize',10,'linewidth',1.5);
            set(gca,'FontSize',14);
            xlabel('Number of devices','fontsize',14);
            ylabel('Average allocated ratio','fontsize',14);
            set(gca,'Fontname','times new Roman');
            leng1=legend('TPR','Timemin','Random');
            set(leng1,'position',[0.5744047660558 0.686111116787744 0.267857137588518 0.203571422894796]);
            grid;
            
            figure
            plot(D_g,mean_TPRdpg,'r-x',D_g,mean_Tmndpg,'b-o',D_g,mean_Rdmdpg,'k-s','markersize',10,'linewidth',1.5);
            set(gca,'FontSize',14);
            xlabel('Number of mobile devices','fontsize',14);
            ylabel('Average device value','fontsize',14);
            set(gca,'Fontname','times new Roman');
            leng1=legend('ABM','Timemin','Random');
            set(leng1,'position',[0.602976194627229 0.167063497740125 0.267857137588518 0.203571422894796]);
            grid;
            
%             figure
%             plot(tsk_size,mean_TPRg,'r-x',tsk_size,mean_Tmng,'b-o',tsk_size,mean_Rdmg,'k-s','markersize',10,'linewidth',1.5);  
%             set(gca,'FontSize',14);
%             %axis([0.0 0.9,-inf,inf]);
%             xlabel('Task size (Mbit)','fontsize',14);
%             ylabel('Average value of service','fontsize',14);
%             set(gca,'Fontname','times new Roman');
%             leng1=legend('TPR','Timemin','Random');
%             set(leng1,'position',[0.5744047660558 0.686111116787744 0.267857137588518 0.203571422894796]);
%             grid;
%end plot




% future figure 16 _nouse
% average allocated ratio - mini value of device comparison of TPR Tmn Rdn
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
Num_Cf=2;    % for each D, produce Num_Cf config
D=4;

%Value_d=[0,0.1;0.1,0.2;0.2,0.3;0.3,0.4;0.4,0.5;0.5,0.6;0.6,0.7;0.7,0.8;0.8,0.9;0.9,1.0;];
%Value_d=[0.1,0.4;0.4,0.7;0.7,1.0;];
Value_d=[0.0,0.1;0.5,0.6;0.9,1.0;];
for j_tp4=1:Num_Cf
    mainp;
   
    for i_tp6=1:size(Value_d,1) 
        device(1,2)=Value_d(i_tp6,1);   %device element 2-3 : min value, max value
        device(1,3)=Value_d(i_tp6,2);  
         %begin solving by TPR(TimIniPlusRndLni)
            [TPR_v,TPR_sl]=TiminIniPlusRndIni(tt,rr,stp_Ada,Gm,Iternum)
            TPR_qg(i_tp6,j_tp4)=TPR_sl(1);
            
            E_tmp=energy_consp(tsk(tt,2)*TPR_sl(1),device(1,1),device(1,6));
            TPR_dpg(i_tp6,j_tp4)=dev_prf(1,E_tmp);
         %end solving by TPR
         
          % begin solving by timemin (only time min and no iteration)
            [qkd_tmp1,tim_ac_tmp]=timemin(tt);
            Tmn_qg(i_tp6,j_tp4)=qkd_tmp1(1);
            
            E_tmp=energy_consp(tsk(tt,2)*qkd_tmp1(1),device(1,1),device(1,6));
            Tmn_dpg(i_tp6,j_tp4)=dev_prf(1,E_tmp);
        % end solving by timemin
        
        % begin solving by random (only Rnd and no iteration)
            [minVoS_tmp,minVoS_sl_tmp]=RdnMinVoS(tt);
            Rdm_qg(i_tp6,j_tp4)=minVoS_sl_tmp(1);
            
            E_tmp=energy_consp(tsk(tt,2)*minVoS_sl_tmp(1),device(1,1),device(1,6));
            Rdm_dpg(i_tp6,j_tp4)=dev_prf(1,E_tmp);
        % end solving by random
    end
    save('figure16_tmp.mat');
    
    
            %begin plot
            for k_tp6=1:size(Value_d,1)
                mean_TPRqg(k_tp6)=mean(TPR_qg(k_tp6,:));
                mean_TPRdpg(k_tp6)=mean(TPR_dpg(k_tp6,:));

                mean_Tmnqg(k_tp6)=mean(Tmn_qg(k_tp6,:));
                mean_Tmndpg(k_tp6)=mean(Tmn_dpg(k_tp6,:));

                mean_Rdmqg(k_tp6)=mean(Rdm_qg(k_tp6,:));
                mean_Rdmdpg(k_tp6)=mean(Rdm_dpg(k_tp6,:));
            end
            subplot(211)
            plot(Value_d(:,1),mean_TPRqg,'r-x',Value_d(:,1),mean_Rdmqg,'k-s','markersize',10,'linewidth',1.5);
            set(gca,'FontSize',14);
            xlabel('Minimum value of device','fontsize',14);
            ylabel('Average allocated ratio','fontsize',14);
            set(gca,'Fontname','times new Roman');
            leng1=legend('TPR','Random');
            grid;
            subplot(212)
            plot(Value_d(:,1),mean_TPRdpg,'r-x',Value_d(:,1),mean_Rdmdpg,'k-s','markersize',10,'linewidth',1.5);
            set(gca,'FontSize',14);
            xlabel('Minimum value of device','fontsize',14);
            ylabel('Average device profits','fontsize',14);
            set(gca,'Fontname','times new Roman');
            leng1=legend('TPR','Random');
            grid;
            %end plot
    
end

% for k_tp6=1:size(Value_d,1)
%     mean_TPRqg(k_tp6)=mean(TPR_qg(k_tp6,:));
%     mean_TPRdpg(k_tp6)=mean(TPR_dpg(k_tp6,:));
%     
%     mean_Tmnqg(k_tp6)=mean(Tmn_qg(k_tp6,:));
%     mean_Tmndpg(k_tp6)=mean(Tmn_dpg(k_tp6,:));
%     
%     mean_Rdmqg(i_tp4)=mean(Rdm_qg(k_tp6,:));
%     mean_Rdmdpg(i_tp4)=mean(Rdm_dpg(k_tp6,:));
% end
% subplot(211)
% plot(Value_d(:,1),mean_TPRqg,'r-x',Value_d(:,1),mean_Rdmqg,'k-s','markersize',10,'linewidth',1.5);
% set(gca,'FontSize',14);
% xlabel('Minimum value of device','fontsize',14);
% ylabel('Average allocated ratio','fontsize',14);
% set(gca,'Fontname','times new Roman');
% leng1=legend('TPR','Random');
% grid;
% subplot(212)
% plot(Value_d(:,1),mean_TPRdpg,'r-x',Value_d(:,1),mean_Rdmdpg,'k-s','markersize',10,'linewidth',1.5);
% set(gca,'FontSize',14);
% xlabel('Minimum value of device','fontsize',14);
% ylabel('Average device profits','fontsize',14);
% set(gca,'Fontname','times new Roman');
% leng1=legend('TPR','Random');
% grid;







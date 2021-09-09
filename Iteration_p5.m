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
Num_Cf=1;    % for each D, produce Num_Cf config
D=4;

mainp;
%Value_d=[0,0.1;0.1,0.2;0.2,0.3;0.3,0.4;0.4,0.5;0.5,0.6;0.6,0.7;0.7,0.8;0.8,0.9;0.9,1.0;];
Value_d=[0.1,0.4;0.4,0.7;0.7,1.0;];
for i_tp4=1:size(Value_d,1)    % iter for the whole D_g
    
    for j_tp4=1:Num_Cf  % for each D, produce Num_Cf config
        %mainp;
        device(1,2)=Value_d(i_tp4,1);   %device element 2-3 : min value, max value
        device(1,3)=Value_d(i_tp4,2);
        
        
        %begin solving by TPR(TimIniPlusRndLni)
            [TPR_v,TPR_sl]=TiminIniPlusRndIni(tt,rr,stp_Ada,Gm,Iternum)
            TPR_qg(i_tp4,j_tp4)=TPR_sl(1);
            
            E_tmp=energy_consp(tsk(tt,2)*TPR_sl(1),device(1,1),device(1,6));
            TPR_dpg(i_tp4,j_tp4)=dev_prf(1,E_tmp);
            
        %end solving by TPR
        
        % begin solving by timemin (only time min and no iteration)
            [qkd_tmp1,tim_ac_tmp]=timemin(tt);
            Tmn_qg(i_tp4,j_tp4)=qkd_tmp1(1);
            
            E_tmp=energy_consp(tsk(tt,2)*qkd_tmp1(1),device(1,1),device(1,6));
            Tmn_dpg(i_tp4,j_tp4)=dev_prf(1,E_tmp);
        % end solving by timemin
        
        % begin solving by random (only Rnd and no iteration)
            [minVoS_tmp,minVoS_sl_tmp]=RdnMinVoS(tt);
            Rdm_qg(i_tp4,j_tp4)=minVoS_sl_tmp(1);
            
            E_tmp=energy_consp(tsk(tt,2)*minVoS_sl_tmp(1),device(1,1),device(1,6));
            Rdm_dpg(i_tp4,j_tp4)=dev_prf(1,E_tmp);
        % end solving by random
    end
    
    % average and variance over configs
    mean_TPRqg(i_tp4)=mean(TPR_qg(i_tp4,:));
    mean_TPRdpg(i_tp4)=mean(TPR_dpg(i_tp4,:));
    
    mean_Tmnqg(i_tp4)=mean(Tmn_qg(i_tp4,:));
    mean_Tmndpg(i_tp4)=mean(Tmn_dpg(i_tp4,:));
    
    mean_Rdmqg(i_tp4)=mean(Rdm_qg(i_tp4,:));
    mean_Rdmdpg(i_tp4)=mean(Rdm_dpg(i_tp4,:));
    save('figure16_tmp.mat');
end

plot(Value_d(:,1),mean_TPRqg,'r-x',Value_d(:,1),mean_Rdmqg,'k-s','markersize',10,'linewidth',1.5);
set(gca,'FontSize',14);
%axis([0.0 0.9,-inf,inf]);
xlabel('Minimum value of device','fontsize',14);
ylabel('Average allocated ratio','fontsize',14);
set(gca,'Fontname','times new Roman');
leng1=legend('TPR','Random');
set(leng1,'position',[0.167261908912943 0.664682545359172 0.267857137588518 0.203571422894796]);
grid;

figure
plot(Value_d(:,1),mean_TPRdpg,'r-x',Value_d(:,1),mean_Rdmdpg,'k-s','markersize',10,'linewidth',1.5);
set(gca,'FontSize',14);
%axis([0.0 0.9,-inf,inf]);
xlabel('Minimum value of device','fontsize',14);
ylabel('Average device profits','fontsize',14);
set(gca,'Fontname','times new Roman');
leng1=legend('TPR','Random');
set(leng1,'position',[0.167261908912943 0.664682545359172 0.267857137588518 0.203571422894796]);
grid;





% current figure 15
% value of service - number of device comparison of TPR Tmn Rdn
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
Num_Cf=100;    % for each D, produce Num_Cf config

D_g=[2,3,4,5,6,7,8,9,10];
%D_g=[3,6,9];
for i_tp4=1:length(D_g)    % iter for the whole D_g
    D=D_g(i_tp4);
    for j_tp4=61:Num_Cf  % for each D, produce Num_Cf config
        mainp;
        tsk(tt,2)=10;   % task size (in task_genp, tsk_tp(:,3)=tsk_tp(:,3).*1.5;)
        
        %begin solving by TPR(TimIniPlusRndLni)
            [TPR_v,TPR_sl]=TiminIniPlusRndIni(tt,rr,stp_Ada,Gm,Iternum)
            TPR_vg(i_tp4,j_tp4)=TPR_v;
        %end solving by TPR
        
        % begin solving by timemin (only time min and no iteration)
            [qkd_tmp1,tim_ac_tmp]=timemin(tt);
            Tmn_vg(i_tp4,j_tp4)=p_value_of_service(qkd_tmp1(1:D-1),tt); 
        % end solving by timemin
        
        % begin solving by random (only Rnd and no iteration)
            [minVoS_tmp,minVoS_sl_tmp]=RdnMinVoS(tt);
            Rdm_vg(i_tp4,j_tp4)=minVoS_tmp;
        % end solving by random
    end
    
    % average and variance over configs
    mean_TPRg(i_tp4)=mean(TPR_vg(i_tp4,:));
    var_TPRg(i_tp4)=var(TPR_vg(i_tp4,:));
    
    mean_Tmng(i_tp4)=mean(Tmn_vg(i_tp4,:));
    var_Tmng(i_tp4)=var(Tmn_vg(i_tp4,:));
    
    mean_Rdmg(i_tp4)=mean(Rdm_vg(i_tp4,:));
    var_Rdmg(i_tp4)=var(Rdm_vg(i_tp4,:));
    save('figure15_tmp.mat');
end

plot(D_g,mean_TPRg,'r-x',D_g,mean_Tmng,'b-o',D_g,mean_Rdmg,'k-s','markersize',10,'linewidth',1.5);
set(gca,'FontSize',14);
%axis([0.0 0.9,-inf,inf]);
xlabel('Number of mobile devices','fontsize',14);
ylabel('Average value of service','fontsize',14);
set(gca,'Fontname','times new Roman');
leng1=legend('ABM','Timemin','Random');
set(leng1,'position',[0.167261908912943 0.664682545359172 0.267857137588518 0.203571422894796]);
grid;
% 
figure
plot(D_g,var_TPRg,'r-x',D_g,var_Tmng,'b-o',D_g,var_Rdmg,'k-s','markersize',10,'linewidth',1.5);
set(gca,'FontSize',14);
%axis([0.0 0.9,-inf,inf]);
xlabel('Number of devices','fontsize',14);
ylabel('Variance of value of service','fontsize',14);
set(gca,'Fontname','times new Roman');
leng1=legend('TPR','Timemin','Random');
set(leng1,'position',[0.167261908912943 0.664682545359172 0.267857137588518 0.203571422894796]);
grid;

% plot(D_g,mean_TPRg,'r-x',D_g,mean_Rdmg,'k-s','markersize',10,'linewidth',1.5);
% set(gca,'FontSize',14);
% %axis([0.0 0.9,-inf,inf]);
% xlabel('Number of devices','fontsize',14);
% ylabel('Average value of service','fontsize',14);
% set(gca,'Fontname','times new Roman');
% leng1=legend('TPR','Random');
% set(leng1,'position',[0.167261908912943 0.664682545359172 0.267857137588518 0.203571422894796]);
% grid;
% 
% figure
% plot(D_g,var_TPRg,'r-x',D_g,var_Rdmg,'k-s','markersize',10,'linewidth',1.5);
% set(gca,'FontSize',14);
% %axis([0.0 0.9,-inf,inf]);
% xlabel('Number of devices','fontsize',14);
% ylabel('Variance of value of service','fontsize',14);
% set(gca,'Fontname','times new Roman');
% leng1=legend('TPR','Random');
% set(leng1,'position',[0.167261908912943 0.664682545359172 0.267857137588518 0.203571422894796]);
% grid;





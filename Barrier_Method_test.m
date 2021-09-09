% figure 14
warning('off');
global D;
clc
tt=1;
rr=0.2;
stp_Ada=0.01;
Gm=0.9;
Iternum=100;      %internal iteration number of GD and GDA
 D=4;
%   mainp;
%   tsk(tt,2)=10;    %for D=4,task_genp?tsk_tp(:,3)=tsk_tp(:,3).*2.5;

mmu=0.8;
eps=1e-2;
mm=D+1;

% begin Random initialization test for RndIniNum points
RndIniNum=50;
%VoSpathRndg=[];
for i_BMt=1:RndIniNum
    rr=0.2;
    VoSpath=[];
    k_BM=0;
    [Qwini_tmp,llini_tmp]=GDini(tt);
    while rr >= eps/mm
        [GDV_Ada,v3sl_Ada,v3v_Ada]=GD_Ada(tt,rr,stp_Ada,Gm,Iternum,Qwini_tmp,llini_tmp);
        for i_BMt1=1:Iternum           
            vl_sr_Ada(i_BMt1)=p_value_of_service(v3sl_Ada(i_BMt1,1:D-1),tt);            
        end
        [maxv,maxp]=max(vl_sr_Ada);      
        k_BM=k_BM+1
        VoSpath(k_BM)=maxv;
        rr=rr*mmu
        Qwini_tmp=v3sl_Ada(maxp,1:D-1);
        llini_tmp=v3sl_Ada(maxp,D);
    end
    VoSpathRndg(i_BMt,:)=VoSpath;
end

for i_BMt2=1:RndIniNum
    leng_path=length(VoSpathRndg(i_BMt2,:));
    plot(1:leng_path,VoSpathRndg(i_BMt2,:),'b--');
    hold on;
end
% end Random initialization test for RndIniNum points

% begin Time ini initialization test
    rr=0.2;
    VoSpathTmin=[];
    k_BM=0;
    % begin try initialized as timemin
     [qkd_tmp1,tim_ac_tmp]=timemin(tt);
    % end try initialized as timemin
    for i_GD=1:D
        tsktm_ini(i_GD)=tsktm(tsk(tt,2)*qkd_tmp1(i_GD),tsk(tt,1),i_GD); 
    end
    llini_tmp=max(tsktm_ini)+0.1;
    Qwini_tmp=qkd_tmp1(1:D-1);
    
    while rr >= eps/mm
        [GDV_Ada,v3sl_Ada,v3v_Ada]=GD_Ada(tt,rr,stp_Ada,Gm,Iternum,Qwini_tmp,llini_tmp);
        for i_BMt=1:Iternum           
            vl_sr_Ada(i_BMt)=p_value_of_service(v3sl_Ada(i_BMt,1:D-1),tt);            
        end
        [maxv,maxp]=max(vl_sr_Ada);      
        k_BM=k_BM+1
        VoSpathTmin(k_BM)=maxv;
        rr=rr*mmu
        Qwini_tmp=v3sl_Ada(maxp,1:D-1);
        llini_tmp=v3sl_Ada(maxp,D);
    end
leng_path=length(VoSpathTmin);
plot(1:leng_path,VoSpathTmin,'r');
hold on;
% end Time ini initialization test


%plot(1:length(VoSpathRndg(1,:)),VoSpathRndg(1,:),'b--o',1:length(VoSpathRndg(2,:)),VoSpathRndg(2,:),'k-s',1:length(VoSpathRndg(3,:)),VoSpathRndg(3,:),'m--*','markersize',10,'linewidth',1.5)

% plot(1:10,VoSpathRndg(1,1:10),'b--o',1:10,VoSpathRndg(2,1:10),'k-s',1:10,VoSpathRndg(3,1:10),'m--*','markersize',10,'linewidth',1.5)
% set(gca,'FontSize',14);
% xlabel('Number of iterations','fontsize',14);
% ylabel('Value of service','fontsize',14);
% set(gca,'Fontname','times new Roman');
% leng1=legend('RndIni1','RndIni2','RndIni3');
% set(leng1,'position',[0.658333336366784 0.223611116823223 0.192857139823692 0.204761899014314]);
% grid;

% for D=4:
% plot(1:20,VoSpath(1,1:20),'k-s','markersize',10,'linewidth',1.5);
% hold on;
% plot(1:20,VoSpathRndg(1,1:20),'b--o','markersize',10,'linewidth',1.5)
% hold on;
% plot(1:20,VoSpathRndg(3,1:20),'r-x','markersize',10,'linewidth',1.5)
% hold on;
% plot(1:20,VoSpathRndg(4,1:20),'m--*','markersize',10,'linewidth',1.5)
% set(gca,'FontSize',14);
% %axis([1 20,-inf,inf]);
% xlabel('Number of iterations','fontsize',14);
% ylabel('Value of service','fontsize',14);
% set(gca,'Fontname','times new Roman');
% leng1=legend('TimMinIni','RndIni1','RndIni2','RndIni3');
% set(leng1,'position',[0.636904765417178 0.299801593013699 0.224999996008618 0.204761899014314]);
% grid;

% for D=7:
plot(1:12,VoSpathTmin(1,1:12),'k-s','markersize',12,'linewidth',1.5);
hold on;
plot(1:12,VoSpathRndg(1,1:12),'b--o','markersize',12,'linewidth',1.5)
hold on;
plot(1:12,VoSpathRndg(4,1:12),'r-x','markersize',12,'linewidth',1.5)
hold on;
plot(1:12,VoSpathRndg(6,1:12),'m--*','markersize',12,'linewidth',1.5)
set(gca,'FontSize',14);
%axis([1 12,-inf,inf]);
xlabel('Number of iterations','fontsize',14);
ylabel('Value of service','fontsize',14);
set(gca,'Fontname','times new Roman');
leng1=legend('ABM','RndIni1','RndIni2','RndIni3');
set(leng1,'position',[0.619047622560035 0.368849212161218 0.224999996008618 0.124761899014314]);
grid;

% for D=3:
% plot(1:12,VoSpathTmin(1,1:12),'k-s','markersize',12,'linewidth',1.5);
% hold on;
% plot(1:12,VoSpathRndg(87,1:12),'b--o','markersize',12,'linewidth',1.5)
% hold on;
% plot(1:12,VoSpathRndg(157,1:12),'r-x','markersize',12,'linewidth',1.5)
% hold on;
% plot(1:12,VoSpathRndg(155,1:12),'m--*','markersize',12,'linewidth',1.5)
% set(gca,'FontSize',14);
% %axis([1 12,-inf,inf]);
% xlabel('Number of iterations','fontsize',14);
% ylabel('Value of service','fontsize',14);
% set(gca,'Fontname','times new Roman');
% leng1=legend('TimMinIni','RndIni1','RndIni2','RndIni3');
% set(leng1,'position',[0.619047622560035 0.368849212161218 0.224999996008618 0.124761899014314]);
% grid;

% for D=4:
% plot(1:15,VoSpathTmin(1,1:15),'k-s','markersize',12,'linewidth',1.5);
% hold on;
% plot(1:15,VoSpathRndg(9,1:15),'b--o','markersize',10,'linewidth',1.5)
% hold on;
% plot(1:15,VoSpathRndg(42,1:15),'r-x','markersize',10,'linewidth',1.5)
% hold on;
% plot(1:15,VoSpathRndg(35,1:15),'m--*','markersize',10,'linewidth',1.5)
% set(gca,'FontSize',14);
% %axis([1 20,-inf,inf]);
% xlabel('Number of iterations','fontsize',14);
% ylabel('Value of service','fontsize',14);
% set(gca,'Fontname','times new Roman');
% leng1=legend('ABM','RndIni1','RndIni2','RndIni3');
% set(leng1,'position',[0.638690479702892 0.228373021585128 0.224999996008618 0.204761899014314]);
% grid;








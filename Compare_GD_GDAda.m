   
%figure for compare GD and GD-Delta
% clear

  global D;
  D=4;
 mainp;
 
clc
tt=1;
rr=0.02;
stp_ori=0.01;
stp_Ada=0.01;
Gm=0.9;
Iternum=100;


qkd_tmp=rand(1,D);
qkd_tmpsum=sum(qkd_tmp);
qkd_tmp1=qkd_tmp/qkd_tmpsum;
% begin try initialized as timemin
 [qkd_tmp1,tim_ac_tmp]=timemin(tt);
% end try initialized as timemin
for i_GD=1:D
    tsktm_ini(i_GD)=tsktm(tsk(tt,2)*qkd_tmp1(i_GD),tsk(tt,1),i_GD); 
end
ll_ini=max(tsktm_ini)+0.1;
Qw_ini=qkd_tmp1(1:D-1);
    
%    ll_ini=0.287022423354806;                 
%   Qw_ini=[0.0842547888530702,0.0967693670237650,0.129934115194481,0.167841302417458,0.0428020880305004,0.0551742833910300,0.0725555500792704,0.166312558770882,0.0739926709229622];
[GDV_ori,v3sl_ori,v3v_ori]=GD_ori(tt,rr,stp_ori,Iternum,Qw_ini,ll_ini);
[GDV_Ada,v3sl_Ada,v3v_Ada]=GD_Ada(tt,rr,stp_Ada,Gm,Iternum,Qw_ini,ll_ini);


%plot(1:length(v3v_ori),v3v_ori,'r-',1:length(v3v_Ada),v3v_Ada,'b.');
%plot(1:10:1000,v3v_ori(1:10:1000),'r-',1:10:1000,v3v_Ada(1:10:1000),'b--')
%plot(1:20:1000,v3v_ori(1:20:1000),'r-',1:20:1000,v3v_Ada(1:20:1000),'b--','linewidth',1.5)
%plot(1:2:100,v3v_ori(1:2:100),'r-',1:2:100,v3v_Ada(1:2:100),'b--','linewidth',1.5)
plot(1:Iternum/50:Iternum,v3v_ori(1:Iternum/50:Iternum),'r-',1:Iternum/50:Iternum,v3v_Ada(1:Iternum/50:Iternum),'b--','linewidth',1.5)
axis([0 Iternum,-inf,inf]);
set(gca,'FontSize',14);
xlabel('Number of iterations','fontsize',14);
ylabel('Value of objective function','fontsize',14);
set(gca,'Fontname','times new Roman');
leng1=legend('GD','AGD');
set(leng1,'position',[0.633333336526439 0.631349212025839 0.203571425218667 0.203571422894796]);
grid;

figure
%for i=1:size(v3sl_ori,1)
for i=1:Iternum
    vl_sr_ori(i)=p_value_of_service(v3sl_ori(i,1:D-1),tt);
    vl_sr_Ada(i)=p_value_of_service(v3sl_Ada(i,1:D-1),tt);
end
%plot(1:20:1000,vl_sr_ori(1:20:1000),'r-',1:20:1000,vl_sr_Ada(1:20:1000),'b--','linewidth',1.5)
%plot(1:2:100,vl_sr_ori(1:2:100),'r-',1:2:100,vl_sr_Ada(1:2:100),'b--','linewidth',1.5)
plot(1:Iternum/50:Iternum,vl_sr_ori(1:Iternum/50:Iternum),'r-',1:Iternum/50:Iternum,vl_sr_Ada(1:Iternum/50:Iternum),'b--','linewidth',1.5)
axis([0 Iternum,-inf,inf]);
set(gca,'FontSize',14);
xlabel('Number of iterations','fontsize',14);
ylabel('Value of service','fontsize',14);
set(gca,'Fontname','times new Roman');
leng1=legend('GD','AGD');
set(leng1,'position',[0.647619050812153 0.198015878692506 0.203571425218667 0.203571422894796]);
grid;










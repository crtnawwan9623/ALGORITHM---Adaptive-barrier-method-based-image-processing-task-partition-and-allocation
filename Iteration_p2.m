% previous figure 15
warning('off');
global D;
global j_tp1;
global tsk;
global device;
clc
tt=1;
rr=0.02;
stp_Ada=0.01;
Gm=0.9;
Iternum=100;      %internal iteration number of GD and GDA
Iter_perD=10;    % for each D, produce Iter_perD config
Iter_perconf=10; % for each config, produce Iter_perconf ini values and calculate corresponding optimal solution

D_g=[2,3,4];
for i_tp1=1:length(D_g)    % iter for the whole D_g
    D=D_g(i_tp1);
    for j_tp1=1:Iter_perD  % for each D, produce Iter_perD config
        mainp;
        maxvg_Ada_perconf=[];
        
        %begin solving by iteration of Ada for a config
        for k_tp1=1:Iter_perconf       % for each config, produce Iter_perconf ini values and calculate corresponding optimal solution
           
            [Qwini_tmp,llini_tmp]=GDini(tt);       
              [GDV_Ada,v3sl_Ada,v3v_Ada]=GD_Ada(tt,rr,stp_Ada,Gm,Iternum);
           
            for m_tp1=1:Iternum           
                vl_sr_Ada(m_tp1)=p_value_of_service(v3sl_Ada(m_tp1,1:D-1),tt);            
            end
            [maxv,maxp]=max(vl_sr_Ada);      % for each ini, the optimal value is the max value in the iter process
            maxvg_Ada_perconf(k_tp1)=maxv;
        end
        maxv_Ada_perconf=max(maxvg_Ada_perconf);  % for each config, the optimal value is the max value over all ini values
        maxvg_Ada_perD(j_tp1)=maxv_Ada_perconf;
        %end solving by iteration of Ada for a config
        
        % begin solving by initialization as timemin
        [qkd_tmp1,tim_ac_tmp]=timemin(tt);
        for n_tp1=1:D
            tsktm_ini(n_tp1)=tsktm(tsk(tt,2)*qkd_tmp1(n_tp1),tsk(tt,1),n_tp1); 
        end
        llini_tmp=max(tsktm_ini)+0.1;
        Qwini_tmp=qkd_tmp1(1:D-1);
        [GDV_Ada,v3sl_Ada,v3v_Ada]=GD_Ada(tt,rr,stp_Ada,Gm,Iternum,Qwini_tmp,llini_tmp);
        for m_tp1=1:Iternum           
            vl_sr_Ada(m_tp1)=p_value_of_service(v3sl_Ada(m_tp1,1:D-1),tt);            
        end
        [maxv,maxp]=max(vl_sr_Ada);      % for each ini, the optimal value is the max value in the iter process
        maxvg_Adatmin_perD(j_tp1)=maxv;
        % end try initialized as timemin
        
        % begin solving by random number
        [Qwini_tmp,llini_tmp]=GDini(tt); 
        maxvg_Rdn_perD(j_tp1)=p_value_of_service(Qwini_tmp,tt); 
        % end solving by random number
      
    end
    
    % average over all optimal solutions of different conf. for each D
    meanvg_Ada_perD(i_tp1)=mean(maxvg_Ada_perD);  
    meanvg_Adatmin_perD(i_tp1)=mean(maxvg_Adatmin_perD);
    meanvg_Rdn_perD(i_tp1)=mean(maxvg_Rdn_perD);
    
    varvg_Ada_perD(i_tp1)=var(maxvg_Ada_perD);
    varvg_Adatmin_perD(i_tp1)=var(maxvg_Adatmin_perD);
    varvg_Rdn_perD(i_tp1)=var(maxvg_Rdn_perD);
    
end

plot(D_g,meanvg_Adatmin_perD,'r--x',D_g,meanvg_Ada_perD,'b-o',D_g,meanvg_Rdn_perD,'k-s','markersize',10,'linewidth',1.5)
set(gca,'FontSize',14);
%axis([0.0 0.9,-inf,inf]);
xlabel('Number of devices','fontsize',14);
ylabel('Value of service','fontsize',14);
set(gca,'Fontname','times new Roman');
leng1=legend('GD-delta-tmin','GD-delta','Random');
set(leng1,'position',[0.167261908912943 0.664682545359172 0.267857137588518 0.203571422894796]);
grid;

figure
plot(D_g,varvg_Adatmin_perD,'r--x',D_g,varvg_Ada_perD,'b-o',D_g,varvg_Rdn_perD,'k-s','markersize',10,'linewidth',1.5)
set(gca,'FontSize',14);
%axis([0.0 0.9,-inf,inf]);
xlabel('Number of devices','fontsize',14);
ylabel('Variance of value of service','fontsize',14);
set(gca,'Fontname','times new Roman');
leng1=legend('GD-delta-tmin','GD-delta','Random');
set(leng1,'position',[0.567261908912943 0.683730164406791 0.267857137588518 0.203571422894796]);
grid;


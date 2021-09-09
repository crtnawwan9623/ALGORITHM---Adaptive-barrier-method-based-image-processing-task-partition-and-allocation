function [BM_v,BM_sl,VoSpath]=Barrier_Method(tt,rr,stp_Ada,Gm,Iternum,Qwini,llini)
% Use Barrier method to solve the GDA problem
% BM_v: service of value of optimal point  
% BM_sl: solution of optimal point [Qw,ll]
% VoSpath: iteration trajactory
    global D;
    global k_BM;
    mmu=0.8;
    eps=1e-2;
    mm=D+1;
    VoSpath=[];
    k_BM=0;
 %   [Qwini_tmp,llini_tmp]=GDini(tt);
    Qwini_tmp=Qwini;
    llini_tmp=llini;
    BM_vtmp=[];
    BM_sltmp=[];
    while rr >= eps/mm
        [GDV_Ada,v3sl_Ada,v3v_Ada]=GD_Ada(tt,rr,stp_Ada,Gm,Iternum,Qwini_tmp,llini_tmp);
        for i_BM=1:Iternum           
            vl_sr_Ada(i_BM)=p_value_of_service(v3sl_Ada(i_BM,1:D-1),tt);            
        end
        [maxv,maxp]=max(vl_sr_Ada);      
        k_BM=k_BM+1;
        VoSpath(k_BM)=maxv;
        
        rr=rr*mmu;
        Qwini_tmp=v3sl_Ada(maxp,1:D-1);
        llini_tmp=v3sl_Ada(maxp,D);

        BM_vtmp=maxv;
        BM_sltmp=[Qwini_tmp,llini_tmp];
    end
%     leng_path=length(VoSpath);
%     plot(1:leng_path,VoSpath);

    BM_v=BM_vtmp;
    BM_sl=BM_sltmp;

end
function Asmt_aftr=Exhaustive(pr_tab)

tskn=size(pr_tab,2);
devn=size(pr_tab,1);

Asmt_tmp=[];
vl_tmp=0;

if devn < tskn  % if D<T
    pertsk=myper(1:tskn,devn);
    pertsk_num=size(pertsk,1);
    for i=1:pertsk_num
        Asmt_ini=zeros(size(pr_tab));
        for k=1:devn
         Asmt_ini(k,pertsk(i,k))=1;
        end
        v_new=value_of_service(pr_tab,Asmt_ini);
        if v_new > vl_tmp
            vl_tmp=v_new;
            Asmt_tmp=Asmt_ini;
        end
    end
end

if devn > tskn  % if D>T
    perdev=myper(1:devn,tskn);
    perdev_num=size(perdev,1);
    for i=1:perdev_num
        Asmt_ini=zeros(size(pr_tab));
        for k=1:tskn
         Asmt_ini(perdev(i,k),k)=1;
        end
        v_new=value_of_service(pr_tab,Asmt_ini);
        if v_new > vl_tmp
            vl_tmp=v_new;
            Asmt_tmp=Asmt_ini;
        end
    end
end

if devn == tskn  % if D=T
    
    pertsk=perms(1:tskn);
    pertsk_num=size(pertsk,1);
    
    for i=1:pertsk_num
        Asmt_ini=zeros(size(pr_tab));
        for k=1:devn
         Asmt_ini(k,pertsk(i,k))=1;
        end
        v_new=value_of_service(pr_tab,Asmt_ini);
        if v_new > vl_tmp
            vl_tmp=v_new;
            Asmt_tmp=Asmt_ini;
        end
    end
end

Asmt_aftr=Asmt_tmp;

end
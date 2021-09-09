function Asmt_aftr=exchange_t(pr_tab,Asmt_old,tk1,tk2)

devn=size(pr_tab,1); %device number =D
vl_old=value_of_service(pr_tab,Asmt_old);

Asmt_new=Asmt_old;
Asmt_temp=Asmt_old;

Asmt_temp(:,tk1)=Asmt_old(:,tk2);
Asmt_temp(:,tk2)=Asmt_old(:,tk1);

vl_tmp=value_of_service(pr_tab,Asmt_temp);

if vl_tmp>vl_old
    Asmt_new=Asmt_temp;
end
Asmt_aftr=Asmt_new;
end
function Asmt_aftr=exchange_d(pr_tab,Asmt_old,dv1,dv2)
% invoked only when D<T, that is,  # of device less than # of task 

tskn=size(pr_tab,2);
vl_old=value_of_service(pr_tab,Asmt_old);

Asmt_new=Asmt_old;
Asmt_temp=Asmt_old;
Asmt_temp(dv1,:)=Asmt_old(dv2,:);
Asmt_temp(dv2,:)=Asmt_old(dv1,:);
vl_tmp=value_of_service(pr_tab,Asmt_temp);

if vl_tmp>vl_old
    Asmt_new=Asmt_temp;
end
Asmt_aftr=Asmt_new;

end 

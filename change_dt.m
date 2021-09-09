function Asmt_aftr=change_dt(pr_tab,Asmt_old)

% invoked only when D=T, that is,  # of device less than # of task 
global Eb;
devn=size(pr_tab,1); %device number =D
nn=(size(pr_tab,1)*size(pr_tab,2))^2;

vl_old=value_of_service(pr_tab,Asmt_old);
Asmt_temp=Asmt_old;

first_rd=1;
j=1;
dd=nchoosek(1:devn,2);
ddrow=size(dd,1);
while  first_rd==1 || j <= ddrow
    first_rd=0;
    Asmt_new=exchange_d(pr_tab,Asmt_temp,dd(j,1),dd(j,2));
    vl_tmp=value_of_service(pr_tab,Asmt_new);
    if vl_tmp > vl_old*(1+Eb/nn)
          Asmt_temp=Asmt_new;
          vl_old=vl_tmp;
          j=1;
    else
          j=j+1;
    end
end

Asmt_aftr=Asmt_temp;

end
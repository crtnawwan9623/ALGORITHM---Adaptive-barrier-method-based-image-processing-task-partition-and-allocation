function Asmt_aftr=change_t(pr_tab,Asmt_old)
% invoked only when D>T, that is,  # of device less than # of task 
global Eb;
tskn=size(pr_tab,2); %task number
nn=(size(pr_tab,1)*size(pr_tab,2))^2;

vl_old=value_of_service(pr_tab,Asmt_old);
Asmt_temp=Asmt_old;

first_rd=1;
while first_rd==1 || flag_exd==1
    first_rd=0;
    i=1; % next task under transfer test
    while i <= tskn
        Asmt_new=transfer_t(pr_tab,Asmt_temp,i);
        vl_tmp=value_of_service(pr_tab,Asmt_new);
        if vl_tmp > vl_old*(1+Eb/nn)
              Asmt_temp=Asmt_new;
              vl_old=vl_tmp;
              i=1;
        else
            i=i+1;
        end
    end
    t2t=nchoosek(1:tskn,2);
    ttrow=size(t2t,1);
    j=1; % next task pair under exchange test
    flag_exd=0;
    while j <= ttrow && flag_exd==0
        Asmt_new=exchange_t(pr_tab,Asmt_temp,t2t(j,1),t2t(j,2));
        vl_tmp=value_of_service(pr_tab,Asmt_new);
        if vl_tmp > vl_old*(1+Eb/nn)
              Asmt_temp=Asmt_new;
              vl_old=vl_tmp;
              flag_exd=1;
        else
            j=j+1;
        end
    end
end
Asmt_aftr=Asmt_temp;
end
global device;
for k_dg2=1:D

flag_dg2=0;
    while flag_dg2 ==0
        dev_temp=0.1*randperm(10,2);
        maxdev=max(dev_temp);
        mindev=min(dev_temp);
       %if maxdev-mindev > 0.5
       if maxdev-mindev <0.5
        %if maxdev ~= mindev
           flag_dg2=1;
        end
    end
    device(k_dg2,2)=mindev;%device element 2-3 : min value, max value
    device(k_dg2,3)=maxdev;
    %device(k_dg2,3)=mindev+0.01;
    
    tsknum=sum(gw_tsk_num);
    E_tsk=zeros(1,tsknum);
    for i_dg2=1:tsknum
        E_tsk(i_dg2)=energy_consp(tsk(i_dg2,2),device(k_dg2,1),device(k_dg2,6));
    end 
    E_tskmin=min(E_tsk);
    E_tskmax=max(E_tsk);
    
    flag1_dg2=0;
    while flag1_dg2==0
            temp=sort(rand(1,2));
            randmin=temp(1);
            randmax=temp(2);
           %if  randmax - randmin < 0.1 % previous figure 8: 10/17/2018
            if  randmax - randmin < 0.5
               flag1_dg2=1;
            end
    end  
    device(k_dg2,4)=(E_tskmax-E_tskmin)*randmin+E_tskmin;%device element 4-5 : sftthhd,hdthhd
    device(k_dg2,5)=(E_tskmax-E_tskmin)*randmax+E_tskmin;
    %device(k_dg2,5)=(E_tskmax-E_tskmin)*(randmin+0.01)+E_tskmin;
end




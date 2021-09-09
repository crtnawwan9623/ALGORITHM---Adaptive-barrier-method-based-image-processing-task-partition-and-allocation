function Asmt_aftr=Greedy(pr_tab)
%greedy algorithm
% randomly order the device or task and choose the best available
% assignment for each one by one

tskn=size(pr_tab,2);
devn=size(pr_tab,1);

if devn < tskn  % if D<T
    devn_order=randperm(devn);
    Asmt_tmp=zeros(size(pr_tab));
    for i=1:devn
        unasg_tsk_tmp=ones(1,tskn);
        asg_task=sum(Asmt_tmp);
        unasg_tsk=unasg_tsk_tmp-asg_task; % unassigned task is 1, and assigned task is 0
        unasg_tsk_vl=pr_tab(devn_order(i),:).*unasg_tsk; %unassigned task-device value
        [maxvl,maxpos]=max(unasg_tsk_vl); % available task assign position corresponding to the max value
        Asmt_tmp(devn_order(i),maxpos)=1;
    end
end

if devn > tskn  % if D>T
    tskn_order=randperm(tskn);
    Asmt_tmp=zeros(size(pr_tab));
    for i=1:tskn
        %check unassigned device
        unasg_dev_tmp=ones(devn,1);
        asg_dev=sum(Asmt_tmp,2);
        unasg_dev=unasg_dev_tmp-asg_dev; % unassigned dev is 1, and assigned dev is 0
        unasg_dev_vl=pr_tab(:,tskn_order(i)).*unasg_dev; %unassigned task-device value
        [maxvl,maxpos]=max(unasg_dev_vl); % available dev assign position corresponding to the max value
        Asmt_tmp(maxpos,tskn_order(i))=1;
    end
end

if devn == tskn  % if D=T
    devn_order=randperm(devn)
    Asmt_tmp=zeros(size(pr_tab));
    for i=1:devn
        unasg_tsk_tmp=ones(1,tskn);
        asg_task=sum(Asmt_tmp);
        unasg_tsk=unasg_tsk_tmp-asg_task; % unassigned task is 1, and assigned task is 0
        unasg_tsk_vl=pr_tab(devn_order(i),:).*unasg_tsk; %unassigned task-device value
        [maxvl,maxpos]=max(unasg_tsk_vl);% available task assign position corresponding to the max value
        Asmt_tmp(devn_order(i),maxpos)=1;
    end 
end
Asmt_aftr=Asmt_tmp;
end
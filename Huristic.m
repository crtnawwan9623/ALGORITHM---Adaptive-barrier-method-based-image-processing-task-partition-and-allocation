function Asmt_aftr=Huristic(pr_tab)

tskn=size(pr_tab,2);
devn=size(pr_tab,1);

%initialize assig
Asmt_ini=zeros(size(pr_tab));
if devn < tskn  % if D<T
    rdasgtsk=randperm(tskn,devn);
    for i=1:devn
        Asmt_ini(i,rdasgtsk(i))=1;
    end
end

if devn > tskn  % if D>T
    rdasgdev=randperm(devn,tskn);
    for i=1:tskn
        Asmt_ini(rdasgdev(i),i)=1;
    end
end

if devn == tskn  % if D=T
    rdasg=randperm(devn,devn);
    for i=1:devn
        Asmt_ini(i,rdasg(i))=1;
    end
end

% start change
Asmt_new=Asmt_ini;

if devn < tskn  % if D<T
Asmt_new=change_d(pr_tab,Asmt_ini);
end

if devn > tskn  % if D>T
Asmt_new=change_t(pr_tab,Asmt_ini);
end

if devn == tskn  % if D=T
Asmt_new=change_dt(pr_tab,Asmt_ini);
end
% end change
Asmt_aftr=Asmt_new;
end





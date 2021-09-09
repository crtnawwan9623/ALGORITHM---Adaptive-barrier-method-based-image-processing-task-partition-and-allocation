
global Simu_Time;
global Cpu_thpt;
global  Cpu_ut;
global device;
device=zeros(D,6);
%for binary offloading:
CPU_Array=[2.0,2.5,3.0,3.5,4.0,4.5,5.0,5.5,6.0,6.5,7.0,7.5,8.0]; 
%CPU_Array=[1,3,6,8];

%for partial offloading:
%CPU_Array=[2.0,2.1,2.2];
% CPU_Array=[1.5,2.0,2.5,3.0];

for k_dg1=1:D
Cpu_frq=CPU_Array(randperm(size(CPU_Array,2),1));
device(k_dg1,1)=Cpu_frq;
%device(k_dg1,6)=5e-27*k_dg1/D;
device(k_dg1,6)=5e-27*rand(1);
end

Simu_Time=60; %60s
Cpu_ut=zeros(D,Simu_Time*1000);
for k_dg1=1:D
    u=0;
    for i_dg1=1:Simu_Time*10  %for every 100ms within the simu time  
        Cpu_ut_temp=0.1*randperm(10,1)*ones(1,100);
        Cpu_ut(k_dg1,u+1:u+100)= Cpu_ut_temp;
        u=u+100;
    end
end

Cpu_thpt=zeros(D,Simu_Time*1000);
for k_dg1=1:D
    for i_dg1=1:Simu_Time*1000  %for every 1ms 
        
        if i_dg1 == 1
            Cpu_thpt(k_dg1,i_dg1)=(1e-3)*device(k_dg1,1)*1e9*Cpu_ut(k_dg1,i_dg1);
        else
            Cpu_thpt(k_dg1,i_dg1)=Cpu_thpt(k_dg1,i_dg1-1)+(1e-3)*device(k_dg1,1)*1e9*Cpu_ut(k_dg1,i_dg1);
        end
        
    end 
end



%plot([1:10000],Cpu_ut(2,:)),axis([0 10000 -2.0 2.0])
%plot([1:10000],Cpu_thpt(2,:));
%plot([1:10000],Cpu_thpt(2,:),[1:10000],Cpu_ut(2,:));


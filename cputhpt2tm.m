function tm=cputhpt2tm(d,cputhpt)
% return consumed time to provide given cpu throughput cputhpt for a given
% device d
% return unit tm:s
global Simu_Time;
global Cpu_thpt;

x=Cpu_thpt(d,:);
y=1:Simu_Time*1000;

if cputhpt >= Cpu_thpt(d,1)
tm=interp1(x,y,cputhpt);
else
tm=interp1([0,x(1)],[0,y(1)],cputhpt);
end
tm=tm/1000;
end 
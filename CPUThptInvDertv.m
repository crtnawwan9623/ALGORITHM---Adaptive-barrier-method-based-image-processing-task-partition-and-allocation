function Idertv=CPUThptInvDertv(d,cputhpt)

% return derivative of Id, which is the inverse function of Ud(CPU throuput function)
global device;
global Cpu_ut;


tm_tmp=round(1000*cputhpt2tm(d,cputhpt)); %unit s-->ms
if tm_tmp<1
    tm_tmp=1;
end
Udertv=device(d,1)*1e9*Cpu_ut(d,tm_tmp);
Idertv=1/Udertv;

end
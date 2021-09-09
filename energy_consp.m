function E=energy_consp(ts,dcpuf,cpu_cef)
% return the energy consumption (J) of a device with CPU frequency dcpuf(GHz) to
% process a task with size ts(Mbit)
% ts:task size unit:Mb
% dcputf: CPU Frequency  unit:GHz
% cpu_cef: k parameter
global Ct;
%C=737.5;
%k=5e-27;
k=cpu_cef;
E=ts*1e6*Ct*k*(dcpuf*1e9)^2; %task size unit Mbit;Cpu freq unit GHz
end 
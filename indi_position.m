function [x,y]=indi_position

s=rand(1);
theta=2*pi*rand(1);
x=20*sqrt(s).*cos(theta);
y=20*sqrt(s).*sin(theta);
%plot(x,y,'.','markersize',1)
end
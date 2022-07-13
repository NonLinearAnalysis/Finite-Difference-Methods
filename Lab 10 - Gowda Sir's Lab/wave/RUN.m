close all;
clear all;

%domain
x0=-10; xf=10;
t0=-5;   tf=5;

%parameters
N=400;
h=(xf-x0)/N;
mu=1;
dt=mu*h;
M=fix((tf-t0)/dt);

%vectors
x=zeros(N+1,1);
yp1=zeros(N+1,1);
yp2=zeros(N+1,1);
yq=zeros(N+1,1);
uex=zeros(N+1,1);

%initial cond
for i=1:N+1
    x(i)=x0+(i-1)*h;
    yp1(i)=wave_in(x(i));
end

%plotting initial profile
figure(1);
plot(x,yp1);
title('initial profile');

%calculating yp2 at t=t0+dt
yp2(1)=0;
for i=2:N
    yp2(i)=0.5*(mu^2*yp1(i-1) + 2*(1-mu^2)*yp1(i) + mu^2*yp1(i+1));
end
yp2(N+1)=0;

%time loop
t=dt;
for k=1:(M-1)
    t=t+dt;
    
    yq(1)=0;
    for i=2:N
        yq(i)=2*yp2(i)-yp1(i)+mu^2*(yp2(i-1)-2*yp2(i)+yp2(i+1));
    end
    yq(N+1)=0;
    
%     for i=1:N+1
%         uex(i)=wave_ex(t,x(i));
%     end
    
    
    figure(2);
    plot(x,yq);
    ylim([0 1])
    pause(0.1)
    
    yp1=yp2;
    yp2=yq;
end


error=max(abs(uex-yq))




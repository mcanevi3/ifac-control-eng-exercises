%%% Lets design a PD controller
clear;clc;
qdefs;

syms s;
syms p1 p0 real;

p0=p0max;
p1=p1max;

ns=1;
ds=(s+p1)*(s+p0);
Gss=ns/ds;

%% root locus critical point 
sigma=(p0+p1)/2;
ts=4/sigma; % settling time possible

%% desired settling time
tsdes=2/sigma;
sigmades=4/tsdes;

os=10/100;
zeta=-log(os)/sqrt(log(os)^2+pi^2);
wn=sigmades/zeta;
wd=wn*sqrt(1-zeta^2);

%% angle condition
theta0=atan2d(wd,-zeta*wn+p0)
theta1=atan2d(wd,-zeta*wn+p1)
thetaz=theta0+theta1-180;

dz=wd/tand(thetaz);
zval=zeta*wn+dz;

figure(1);clf;
Gs=tf(1,conv([1,p0],[1,p1]));
Gs2=tf([1,zval],1)*Gs;

rlocus(Gs,'k',Gs2,'b');hold on;grid on;
plot(-zeta*wn*ones(1,2),[-wd,wd],'r');

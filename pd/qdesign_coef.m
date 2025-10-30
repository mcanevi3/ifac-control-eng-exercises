clear;clc;
qdefs;

syms s;
syms x1 x0 real;

p0=p0min+(p0max-p0min)*(10*x1+x0)/99;
p1=p1min+(p1max-p1min)*(10*x1+x0)/99;
zeta=0.5+0.1*(10*x1+x0)/99;

ns=1;
ds=(s+p1)*(s+p0);
ds=collect(expand(ds),s);

syms k z real;
pcs=ds+ns*k*(s+z);
pcs=collect(expand(pcs),s);

sigma=(p0+p1)/2;
tsdes=2/sigma;
sigmades=4/tsdes;

wn=sigmades/zeta;
pds=s^2+2*zeta*wn*s+wn^2;

prob=coeffs(pcs,s,'all')==coeffs(pds,s,'all');

sol=solve(prob,[k,z]);

funk=matlabFunction(sol.k);
funz=matlabFunction(sol.z);
funp0=matlabFunction(p0);
funp1=matlabFunction(p1);
funzeta=matlabFunction(zeta);
funwn=matlabFunction(wn);
%% test
x0val=9;
x1val=9;
kval=funk(x0val,x1val);
zval=funz(x0val,x1val);
zeta=funzeta(x0val,x1val);
wn=funwn(x0val,x1val);
wd=wn*sqrt(1-zeta^2);

figure(1);clf;
Gs=tf(1,conv([1,funp0(x0val,x1val)],[1,funp1(x0val,x1val)]));
Gs2=tf([1,zval],1)*Gs;

rlocus(Gs,'k',Gs2,'b');hold on;grid on;
plot(-zeta*wn*ones(1,2),[-wd,wd],'r');
plot([0,-10],[0,10*tand(acosd(zeta))],'k');


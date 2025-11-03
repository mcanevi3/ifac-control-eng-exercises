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

%% TODO: define all choices in terms of x1,x0 correct or false
funzfalse1=matlabFunction(180-sol.z);

clear;clc;
syms s;
syms p0 p1 k z real
ns=1;
ds=(s+p1)*(s+p0);
ds=collect(expand(ds),s);

syms k z real;
pcs=ds+ns*k*(s+z);
pcs=collect(expand(pcs),s);

sigma=(p0+p1)/2;
tsdes=2/sigma;
sigmades=4/tsdes;

syms zeta real;
wn=sigmades/zeta;
wdes=sqrt(1-zeta^2)*wn;
pds=s^2+2*zeta*wn*s+wn^2;

prob=coeffs(pcs,s,'all')==coeffs(pds,s,'all');

sol=solve(prob,[k,z]);
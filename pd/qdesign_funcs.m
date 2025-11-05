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
wdes=sqrt(1-zeta^2)*wn;
pds=s^2+2*zeta*wn*s+wn^2;

prob=coeffs(pcs,s,'all')==coeffs(pds,s,'all');

sol=solve(prob,[k,z]);

funk=matlabFunction(sol.k);
funz=matlabFunction(sol.z);
funp0=matlabFunction(p0);
funp1=matlabFunction(p1);
funzeta=matlabFunction(zeta);
funwn=matlabFunction(wn);

angleZero=atan2d(wdes, -sigmades+p0);
angleOne=atan2d(wdes, -sigmades+p1);
anglezVal=atan2d(wdes, -sigmades+sol.z);

fun_angleZero=matlabFunction(angleZero);
fun_angleOne=matlabFunction(angleOne);
fun_anglezVal=matlabFunction(anglezVal);

fun_angleCorrect=matlabFunction(angleZero+angleOne-anglezVal);
fun_angleFalse1=matlabFunction(angleZero+angleOne+180-anglezVal);
fun_angleFalse2=matlabFunction(180-angleZero+angleOne+anglezVal);
fun_angleFalse3=matlabFunction(angleZero+180-angleOne+anglezVal);
fun_angleFalse4=matlabFunction(angleZero+angleOne+anglezVal);

% %% 
% syms p0 p1 k z real
% ns=1;
% ds=(s+p1)*(s+p0);
% ds=collect(expand(ds),s);

% syms k z real;
% pcs=ds+ns*k*(s+z);
% pcs=collect(expand(pcs),s);

% sigma=(p0+p1)/2;
% tsdes=2/sigma;
% sigmades=4/tsdes;

% wn=sigmades/zeta;
% wdes=sqrt(1-zeta^2)*wn;
% pds=s^2+2*zeta*wn*s+wn^2;

% prob=coeffs(pcs,s,'all')==coeffs(pds,s,'all');

% sol=solve(prob,[k,z]);
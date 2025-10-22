clear;clc;

zetavec=1:5;
wnvec=5:10;

syms s t;
syms zeta wn real;

Gss=1/((s^2+2*zeta*wn*s+wn^2)*(s+4));
%% zeta>1 case
% yt=ilaplace(Gss,s,t);
% latex(yt)
%% 0<zeta<1 case
yt=ilaplace(Gss,s,t);
yt

% ytval=subs(yt,[zeta,wn],[0.1,2]);
% ytval

% tvec=0:0.01:10;
% yvec=double(subs(ytval,t,tvec));
% plot(tvec,yvec)

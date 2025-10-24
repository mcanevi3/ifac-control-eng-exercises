clear;clc;

syms s x zeta wn real
assumeAlso([zeta wn] > 0)

Gss = 1/((s^2 + 2*zeta*wn*s + wn^2)*(s + 4));
yt = ilaplace(Gss, s, x);

%% underdamped case
syms wd real
yt_under = subs(yt, sqrt(zeta^2-1),1i*sqrt(1 - zeta^2));
yt_under = subs(yt_under,wn*sqrt(1 - zeta^2),wd);
yt_under=simplify(yt_under);
yt_under
% latex(yt)

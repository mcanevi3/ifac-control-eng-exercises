%% Lets design a PD controller - a numeric example design
clear;clc;
qdesign_funcs;
qdefs;
x0val=x0(1);
x1val=x1(1);

kval=funk(x0val,x1val);
zval=funz(x0val,x1val);
p0val=funp0(x0val,x1val);
p1val=funp1(x0val,x1val);
zetaval=funzeta(x0val,x1val);
wnval=funwn(x0val,x1val);

wdval=sqrt(1-zetaval^2)*wnval;
sdes=-zetaval*wnval+1i*wdval;

d0=sdes-(-p0val);
d1=sdes-(-p1val);
dz=sdes-(-zval);
theta0=atan2d(imag(d0),real(d0));
theta1=atan2d(imag(d1),real(d1));
thetaz=atan2d(imag(dz),real(dz));
theta_sum_correct=theta0+theta1-thetaz;
theta_sum_correct

theta_sum_false1=theta0+theta1+thetaz
theta_sum_false2=theta0+theta1+(180-thetaz)

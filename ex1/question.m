clear;clc;

syms s t;
syms x y real;
Gs=1/((s+x)*(s+y));
[num,den]=numden(Gs);
num=collect(expand(num),s);
den=collect(expand(den),s);
disp("Gs:")
disp(num)
disp(den)

yt=ilaplace(Gs/s,s,t);
yt
fun_yt=matlabFunction(yt);
fun_yt

% s^2+(x+y)s+(x*y)
% ts=8/(x+y)
% yss=1/(x*y)

figure(1);clf;hold on;grid on;ax1=gca;
legend("show")
xlabel("time(s)");
ylabel("y(t)");
tvec=0:0.01:10;

% x=y case crashes

% for xval=1:5
%     for yval=1:5
xval=1;
yval=2;
col=[xval/5,yval/5,0];
ts=8/(xval+yval);
yss=1/(xval*yval);

tvec=0:0.01:2*ts;
plot(ax1,tvec,fun_yt(tvec,xval,yval),'Color',col,'DisplayName',"x:"+num2str(xval)+" y:"+num2str(yval));
xticks(ax1,[0,ts]);
yticks(ax1,[0,0.98*yss,1.02*yss]);
ylim([0,1.1*yss])
%    end
%end

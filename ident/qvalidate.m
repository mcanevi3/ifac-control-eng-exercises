clear;clc;

qdefs;

zetavec1=zeta_stab(1)+(zeta_stab(2)-zeta_stab(1))*(10*x1+x0)/99;
wnvec1=wn_stab(2)+(wn_stab(1)-wn_stab(2))*(10*x1+x0)/99;

zetavec2=zeta_instab(1)+(zeta_instab(2)-zeta_instab(1))*(10*x1+x0)/99;
wnvec2=wn_instab(2)+(wn_instab(1)-wn_instab(2))*(10*x1+x0)/99;

fun_yt=@(t,wn,zeta)exp(t.*-4.0)./(wn.*zeta.*-8.0+wn.^2+1.6e+1)-(exp(-t.*wn.*zeta).*(cosh(t.*wn.*sqrt(zeta.^2-1.0))+(sinh(t.*wn.*sqrt(zeta.^2-1.0)).*1.0./sqrt(zeta.^2-1.0).*(wn.*zeta-4.0))./wn))./(wn.*zeta.*-8.0+wn.^2+1.6e+1);

figure(1);clf;title("Impulse Response");
subplot(1,2,1);cla;hold on;grid on;ax1=gca;
xlabel("time(sec)");ylabel("Zero overshoot");
subplot(1,2,2);cla;hold on;grid on;ax2=gca;
xlabel("time(sec)");ylabel("Overshoot");

for i=1:10
    zeta=zetavec1(i);
    wn=wnvec1(i);
    p1=wn*(zeta-sqrt(zeta^2-1));

    disp("p1:"+string(p1))

    tset=max([2*4/p1,2*1]);
    tvec=linspace(0,tset,100);
    yvec=fun_yt(tvec,wn,zeta);

    plot(ax1,tvec,yvec);

    zeta=zetavec2(i);
    wn=wnvec2(i);

    tset=max([1.5*4/(zeta*wn),2*1]);
    tvec=linspace(0,tset,100);
    yvec=fun_yt(tvec,wn,zeta);
    
    plot(ax2,tvec,yvec);

end
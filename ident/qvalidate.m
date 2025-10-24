clear;clc;

qdefs;

zetavec1=zeta_stab(1)+(zeta_stab(2)-zeta_stab(1))*(10*x1+x0)/99;
wnvec1=wn_stab(2)+(wn_stab(1)-wn_stab(2))*(10*x1+x0)/99;

zetavec2=zeta_instab(1)+(zeta_instab(2)-zeta_instab(1))*(10*x1+x0)/99;
wnvec2=wn_instab(2)+(wn_instab(1)-wn_instab(2))*(10*x1+x0)/99;

fun_yt=@(t,wn,zeta)exp(t.*-4.0)./(wn.*zeta.*-8.0+wn.^2+1.6e+1)-(exp(-t.*wn.*zeta).*(cosh(t.*wn.*sqrt(zeta.^2-1.0))+(sinh(t.*wn.*sqrt(zeta.^2-1.0)).*1.0./sqrt(zeta.^2-1.0).*(wn.*zeta-4.0))./wn))./(wn.*zeta.*-8.0+wn.^2+1.6e+1);

fun_yt2=@(t,wn,zeta) ...
    (exp(-4.*t) ./ (16 + wn.^2 - 8.*wn.*zeta)) ...
    - ( ...
        exp(-t.*wn.*zeta) .* ( ...
            cos(t.*wn.*sqrt(1 - zeta.^2)) ...
            + (sin(t.*wn.*sqrt(1 - zeta.^2)) .* (-4 + wn.*zeta)) ...
              ./ (wn .* sqrt(1 - zeta.^2)) ...
          ) ...
      ) ./ (16 + wn.^2 - 8.*wn.*zeta);

figure(1);clf;title("Impulse Response");
subplot(2,2,1);cla;hold on;grid on;ax1=gca;
xlabel("time(sec)");ylabel("Zero overshoot");
subplot(2,2,2);cla;hold on;grid on;ax2=gca;
xlabel("time(sec)");ylabel("Overshoot");

subplot(2,2,3);cla;hold on;grid on;ax3=gca;
xlabel("sample");ylabel("Does Overshoot");
subplot(2,2,4);cla;hold on;grid on;ax4=gca;
xlabel("sample");ylabel("Does Overshoot");

does_os1=zeros(1,100);
does_os2=zeros(1,100);
for i=1:100
    %% case 1
    zeta=zetavec1(i);
    wn=wnvec1(i);
    p1=wn*(zeta-sqrt(zeta^2-1));

    tset=max([2*4/p1,2*1]);
    tvec=linspace(0,tset,100);
    yvec=fun_yt(tvec,wn,zeta);

    does_os1(i)=sum(double(yvec<0));
    plot(ax3,does_os1);

    plot(ax1,tvec,yvec);

    %% case 2
    zeta=zetavec2(i);
    wn=wnvec2(i);

    tset=max([1.5*4/(zeta*wn),2*1]);
    tvec=linspace(0,tset,100);
    yvec=fun_yt2(tvec,wn,zeta);
    
    does_os2(i)=sum(double(yvec<0));
    
    plot(ax3,does_os2);
    
    plot(ax2,tvec,yvec);
end

disp("Case 1: Overshoots:"+string(sum(double(does_os1>0))))
disp("Case 2: Overshoots:"+string(sum(double(does_os2>0))))
% print("qvalidate_resp.png","-dpng")

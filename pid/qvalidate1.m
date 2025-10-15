clear;clc;

qdefs;

p0vec=p0min+(p0max-p0min)*(10*x1+x0)/99;
p1vec=p1min+(p1max-p1min)*(10*x1+x0)/99;

% center stable
kp=kpsolmax;
ki=kisolmax;

Fs=tf([kp ki],[1 0]);
figure(1);clf;hold on;grid on;
xlabel("time(s)");
ylabel("y(t)");
title("Step Response");
ax1=gca;

for p1=p1vec
    for p0=p0vec
        Gs=tf(1,[1,2,p1,p0]);
        Ts=feedback(Fs*Gs,1);
        [y,t]=step(Ts);
        plot(ax1,t,y);
        if ~isstable(Ts)
            disp("p0:"+string(p0)+" p1:"+string(p1))
        end
    end
end
xlim(ax1,[0,200]);
ylim(ax1,[0,2]);

 print("center_stable.png","-dpng","-r150")

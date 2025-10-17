clear;clc;

qdefs;

p0vec=p0min+(p0max-p0min)*(10*x1+x0)/99;
p1vec=p1min+(p1max-p1min)*(10*x1+x0)/99;

% unstable 
kp=mean(kunstable4(1:2));
ki=mean(kunstable4(3:4));

Fs=tf([kp ki],[1 0]);
figure(1);clf;hold on;grid on;
xlabel("time(s)");
ylabel("y(t)");
title("Step Response");
ax1=gca;

for p1=p1vec
    for i=1:length(p0vec)
        p0=p0vec(i);
        Gs=tf(1,[1,2,p1,p0]);
        Ts=feedback(Fs*Gs,1);
        [y,t]=step(Ts,200);
        col=[i/length(p0vec),0,0];
        plot(ax1,t,y,'Color',col);
        if isstable(Ts)
            disp("p0:"+string(p0)+" p1:"+string(p1))
        end
    end
end
xlim(ax1,[0,200]);
ylim(ax1,[0,2]);


print("unstable.png","-dpng","-r150")

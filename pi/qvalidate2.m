clear;clc;

qdefs;

p0vec=p0min+(p0max-p0min)*(10*x1+x0)/99;
p1vec=p1min+(p1max-p1min)*(10*x1+x0)/99;

% center stable
kpvec=linspace(kstable(1),kstable(2),10);
kivec=linspace(kstable(3),kstable(4),10);

figure(1);clf;hold on;grid on;
xlabel("time(s)");
ylabel("y(t)");
title("Step Response");
ax1=gca;

for kp=kpvec
    for ki=kivec
        Fs=tf([kp ki],[1 0]);
        for p1=p1vec
            for i=1:length(p0vec)
                p0=p0vec(i);
                Gs=tf(1,[1,2,p1,p0]);
                Ts=feedback(Fs*Gs,1);
                [y,t]=step(Ts,200);
                col=[i/length(p0vec),0,0];
                plot(ax1,t,y,'Color',col);
                if ~isstable(Ts)
                    disp("p0:"+string(p0)+" p1:"+string(p1)+" for kp"+string(kp)+" ki"+string(ki))
                end
            end
        end
    end
end
xlim(ax1,[0,100]);
ylim(ax1,[-3.5,4.5]);

print("step_response1.png","-dpng","-r150")

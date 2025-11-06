clear;clc;

qdefs;

p0vec=p0min+(p0max-p0min)*(10*x1+x0)/99;
p1vec=p1min+(p1max-p1min)*(10*x1+x0)/99;

% center stable
kp=mean(kstable(1:2));
ki=mean(kstable(3:4));

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
        if ~isstable(Ts)
            disp("p0:"+string(p0)+" p1:"+string(p1))
        end
    end
end
xlim(ax1,[0,40]);
ylim(ax1,[0,1.1]);

%% Export
targetWidth = 7.2;
fig = gcf;
origUnits = get(fig, 'Units');
set(fig, 'Units', 'inches');
pos = get(fig, 'Position');
aspectRatio = pos(4)/pos(3); % height / width
set(fig, 'Position', [pos(1), pos(2), targetWidth, targetWidth*aspectRatio]);
set(fig, 'Units', origUnits);
set(fig, 'PaperUnits', 'inches', ...
         'PaperPosition', [0 0 targetWidth targetWidth*aspectRatio], ...
         'PaperSize', [targetWidth targetWidth*aspectRatio]);

print(fig,"center_stable.png","-dpng","-r150")

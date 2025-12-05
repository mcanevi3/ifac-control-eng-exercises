%%% Lets design a PI controller
clear;clc;

qdefs;

syms s;
syms p1 p0 real;
ns=1;
ds=s^3+2*s^2+p1*s+p0;
Gss=ns/ds;
syms kp ki real;
Fss=kp+ki/s;
Tss=(Fss*Gss)/(1+Fss*Gss);
Tss=simplifyFraction(Tss);
[pzs,pcs]=numden(Tss);
coef=coeffs(pcs,s,'all');

pol1=subs(pcs,[p1,p0],[p1min,p0max]); %p-++
pol2=subs(pcs,[p1,p0],[p1max,p0max]); %p++-

cond1=routh(coeffs(pol1,s,'all'));
cond1=simplifyFraction(cond1);
cond2=routh(coeffs(pol2,s,'all'));
cond2=simplifyFraction(cond2);

kpvec=-12:0.01:8;
kivec=0:0.01:4;
[kpmat,kimat]=meshgrid(kpvec,kivec);

temp=(cond1(1)>0)&(cond1(2)>0)&(cond1(3)>0)&(cond1(4)>0)&(cond1(5)>0);
fcond1=matlabFunction(temp,'Vars', {kp, ki});
temp=(cond2(1)>0)&(cond2(2)>0)&(cond2(3)>0)&(cond2(4)>0)&(cond2(5)>0);
fcond2=matlabFunction(temp,'Vars', {kp, ki});

stab1=fcond1(kpmat,kimat);
stab2=fcond2(kpmat,kimat);
stabTot=stab1&stab2;


solReg=@(kp,ki,kvec)(kp>=kvec(1))&(kp<=kvec(2))&(ki>=kvec(3))&(ki<=kvec(4));
stabSol=solReg(kpmat,kimat,kstable);

colors = [
    0.6, 1.0, 0.6;  % Region 1
    0.3, 0.6, 0.3;  % Region 2
    0.6, 1.0, 0.6;  % Region 2 total stab
];

figure(1);clf;hold on;grid on;
xlabel("k_p");ylabel("k_i");title("Stability");
contourf(kpmat, kimat, stab2, [0.5 1], 'LineColor','none',...
'FaceColor',colors(2,:),'FaceAlpha',1);


contourf(kpmat, kimat, stabTot, [0.5 1], 'LineColor','none',...
'FaceColor',colors(3,:),'FaceAlpha',1);

% contourf(kpmat, kimat, stab1, [0.5 1], 'LineColor','none',...
% 'FaceColor',colors(1,:),'FaceAlpha',1);

% fill([kpsolmin kpsolmax kpsolmax kpsolmin], ...
%      [kisolmin kisolmin kisolmax kisolmax], ...
%% stable
fill([kstable(1) kstable(2) kstable(2) kstable(1)], ...
     [kstable(3) kstable(3) kstable(4) kstable(4)], ...
     [1 1 1], 'FaceAlpha', 1, 'EdgeColor', 'k');

%% unstable-1
kunstable=kunstable1;
fill([kunstable(1) kunstable(2) kunstable(2) kunstable(1)],...
[kunstable(3) kunstable(3) kunstable(4) kunstable(4)], ...
     [1 0 0], 'FaceAlpha', 1, 'EdgeColor', 'k');

%% unstable-2
kunstable=kunstable2;
fill([kunstable(1) kunstable(2) kunstable(2) kunstable(1)],...
[kunstable(3) kunstable(3) kunstable(4) kunstable(4)], ...
     [1 0 0], 'FaceAlpha', 1, 'EdgeColor', 'k');

%% unstable-3
kunstable=kunstable3;
fill([kunstable(1) kunstable(2) kunstable(2) kunstable(1)],...
[kunstable(3) kunstable(3) kunstable(4) kunstable(4)], ...
     [1 0 0], 'FaceAlpha', 1, 'EdgeColor', 'k');

%% unstable-4
kunstable=kunstable4;
fill([kunstable(1) kunstable(2) kunstable(2) kunstable(1)],...
[kunstable(3) kunstable(3) kunstable(4) kunstable(4)], ...
     [1 0 0], 'FaceAlpha', 1, 'EdgeColor', 'k');

legend("p_2(s)","p_1(s) & stability","solution region","unstable")


%% Export
targetWidth = 7.2;
fig = gcf;
origUnits = get(fig, 'Units');
set(fig, 'Units', 'inches');
pos = get(fig, 'Position');
aspectRatio = pos(4)/pos(3); % height / width
aspectRatio=aspectRatio/1.5;
set(fig, 'Position', [pos(1), pos(2), targetWidth, targetWidth*aspectRatio]);
set(fig, 'Units', origUnits);
set(fig, 'PaperUnits', 'inches', ...
         'PaperPosition', [0 0 targetWidth targetWidth*aspectRatio], ...
         'PaperSize', [targetWidth targetWidth*aspectRatio]);

print(fig,"stability.png","-dpng","-r300")

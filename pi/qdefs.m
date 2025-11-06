[x0mat,x1mat]=meshgrid(0:2:9,0:2:9);
x0=x0mat(:)';
x1=x1mat(:)';

p1max=3.5; %5
p1min=3; %3
p0max=7.5; %8
p0min=7; %4

% kpmin kpmax kimin kimax
kstable=[-2.5 -6 0.5 1];
kunstable1=[0.5,3.5,1,2];
kunstable2=[-10,-8,1,2];
kunstable3=[-10,-7,2.5,3.5];
kunstable4=[0.5,2.5,2.5,3.5];

[x0mat,x1mat]=meshgrid(0:9,0:9);
x0=x0mat(:)';
x1=x1mat(:)';

p1max=5;
p1min=4;
p0max=2;
p0min=1;

p0=p0min+(p0max-p0min)*(10*x1+x0)/99;
p1=p1min+(p1max-p1min)*(10*x1+x0)/99;
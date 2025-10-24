x0=0:9;
x1=0:9;

[x0mat,x1mat]=meshgrid(x0,x1);
x0=x0mat(:);
x1=x1mat(:);

zeta_stab=[2,5];
wn_stab=[1,4];

zeta_instab=[0.1,0.4];
wn_instab=[0.5,1];

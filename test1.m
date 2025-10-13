%%% Test parameter creation
n=1;
pmin=0.12;
pmax=0.45;

if n==1
    x=0:1:9
    p=pmin+(pmax-pmin)*(x/9)
elseif n==2
    [x,y]=meshgrid(0:1:9,0:1:9);
    x
    y
    p=pmin+(pmax-pmin)*((10*x+y)/99)
elseif n==3
    [x,y,z]=meshgrid(0:1:9,0:1:9,0:1:9);
    x
    y
    z
    p=pmin+(pmax-pmin)*((100*x+10*y+z)/999)
end

figure(1);clf;hold on;grid on;
psorted=sort(p(:));
plot(psorted,'x','LineWidth',1)

disp("All unique?:");
disp(length(unique(p(:)))==length(p(:)));

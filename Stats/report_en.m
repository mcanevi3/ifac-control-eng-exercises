clear;clc;

data = jsondecode(fileread("data_en.json"));

years=2019:2025;
N=length(years);
colors={'k','r','g','k','b','k','k'};

pretest_avg=zeros(1,N);
pretest_stddev=zeros(1,N);
posttest_avg=zeros(1,N);
posttest_stddev=zeros(1,N);
final_avg=zeros(1,N);
final_stddev=zeros(1,N);
for i=1:N
    pretest_avg(i)=data(i).grades.pre.avg;
    pretest_stddev(i)=data(i).grades.pre.stddev;

    posttest_avg(i)=data(i).grades.post.avg;
    posttest_stddev(i)=data(i).grades.post.stddev;

    final_avg(i)=data(i).grades.final.avg;
    final_stddev(i)=data(i).grades.final.stddev;
end

figure(1);clf;
subplot(3,1,1);cla;hold on;grid on;legend("show");ax1=gca;
subplot(3,1,2);cla;hold on;grid on;legend("show");ax2=gca;
subplot(3,1,3);cla;hold on;grid on;legend("show");ax3=gca;
bar(ax1,years,pretest_avg,'k','DisplayName','Avg')
bar(ax1,years,pretest_stddev,'r','DisplayName','Stddev')
title(ax1,"KON314E:Pretest");

bar(ax2,years,posttest_avg,'k','DisplayName','Avg')
bar(ax2,years,posttest_stddev,'r','DisplayName','Stddev')
title(ax2,"KON314E:Posttest");

bar(ax3,years,final_avg,'k','DisplayName','Avg')
bar(ax3,years,final_stddev,'r','DisplayName','Stddev')
title(ax3,"KON314E:Final");

%% Gauss distribution
grades_vec = 0:0.01:100;
fdist=@(mu,sigma)1/(sigma*sqrt(2*pi)) * exp(-(grades_vec - mu).^2 / (2*sigma^2));

figure(2);clf;
subplot(3,1,1);cla;hold on;grid on;ax1=gca;%legend("show");
subplot(3,1,2);cla;hold on;grid on;ax2=gca;%legend("show");
subplot(3,1,3);cla;hold on;grid on;ax3=gca;%legend("show");
title(ax1,"KON314E:Pretest");
title(ax2,"KON314E:Posttest");
title(ax3,"KON314E:Final");

view(ax1,16,18);
view(ax2,16,18);
view(ax3,16,18);
for i=1:N
    yvec=fdist(pretest_avg(i),pretest_stddev(i));
    vertices=[years(i)*ones(size(grades_vec')),grades_vec',yvec'];
    patch(ax1,"Vertices",vertices,"Faces",1:length(yvec),'FaceColor',colors{i},'EdgeColor','none','FaceAlpha',0.5,'DisplayName',num2str(years(i)));

    yvec=fdist(posttest_avg(i),posttest_stddev(i));
    vertices=[years(i)*ones(size(grades_vec')),grades_vec',yvec'];
    patch(ax2,"Vertices",vertices,"Faces",1:length(yvec),'FaceColor',colors{i},'EdgeColor','none','FaceAlpha',0.5,'DisplayName',num2str(years(i)));
    
    yvec=fdist(final_avg(i),final_stddev(i));
    vertices=[years(i)*ones(size(grades_vec')),grades_vec',yvec'];
    patch(ax3,"Vertices",vertices,"Faces",1:length(yvec),'FaceColor',colors{i},'EdgeColor','none','FaceAlpha',0.5,'DisplayName',num2str(years(i)));
end

figure(1);
exportgraphics(gcf, "avg_en.pdf", ...
ContentType="vector", ...
BackgroundColor="none");

figure(2);
exportgraphics(gcf, "gauss_en.pdf", ...
ContentType="image", ...
BackgroundColor="none");

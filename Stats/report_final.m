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
subplot(2,1,1);cla;hold on;grid on;legend("show");ax1=gca;
subplot(2,1,2);cla;hold on;grid on;legend("show");ax2=gca;
bar(ax1,years,pretest_avg,'k','DisplayName','Avg')
bar(ax1,years,pretest_stddev,'r','DisplayName','Stddev')
title(ax1,"KON314E:Pretest");


%% Gauss distribution
grades_vec = 0:0.01:100;
fdist=@(mu,sigma)1/(sigma*sqrt(2*pi)) * exp(-(grades_vec - mu).^2 / (2*sigma^2));


view(ax2,16,18);
for i=1:N
    yvec=fdist(pretest_avg(i),pretest_stddev(i));
    vertices=[years(i)*ones(size(grades_vec')),grades_vec',yvec'];
    patch(ax2,"Vertices",vertices,"Faces",1:length(yvec),'FaceColor',colors{i},'EdgeColor','none','FaceAlpha',0.5,'DisplayName',num2str(years(i)));

end

figure(1);
exportgraphics(gcf, "statistics.pdf", ...
ContentType="image", ... %vector
BackgroundColor="none");

%% OR
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


figure(2);clf;
subplot(2,1,1);cla;hold on;grid on;legend("show");ax1=gca;
subplot(2,1,2);cla;hold on;grid on;legend("show");ax2=gca;
bar(ax1,years,pretest_avg,'k','DisplayName','Avg')
bar(ax1,years,pretest_stddev,'r','DisplayName','Stddev')
title(ax1,"KON314E:Pretest");

%% Gauss distribution
grades_vec = 0:0.01:100;
fdist=@(mu,sigma)1/(sigma*sqrt(2*pi)) * exp(-(grades_vec - mu).^2 / (2*sigma^2));


% view(ax2,16,18);
for i=1:N
    yvec=fdist(pretest_avg(i),pretest_stddev(i));
    vertices=[grades_vec',yvec'];
    patch(ax2,"Vertices",vertices,"Faces",1:length(yvec),'FaceColor',colors{i},'EdgeColor','none','FaceAlpha',0.5,'DisplayName',num2str(years(i)));

end

xlabel(ax2,"Grades");

figure(2);
exportgraphics(gcf, "statistics2.pdf", ...
ContentType="image", ... %vector
BackgroundColor="none");

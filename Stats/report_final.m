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

figure(1);clf;hold on;grid on;legend("show");ax1=gca;
bar(ax1,years,posttest_avg,'k','DisplayName','Avg')
bar(ax1,years,posttest_stddev,'r','DisplayName','Stddev')
title(ax1,"KON314E:Posttest");

xlim([2018.5,2025.5])
exportgraphics(gcf, "statistics.pdf", ...
ContentType="image", ... %vector
BackgroundColor="none");


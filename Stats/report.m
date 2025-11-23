clear;clc;

data = jsondecode(fileread("data_tr.json"));

years=2019:2025;
N=length(years);

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
plot(ax1,years,pretest_avg,'k','DisplayName','Avg')
plot(ax1,years,pretest_stddev,'r','DisplayName','Stddev')
title(ax1,"Pretest");

plot(ax2,years,posttest_avg,'k','DisplayName','Avg')
plot(ax2,years,posttest_stddev,'r','DisplayName','Stddev')
title(ax2,"Posttest");

plot(ax3,years,final_avg,'k','DisplayName','Avg')
plot(ax3,years,final_stddev,'r','DisplayName','Stddev')
title(ax3,"Final");



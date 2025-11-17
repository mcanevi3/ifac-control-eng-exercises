clear;clc;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 2022
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% json_data=util("read_json","2022");
% data_en=json_data(1);
% data_tr=json_data(2);

% grades_tr=data_tr.grades;
% post2022tr=[];
% for i=1:length(grades_tr)
%     g=grades_tr(i).grade;
%     count=grades_tr(i).count;
%     post2022tr=[post2022tr,g*ones(1,count)];
% end

%% Final Pre Post
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
table_tr=util("read_csv","2019_tr");
post_tr=table_tr.("Final");index=~isnan(post_tr);post_tr=post_tr(index);
mu2019(1)=post_tr(1);sigma2019(1)=post_tr(2);
post_tr=table_tr.("Pre Test");index=~isnan(post_tr);post_tr=post_tr(index);
mu2019(2)=post_tr(1);sigma2019(2)=post_tr(2);
post_tr=table_tr.("Post Test");index=~isnan(post_tr);post_tr=post_tr(index);
mu2019(3)=post_tr(1);sigma2019(3)=post_tr(2);
post_tr=table_tr.("Avg");index=~isnan(post_tr);post_tr=post_tr(index);
mu2019(4)=post_tr(1);sigma2019(4)=post_tr(2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
table_tr=util("read_csv","2020_tr");
post_tr=table_tr.("Final");index=~isnan(post_tr);post_tr=post_tr(index);
post_tr=post_tr(1:end-2);
mu2020(1)=mean(post_tr);sigma2020(1)=std(post_tr);
post_tr=table_tr.("Pre Test");index=~isnan(post_tr);post_tr=post_tr(index);
post_tr=post_tr(1:end-2);
mu2020(2)=mean(post_tr);sigma2020(2)=std(post_tr);
post_tr=table_tr.("Post Test");index=~isnan(post_tr);post_tr=post_tr(index);
post_tr=post_tr(1:end-2);
mu2020(3)=mean(post_tr);sigma2020(3)=std(post_tr);
post_tr=table_tr.("Avg");index=~isnan(post_tr);post_tr=post_tr(index);
post_tr=post_tr(1:end-2);
mu2020(4)=mean(post_tr);sigma2020(4)=std(post_tr);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
table_tr=util("read_csv","2021_tr");
post_tr=table_tr.("Final");index=~isnan(post_tr);post_tr=post_tr(index);
post_tr=post_tr(1:end-2);
mu2021(1)=mean(post_tr);sigma2021(1)=std(post_tr);
post_tr=table_tr.("Pre Test");index=~isnan(post_tr);post_tr=post_tr(index);
post_tr=post_tr(1:end-2);
mu2021(2)=mean(post_tr);sigma2021(2)=std(post_tr);
post_tr=table_tr.("Post Test");index=~isnan(post_tr);post_tr=post_tr(index);
post_tr=post_tr(1:end-2);
mu2021(3)=mean(post_tr);sigma2021(3)=std(post_tr);
post_tr=table_tr.("Avg");index=~isnan(post_tr);post_tr=post_tr(index);
post_tr=post_tr(1:end-2);
mu2021(4)=mean(post_tr);sigma2021(4)=std(post_tr);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2022
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
table_tr=util("read_csv","2022_tr");
post_tr=table_tr.("Final");index=~isnan(post_tr);post_tr=post_tr(index);
post_tr=post_tr(1:end-2);
mu2022(1)=mean(post_tr);sigma2022(1)=std(post_tr);
post_tr=table_tr.("Pre Test");index=~isnan(post_tr);post_tr=post_tr(index);
post_tr=post_tr(1:end-2);
mu2022(2)=mean(post_tr);sigma2022(2)=std(post_tr);
post_tr=table_tr.("Post Test");index=~isnan(post_tr);post_tr=post_tr(index);
post_tr=post_tr(1:end-2);
mu2022(3)=mean(post_tr);sigma2022(3)=std(post_tr);
post_tr=table_tr.("Avg");index=~isnan(post_tr);post_tr=post_tr(index);
post_tr=post_tr(1:end-2);
mu2022(4)=mean(post_tr);sigma2022(4)=std(post_tr);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2023
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
table_tr=util("read_csv","2023_tr");
post_tr=table_tr.("Final");index=~isnan(post_tr);post_tr=post_tr(index);
post_tr=post_tr(1:end-2);
mu2023(1)=mean(post_tr);sigma2023(1)=std(post_tr);
post_tr=table_tr.("Pre Test");index=~isnan(post_tr);post_tr=post_tr(index);
post_tr=post_tr(1:end-2);
mu2023(2)=mean(post_tr);sigma2023(2)=std(post_tr);
post_tr=table_tr.("Post Test");index=~isnan(post_tr);post_tr=post_tr(index);
post_tr=post_tr(1:end-2);
mu2023(3)=mean(post_tr);sigma2023(3)=std(post_tr);
post_tr=table_tr.("Avg");index=~isnan(post_tr);post_tr=post_tr(index);
post_tr=post_tr(1:end-2);
mu2023(4)=mean(post_tr);sigma2023(4)=std(post_tr);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2024
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
table_tr=util("read_csv","2024_tr");
post_tr=table_tr.("Final");index=~isnan(post_tr);post_tr=post_tr(index);
post_tr=post_tr(1:end-2);
mu2024(1)=mean(post_tr);sigma2024(1)=std(post_tr);
post_tr=table_tr.("Pre Test");index=~isnan(post_tr);post_tr=post_tr(index);
post_tr=post_tr(1:end-2);
mu2024(2)=mean(post_tr);sigma2024(2)=std(post_tr);
post_tr=table_tr.("Post Test");index=~isnan(post_tr);post_tr=post_tr(index);
post_tr=post_tr(1:end-2);
mu2024(3)=mean(post_tr);sigma2024(3)=std(post_tr);
post_tr=table_tr.("Avg");index=~isnan(post_tr);post_tr=post_tr(index);
post_tr=post_tr(1:end-2);
mu2024(4)=mean(post_tr);sigma2024(4)=std(post_tr);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2025
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
table_tr=util("read_csv","2025_tr");
post_tr=table_tr.("Final");index=~isnan(post_tr);post_tr=post_tr(index);
post_tr=post_tr(1:end-2);
mu2025(1)=mean(post_tr);sigma2025(1)=std(post_tr);
post_tr=table_tr.("Pre Test");index=~isnan(post_tr);post_tr=post_tr(index);
post_tr=post_tr(1:end-2);
mu2025(2)=mean(post_tr);sigma2025(2)=std(post_tr);
post_tr=table_tr.("Post Test");index=~isnan(post_tr);post_tr=post_tr(index);
post_tr=post_tr(1:end-2);
mu2025(3)=mean(post_tr);sigma2025(3)=std(post_tr);
post_tr=table_tr.("Avg");index=~isnan(post_tr);post_tr=post_tr(index);
post_tr=post_tr(1:end-2);
mu2025(4)=mean(post_tr);sigma2025(4)=std(post_tr);

%% plot gaussian distribution
exam_type=["Final","Pre Test","Post Test"];

figure(1);clf;gcf1=gcf;

ii=1;
subplot(3,1,ii);cla;hold on;grid on;ax1=gca;xlabel(ax1,'Grade');
ylabel(ax1,'Probability Density');legend(ax1,"show");
title(ax1,exam_type(ii)+":Gaussian Distribution of Grades");

ii=2;
subplot(3,1,ii);cla;hold on;grid on;ax2=gca;xlabel(ax2,'Grade');
ylabel(ax2,'Probability Density');legend(ax2,"show");
title(ax2,exam_type(ii)+":Gaussian Distribution of Grades");

ii=3;
subplot(3,1,ii);cla;hold on;grid on;ax3=gca;xlabel(ax3,'Grade');
ylabel(ax3,'Probability Density');legend(ax3,"show");
title(ax3,exam_type(ii)+":Gaussian Distribution of Grades");

grades_vec = 0:0.01:100;
y=@(mu,sigma)1/(sigma*sqrt(2*pi)) * exp(-(grades_vec - mu).^2 / (2*sigma^2));

ii=1;
plot(ax1,grades_vec,y(mu2019(ii),sigma2019(ii)),'g','LineWidth',2,'DisplayName','2019');
plot(ax1,grades_vec,y(mu2020(ii),sigma2020(ii)),'r','LineWidth',2,'DisplayName','2020');
plot(ax1,grades_vec,y(mu2021(ii),sigma2021(ii)),'r','LineWidth',2,'DisplayName','2021');
plot(ax1,grades_vec,y(mu2022(ii),sigma2022(ii)),'g','LineWidth',2,'DisplayName','2022');
plot(ax1,grades_vec,y(mu2023(ii),sigma2023(ii)),'g','LineWidth',2,'DisplayName','2023');
plot(ax1,grades_vec,y(mu2024(ii),sigma2024(ii)),'g','LineWidth',2,'DisplayName','2024');
plot(ax1,grades_vec,y(mu2025(ii),sigma2025(ii)),'g','LineWidth',2,'DisplayName','2025');

ii=2;
plot(ax2,grades_vec,y(mu2019(ii),sigma2019(ii)),'g','LineWidth',2,'DisplayName','2019');
plot(ax2,grades_vec,y(mu2020(ii),sigma2020(ii)),'r','LineWidth',2,'DisplayName','2020');
plot(ax2,grades_vec,y(mu2021(ii),sigma2021(ii)),'r','LineWidth',2,'DisplayName','2021');
plot(ax2,grades_vec,y(mu2022(ii),sigma2022(ii)),'g','LineWidth',2,'DisplayName','2022');
plot(ax2,grades_vec,y(mu2023(ii),sigma2023(ii)),'g','LineWidth',2,'DisplayName','2023');
plot(ax2,grades_vec,y(mu2024(ii),sigma2024(ii)),'g','LineWidth',2,'DisplayName','2024');
plot(ax2,grades_vec,y(mu2025(ii),sigma2025(ii)),'g','LineWidth',2,'DisplayName','2025');

ii=3;
plot(ax3,grades_vec,y(mu2019(ii),sigma2019(ii)),'g','LineWidth',2,'DisplayName','2019');
plot(ax3,grades_vec,y(mu2020(ii),sigma2020(ii)),'r','LineWidth',2,'DisplayName','2020');
plot(ax3,grades_vec,y(mu2021(ii),sigma2021(ii)),'r','LineWidth',2,'DisplayName','2021');
plot(ax3,grades_vec,y(mu2022(ii),sigma2022(ii)),'g','LineWidth',2,'DisplayName','2022');
plot(ax3,grades_vec,y(mu2023(ii),sigma2023(ii)),'g','LineWidth',2,'DisplayName','2023');
plot(ax3,grades_vec,y(mu2024(ii),sigma2024(ii)),'g','LineWidth',2,'DisplayName','2024');
plot(ax3,grades_vec,y(mu2025(ii),sigma2025(ii)),'g','LineWidth',2,'DisplayName','2025');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2);clf;gcf2=gcf;

ii=1;
subplot(3,1,ii);cla;hold on;grid on;ax1=gca;
plot(ax1,2019:2025,[mu2019(ii),mu2020(ii),mu2021(ii),mu2022(ii),mu2023(ii),mu2024(ii),mu2025(ii)],'LineWidth',2)
title(ax1,exam_type(ii));
ii=2;
subplot(3,1,ii);cla;hold on;grid on;ax2=gca;
plot(ax2,2019:2025,[mu2019(ii),mu2020(ii),mu2021(ii),mu2022(ii),mu2023(ii),mu2024(ii),mu2025(ii)],'LineWidth',2)
title(ax2,exam_type(ii));
ii=3;
subplot(3,1,ii);cla;hold on;grid on;ax3=gca;
plot(ax3,2019:2025,[mu2019(ii),mu2020(ii),mu2021(ii),mu2022(ii),mu2023(ii),mu2024(ii),mu2025(ii)],'LineWidth',2)
title(ax3,exam_type(ii));

util("plot_area",ax1,[2020-0.2,0],[2021+0.2,100],[1,0,0],0.1)
util("plot_area",ax2,[2020-0.2,0],[2021+0.2,100],[1,0,0],0.1)
util("plot_area",ax3,[2020-0.2,0],[2021+0.2,100],[1,0,0],0.1)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(3);clf;gcf3=gcf;

ii=1;
subplot(3,1,ii);cla;hold on;grid on;ax1=gca;
plot(ax1,2019:2025,[sigma2019(ii),sigma2020(ii),sigma2021(ii),sigma2022(ii),sigma2023(ii),sigma2024(ii),sigma2025(ii)],'LineWidth',2)
title(ax1,exam_type(ii));
ii=2;
subplot(3,1,ii);cla;hold on;grid on;ax2=gca;
plot(ax2,2019:2025,[sigma2019(ii),sigma2020(ii),sigma2021(ii),sigma2022(ii),sigma2023(ii),sigma2024(ii),sigma2025(ii)],'LineWidth',2)
title(ax2,exam_type(ii));
ii=3;
subplot(3,1,ii);cla;hold on;grid on;ax3=gca;
plot(ax3,2019:2025,[sigma2019(ii),sigma2020(ii),sigma2021(ii),sigma2022(ii),sigma2023(ii),sigma2024(ii),sigma2025(ii)],'LineWidth',2)
title(ax3,exam_type(ii));

util("plot_area",ax1,[2020-0.2,0],[2021+0.2,100],[1,0,0],0.1)
util("plot_area",ax2,[2020-0.2,0],[2021+0.2,100],[1,0,0],0.1)
util("plot_area",ax3,[2020-0.2,0],[2021+0.2,100],[1,0,0],0.1)

exportgraphics(gcf1, "img/gauss1.pdf", ...
ContentType="vector", ...
BackgroundColor="none");
exportgraphics(gcf2, "img/gauss2.pdf", ...
ContentType="vector", ...
BackgroundColor="none");
exportgraphics(gcf3, "img/gauss3.pdf", ...
ContentType="vector", ...
BackgroundColor="none");

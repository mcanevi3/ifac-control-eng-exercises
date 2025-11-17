clear;clc;

%% 2020-2023 pandemic 2010-2019
figure(1);clf;gcf1=gcf;
subplot(2,1,1);hold on;grid on;ax1=gca;
subplot(2,1,2);hold on;grid on;ax2=gca;
ylabel(ax1,"GPA");
ylabel(ax2,"GPA");
title(ax1,"End of the year GPA of KON314E");
title(ax2,"End of the year GPA of KON314");

% util("english.json",ax1);
% util("turkish.json",ax2);

util("plot_pandemic_timezones",ax1);
util("plot_pandemic_timezones",ax2);

util("plot_gpa_vs_year_en",ax1);
util("plot_gpa_vs_year_tr",ax2);

xlim(ax1,[2009,2024]);ylim(ax1,[0,70]);
xlim(ax2,[2009,2024]);ylim(ax2,[0,70]);

data_en=util("data_gpa_vs_year_en");
disp("**** KON314E ***************")
disp("Pre-covid:")
disp("mean:"+string(mean(data_en.grade_pre)));
disp("std:"+string(std(data_en.grade_pre)));
disp("Covid:")
disp("mean:"+string(mean(data_en.grade_covid)));
disp("std:"+string(std(data_en.grade_covid)));
disp("Post-covid:")
disp("mean:"+string(mean(data_en.grade_post)));
disp("std:"+string(std(data_en.grade_post)));

data_tr=util("data_gpa_vs_year_tr");
disp("**** KON314 ***************")
disp("Pre-covid:")
disp("mean:"+string(mean(data_tr.grade_pre)));
disp("std:"+string(std(data_tr.grade_pre)));
disp("Covid:")
disp("mean:"+string(mean(data_tr.grade_covid)));
disp("std:"+string(std(data_tr.grade_covid)));
disp("Post-covid:")
disp("mean:"+string(mean(data_tr.grade_post)));
disp("std:"+string(std(data_tr.grade_post)));

grade_pre=[data_en.grade_pre,data_tr.grade_pre];
grade_covid=[data_en.grade_covid,data_tr.grade_covid];
grade_post=[data_en.grade_post,data_tr.grade_covid];
disp("**** BOTH ***************")
disp("Pre-covid:")
disp("mean:"+string(mean(grade_pre)));
disp("std:"+string(std(grade_pre)));
disp("Covid:")
disp("mean:"+string(mean(grade_covid)));
disp("std:"+string(std(grade_covid)));
disp("Post-covid:")
disp("mean:"+string(mean(grade_post)));
disp("std:"+string(std(grade_post)));

%% plot gaussian distribution
% Plot
figure(2);clf;gcf2=gcf;
hold on;grid on;ax3=gca;
xlabel(ax3,'Grade');
ylabel(ax3,'Probability Density');
title(ax3,'Gaussian Distribution of Grades');
grades_vec = 0:0.01:100;
legend(ax3,"show");

mu = mean(grade_pre);sigma = std(grade_pre);
y = 1/(sigma*sqrt(2*pi)) * exp(-(grades_vec - mu).^2 / (2*sigma^2));
plot(ax3,grades_vec,y,'g','LineWidth',2,'DisplayName','Pre-covid');

mu = mean(grade_covid);sigma = std(grade_covid);
y = 1/(sigma*sqrt(2*pi)) * exp(-(grades_vec - mu).^2 / (2*sigma^2));
plot(ax3,grades_vec,y,'r','LineWidth',2,'DisplayName','Covid');

mu = mean(grade_post);sigma = std(grade_post);
y = 1/(sigma*sqrt(2*pi)) * exp(-(grades_vec - mu).^2 / (2*sigma^2));
plot(ax3,grades_vec,y,'m','LineWidth',2,'DisplayName','Post-covid');

exportgraphics(gcf1, "img/grades_plot.pdf", ...
ContentType="vector", ...
BackgroundColor="none");
exportgraphics(gcf2, "img/grades_distribution.pdf", ...
ContentType="vector", ...
BackgroundColor="none");

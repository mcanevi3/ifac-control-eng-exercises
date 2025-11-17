clear;clc;

json2022=util("read_json","2022");
data2022en=json2022(1);
data2022tr=json2022(2);

grades2022en=data2022en.grades;
pre2022en=[];
for i=1:length(grades2022en)
    g=grades2022en(i).grade;
    count=grades2022en(i).count;
    pre2022en=[pre2022en,g*ones(1,count)];
end

grades2022tr=data2022tr.grades;
pre2022tr=[];
for i=1:length(grades2022tr)
    g=grades2022tr(i).grade;
    count=grades2022tr(i).count;
    pre2022tr=[pre2022tr,g*ones(1,count)];
end

table2023en=util("read_csv","2023_en");
pre2023en=table2023en.("Pre Test");
index=~isnan(pre2023en);
pre2023en=pre2023en(index);

% table2023tr=util("read_csv","2023_tr");
% pre2023tr=table2023tr.("Pre Test");
% index=~isnan(pre2023tr);
% pre2023tr=pre2023tr(index);

% table2024en=util("read_csv","2024_en");
% pre2024en=table2024en.("Pre Test");
% index=~isnan(pre2024en);
% pre2024en=pre2024en(index);

% table2024tr=util("read_csv","2024_tr");
% pre2024tr=table2024tr.("Pre Test");
% index=~isnan(pre2024tr);
% pre2024tr=pre2024tr(index);

%% plot gaussian distribution
% Plot
figure(1);clf;gcf1=gcf;
hold on;grid on;ax1=gca;
xlabel(ax1,'Grade');
ylabel(ax1,'Probability Density');
title(ax1,'Gaussian Distribution of Grades');
legend(ax1,"show");
grades_vec = 0:0.01:100;

mu = mean(pre2022en);sigma = std(pre2022en);
y = 1/(sigma*sqrt(2*pi)) * exp(-(grades_vec - mu).^2 / (2*sigma^2));
plot(ax1,grades_vec,y,'k','LineWidth',2,'DisplayName','PreTest2022');

mu = mean(pre2023en);sigma = std(pre2023en);
y = 1/(sigma*sqrt(2*pi)) * exp(-(grades_vec - mu).^2 / (2*sigma^2));
plot(ax1,grades_vec,y,'r','LineWidth',2,'DisplayName','PreTest2023');

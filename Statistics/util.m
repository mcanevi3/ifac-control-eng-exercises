function out = util(action, varargin)
    switch action
        case "read_json"
            out = read_json(varargin{:});
        case "read_csv"
            out = read_csv(varargin{:});
        case "english.json"
            plot_overall_english_raw(varargin{:})
        case "turkish.json"
            plot_overall_turkish_raw(varargin{:})
        case "data_gpa_vs_year_en"
            [years_pre,grade_pre,years_covid,grade_covid,years_post,grade_post]=data_gpa_vs_year_en();
            out=struct(...
            "years_pre",years_pre,...
            "grade_pre",grade_pre,...
            "years_covid",years_covid,...
            "grade_covid",grade_covid,...
            "years_post",years_post,...
            "grade_post",grade_post...
            );
        case "data_gpa_vs_year_tr"
            [years_pre,grade_pre,years_covid,grade_covid,years_post,grade_post]=data_gpa_vs_year_tr();
            out=struct(...
            "years_pre",years_pre,...
            "grade_pre",grade_pre,...
            "years_covid",years_covid,...
            "grade_covid",grade_covid,...
            "years_post",years_post,...
            "grade_post",grade_post...
            );
        case "plot_gpa_vs_year_en"
            plot_gpa_vs_year_en(varargin{:})
        case "plot_gpa_vs_year_tr"
            plot_gpa_vs_year_tr(varargin{:})
        case "plot_area"
            plot_area(varargin{:})
        case "plot_bar"
            plot_bar(varargin{:})
        case "plot_bar_vec"
            plot_bar_vec(varargin{:})
        case "plot_pandemic_timezones"
            plot_pandemic_timezones(varargin{:})
        otherwise
            error("Unknown action.");
    end
end

%% File import
function data=read_json(filename)
    data = jsondecode(fileread(string(filename)+".json"));
end
function data=read_csv(filename)
    data = readtable(string(filename)+".csv","PreserveVariableNames", true);
end
%% plot area
function plot_area(ax,point1,point2,color,alpha)
    startx=point1(1);
    starty=point1(2);
    stopx=point2(1);
    stopy=point2(2);
    patch(ax,'Vertices',[startx,starty;stopx,starty;stopx,stopy;startx,stopy],'Faces',1:4,'FaceColor',color,'FaceAlpha',alpha,'EdgeColor','none')
end
%% plot bar
function plot_bar(ax,point,color) %2010, 51
    dw=0.2;
    plot(ax,[point(1)-dw,point(1)+dw],[point(2),point(2)],'Color',color,'LineWidth',2);
end
%% plot bar vec
function plot_bar_vec(ax,xvec,yvec,color) %2010, 51
    N=length(xvec);
    for i=1:N
        point=[xvec(i),yvec(i)];
        plot_bar(ax,point,color);
    end
end
%% Reports of english.json and turkish.json files (RAW)
function plot_overall_english_raw(ax)
    data=read_json("english");

    plot_title=[data.class,':',data.comment];
    grades=data.grades;
    N=length(grades);

    yearf_vec=zeros(1,N);
    grade_vec=zeros(1,N);
    for i=1:N
        grade=grades(i);
        yearf_vec(i)=year2yearf(grade.year,grade.semester);
        grade_vec(i)=grade.avg;
    end

    title(ax,plot_title);
    plot(ax,yearf_vec,grade_vec,'b','Marker','+','LineWidth',2);
end

function plot_overall_turkish_raw(ax)
    data=read_json("turkish");

    plot_title=[data.class,':',data.comment];
    grades=data.grades;
    N=length(grades);

    yearf_vec=zeros(1,N);
    grade_vec=zeros(1,N);
    for i=1:N
        grade=grades(i);
        yearf_vec(i)=year2yearf(grade.year,grade.semester);
        grade_vec(i)=grade.avg;
    end

    title(ax,plot_title);
    plot(ax,yearf_vec,grade_vec,'b','Marker','+','LineWidth',2);
end

%% Covid helper functions
function res=year2yearf(year,semester)
    offset=0;
    if strcmpi(semester, 'fall')
        offset=0.5;
    end
    res=year+offset;
end
function [yearval,semester]=yearf2year(yearf)
    yearval=floor(yearf);
    offset=yearf-yearval;
    semester='spring';
    if offset>0
        semester='fall';
    end
end
function res=is_pre_covid(yearf)
    % Pre-COVID: any semester before 2020/Spring
    res = yearf<=2019.5;
end
function res=is_covid(yearf)
    % COVID 2020/Spring-2022/Spring
    res=(yearf>=2020.0) & (yearf<=2021.5);
end
function res=is_post_covid(yearf)
    % Post-COVID: after 2022/Spring
    res = (yearf >= 2022.0);
end
function plot_pandemic_timezones(ax1)
    yearsf=2010:0.5:2023; % spring->2010, fall->2010.5
    N=length(yearsf);
    dw=0.2;
    for i=1:N
        if is_pre_covid(yearsf(i))
            util("plot_area",ax1,[yearsf(i)-dw,0],[yearsf(i)+dw,100],[0,1,0],0.1)
        elseif is_covid(yearsf(i))
            util("plot_area",ax1,[yearsf(i)-dw,0],[yearsf(i)+dw,100],[1,0,0],0.1)
        elseif is_post_covid(yearsf(i))
            util("plot_area",ax1,[yearsf(i)-dw,0],[yearsf(i)+dw,100],[1,0,1],0.1)
        end
    end
end
%% Plot GPA data 
function plot_gpa_vs_year_en(ax)
    years=2010:0.5:2023; % spring->2010, fall->2010.5
    N=length(years);
    grade_pre=nan(1,N);
    grade_covid=nan(1,N);
    grade_post=nan(1,N);

    data=read_json("english");
    grades_en=data.grades;
    
    for i=1:length(grades_en)
        g=grades_en(i);

        yearf=year2yearf(g.year,g.semester);
        k = (yearf - years(1))/0.5 + 1;
        
        if is_pre_covid(yearf)
            grade_pre(k) = g.avg;
        elseif is_covid(yearf)
            grade_covid(k) = g.avg;
        elseif is_post_covid(yearf)
            grade_post(k) = g.avg;
        end
    end

    plot_bar_vec(ax,years,grade_pre,'k');
    plot_bar_vec(ax,years,grade_covid,'k');
    plot_bar_vec(ax,years,grade_post,'k');
end

function plot_gpa_vs_year_tr(ax)
    years=2010:0.5:2023; % spring->2010, fall->2010.5
    N=length(years);
    grade_pre=nan(1,N);
    grade_covid=nan(1,N);
    grade_post=nan(1,N);

    data=read_json("turkish");
    grades_en=data.grades;
    
    for i=1:length(grades_en)
        g=grades_en(i);

        yearf=year2yearf(g.year,g.semester);
        k = (yearf - years(1))/0.5 + 1;
        
        if is_pre_covid(yearf)
            grade_pre(k) = g.avg;
        elseif is_covid(yearf)
            grade_covid(k) = g.avg;
        elseif is_post_covid(yearf)
            grade_post(k) = g.avg;
        end
    end
    
    plot_bar_vec(ax,years,grade_pre,'k');
    plot_bar_vec(ax,years,grade_covid,'k');
    plot_bar_vec(ax,years,grade_post,'k');
end

%% Data
function [years_pre,grade_pre,years_covid,grade_covid,years_post,grade_post]=data_gpa_vs_year_en()
    years=2010:0.5:2023; % spring->2010, fall->2010.5
    N=length(years);
    grade_pre=nan(1,N);
    grade_covid=nan(1,N);
    grade_post=nan(1,N);

    data=read_json("english");
    grades_en=data.grades;
    
    for i=1:length(grades_en)
        g=grades_en(i);

        yearf=year2yearf(g.year,g.semester);
        k = (yearf - years(1))/0.5 + 1;
        
        if is_pre_covid(yearf)
            grade_pre(k) = g.avg;
        elseif is_covid(yearf)
            grade_covid(k) = g.avg;
        elseif is_post_covid(yearf)
            grade_post(k) = g.avg;
        end
    end

    index=~isnan(grade_pre);
    years_pre=years(index);
    grade_pre=grade_pre(index);

    index=~isnan(grade_covid);
    years_covid=years(index);
    grade_covid=grade_covid(index);

    index=~isnan(grade_post);
    years_post=years(index);
    grade_post=grade_post(index);

end

function [years_pre,grade_pre,years_covid,grade_covid,years_post,grade_post]=data_gpa_vs_year_tr()
    years=2010:0.5:2023; % spring->2010, fall->2010.5
    N=length(years);
    grade_pre=nan(1,N);
    grade_covid=nan(1,N);
    grade_post=nan(1,N);

    data=read_json("turkish");
    grades_tr=data.grades;
    
    for i=1:length(grades_tr)
        g=grades_tr(i);

        yearf=year2yearf(g.year,g.semester);
        k = (yearf - years(1))/0.5 + 1;
        
        if is_pre_covid(yearf)
            grade_pre(k) = g.avg;
        elseif is_covid(yearf)
            grade_covid(k) = g.avg;
        elseif is_post_covid(yearf)
            grade_post(k) = g.avg;
        end
    end

    index=~isnan(grade_pre);
    years_pre=years(index);
    grade_pre=grade_pre(index);

    index=~isnan(grade_covid);
    years_covid=years(index);
    grade_covid=grade_covid(index);

    index=~isnan(grade_post);
    years_post=years(index);
    grade_post=grade_post(index);

end

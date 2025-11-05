%% Lets design a PD controller - a numeric example design
clear;clc;
qdesign_funcs;
qdefs;
x0val=x0(1);
x1val=x1(1);

kval=funk(x0val,x1val);
zval=funz(x0val,x1val);
p0val=funp0(x0val,x1val);
p1val=funp1(x0val,x1val);
zetaval=funzeta(x0val,x1val);
wnval=funwn(x0val,x1val);

angleFalse1=fun_angleFalse1(x0val,x1val);
angleFalse2=fun_angleFalse2(x0val,x1val);
angleFalse3=fun_angleFalse3(x0val,x1val);
angleFalse4=fun_angleFalse4(x0val,x1val);
angleCorrect=fun_angleCorrect(x0val,x1val);

answers=[angleFalse1,angleFalse2,angleFalse3,angleFalse4,angleCorrect];
falseCount=sum(double(abs(answers(1:end-1)-180.00)<1e-4));
correctCount=sum(double(abs(answers(end)-180.00)<1e-4));
allUnique=length(unique(answers))==length(answers);

isValid=(falseCount==0 & correctCount==1)&allUnique;

if isValid
    disp("All answers are unique ad valid");
else
    disp("Invalid!!!");
end

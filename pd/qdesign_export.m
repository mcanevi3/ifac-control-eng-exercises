clear;clc;

qdesign_funcs;
qdefs;

x0val=x0(1);
x1val=x1(1);

% Ls=tf([1,funz(x0val,x1val)],conv([1,funp0(x0val,x1val)],[1,funp1(x0val,x1val)]));
Ls=tf(1,conv([1,funp0(x0val,x1val)],[1,funp1(x0val,x1val)]));
zeta=funzeta(x0val,x1val);
wn=funwn(x0val,x1val);

fname="../test_pdf/rlocus_data/"+string(x1val)+string(x0val)+"_p.txt";

[pvec,kvec]=rlocus(Ls);
[n,samples]=size(pvec);
data=zeros(samples,2*n);
colnames = cell(1, 2*n);
for i=1:n
    data(:,2*i-1)=real(pvec(i,:)');
    data(:,2*i+0)=imag(pvec(i,:)');
    colnames{2*i-1}= sprintf('pr%d',i); 
    colnames{2*i+0}= sprintf('pi%d',i); 
end
%data(end,:)=[]; % removes inf if necessary enable
T = array2table(data, 'VariableNames', colnames);
writetable(T, fname, 'Delimiter',' ');


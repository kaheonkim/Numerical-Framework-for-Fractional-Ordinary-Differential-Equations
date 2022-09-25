N=1:30;
A=zeros(1,30);
B=zeros(1,30);
C=zeros(1,30);
D=zeros(1,30);
E=zeros(1,30);
p_1=1.5;
p_2=1.5;
p_3=1.5;
p_4=1.5;
p_5=1.5;


for i=1:30
    A(1,i)=p_1;
    B(1,i)=p_2;
    C(1,i)=p_3;
    D(1,i)=p_4;
    E(1,i)=p_5;
    p_1=f_1(p_1);
    p_2=f_2(p_2);
    p_3=f_3(p_3);
    p_4=f_4(p_4);
    p_5=f_5(p_5);
end

F=[N;A;B;C;D;E];

fprintf('n   f_1    f_2    f_3    f_4   f_5\n')
fprintf('%5d  %g %g %g %g %g\n',F)


function y=f_1(x)
y=x-x^3-4*x^2+10;
end

function y=f_2(x)
y=(10/x-4*x)^(1/2);
end

function y=f_3(x)
y=(1/2)*(10-x^3)^(1/2);
end

function y=f_4(x)
y=(10/(4+x))^(1/2);
end

function y=f_5(x)
y=x-((x^3+4*x^2-10)/(3*x^2+8*x));
end


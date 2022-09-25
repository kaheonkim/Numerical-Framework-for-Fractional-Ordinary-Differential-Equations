a=1;
b=2;

A=zeros(1,7);
B=zeros(1,7);
P=zeros(1,7);

for i=1:7
    A(1,i)=a;
    B(1,i)=b;
    p=(a+b)/2;
    P(1,i)=p;
     if f(a)*f(p)>0
        a=p;
    end
    if f(a)*f(p)<0
        b=p;
    end
    p=(a+b)/2;
end


N=1:7;

Z=[N,A,B,P,f(P)];

table(N',A',B',P',Z(:,5)')

fprintf('n     a_n    b_n    p_n f(p_n)    \n');
fprintf('%5d  %10.3f %10.3f %10.3f\n',Z);

function y=f(x)
y=x.^3+4*x.^2-10;
end


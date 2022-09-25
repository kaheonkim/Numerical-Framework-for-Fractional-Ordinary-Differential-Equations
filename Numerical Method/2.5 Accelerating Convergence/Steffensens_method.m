tol=10^(-10);
p0=1.5;

for i=1:5
    p1=g(p0);
    p2=g(p1);
    p=p0-(p1-p0)^2/(p2-2*p1+p0);
    A(1,i)=p0;
    B(1,i)=p1;
    C(1,i)=p2;
    if abs(p-p0)<tol
    end
    if abs(p-p0)>=tol
        p0=p;
    end
end
N=1:5;

P=[N;A;B;C];

fprintf('n       p_0^(k)     p_1^(k)     p_2^(k) \n');
fprintf('%5d %3.9f  %3.9f %3.9f\n',P);
function y=g(x)
y=(10/(x+4))^(1/2);
end
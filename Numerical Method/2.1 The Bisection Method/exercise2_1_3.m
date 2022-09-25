a=input('함수 범위의 시작점은?');
b=input('함수 범위의 끝점은?');
n=1;
p=(a+b)/2;

while abs(f(p))>10^(-2) 
    
    if f(a)*f(p)>0
        a=p;
    end
    if f(a)*f(p)<0
        b=p;
    end
    p=(a+b)/2;
    n=n+1;
end

fprintf('%10.5f',n,p)

function y=f(x)
y=x^3-7*x^2+14*x-6;
end
a=input('함수 범위의 시작점은?');
b=input('함수 범위의 끝점은?');
n=1;

while abs(f(g(a,b)))>10^(-2) 
    if f(a)*f(g(a,b))>0
        a=g(a,b);
    end
    if f(a)*f(g(a,b))<0
        b=g(a,b);
    end
    if g(a,b)==0
    end
    n=n+1;
end

fprintf('%10.5f',n,g(a,b))
    
function w=g(a,b)
w=(a+b)/2;
end

function y=f(x)
y=x^4-2*x^3-4*x^2+4*x+4;
end
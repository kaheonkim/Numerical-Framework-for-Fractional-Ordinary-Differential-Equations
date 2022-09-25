a=input('함수의 시작점은?');
b=input('함수의 끝점은?');
n=0;


while n<3
    p=(a+b)/2;
    if f(a)*f(p)>0
        a=p;
    end
    if f(a)*f(p)<0
        b=p;
    end
    if f(p)==0
    end
    n=n+1
end

fprintf('%10.3f',p);

function y=f(x)
y=sqrt(x)-cos(x);
end


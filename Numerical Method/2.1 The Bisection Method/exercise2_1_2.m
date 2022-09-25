
a=input('함수의 시작점은?');
b=input('함수의 끝점은?');
n=0;

while n<3
    p=(a+b)/2;
    if fin(a)*fin(p)>0
        a=p;
    end
    if fin(a)*fin(p)<0
        b=p;
    end
    if fin(p)==0
    end
    n=n+1
end
fprintf('%10.3f',p)
function y=fin(x)
y=3*(x+1)*(x-(1/2))*(x-1);
end
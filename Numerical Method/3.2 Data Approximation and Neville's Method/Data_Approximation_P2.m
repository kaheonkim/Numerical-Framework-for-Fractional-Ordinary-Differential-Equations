x0=input('x0 값을 입력해주세요.');
x1=input('x1 값을 입력해주세요.');
x2=input('x2 값을 입력해주세요.');
y0=input('f(x0) 값을 입력해주세요.');
y1=input('f(x1) 값을 입력해주세요.');
y2=input('f(x2) 값을 입력해주세요.');
x=input('x값을 입력해주세요.');

fprintf('f(x)값은 ');
fprintf('%3.9f',P(x,x0,x1,x2,y0,y1,y2));

function y=P(x,x0,x1,x2,y0,y1,y2)
y=(x-x1)*(x-x2)*y0/((x0-x1)*(x0-x2))...
    +(x-x0)*(x-x2)*y1/((x1-x0)*(x1-x2))...
    +(x-x0)*(x-x1)*y2/((x2-x0)*(x2-x1))
end
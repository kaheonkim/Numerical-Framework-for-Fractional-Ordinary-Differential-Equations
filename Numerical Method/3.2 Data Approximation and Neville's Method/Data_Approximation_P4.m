x0=input('x0 값을 입력해주세요.');
x1=input('x1 값을 입력해주세요.');
x2=input('x2 값을 입력해주세요.');
x3=input('x3 값을 입력해주세요.');
x4=input('x4 값을 입력해주세요.');
y0=input('f(x0) 값을 입력해주세요.');
y1=input('f(x1) 값을 입력해주세요.');
y2=input('f(x2) 값을 입력해주세요.');
y3=input('f(x3) 값을 입력해주세요.');
y4=input('f(x4) 값을 입력해주세요.');
x=input('x값을 입력해주세요.');

fprintf('f(x)값은 ');
fprintf('%3.9f',P(x,x0,x1,x2,x3,x4,y0,y1,y2,y3,y4));

function y=P(x,x0,x1,x2,x3,x4,y0,y1,y2,y3,y4)
y=(x-x1)*(x-x2)*(x-x3)*(x-x4)*y0/((x0-x1)*(x0-x2)*(x0-x3)*(x0-x4))...
    +(x-x0)*(x-x2)*(x-x3)*(x-x4)*y1/((x1-x0)*(x1-x2)*(x1-x3)*(x1-x4))...
    +(x-x0)*(x-x1)*(x-x3)*(x-x4)*y2/((x2-x0)*(x2-x1)*(x2-x3)*(x2-x4))...
    +(x-x0)*(x-x1)*(x-x2)*(x-x4)*y3/((x3-x0)*(x3-x1)*(x3-x2)*(x3-x4))...
    +(x-x0)*(x-x1)*(x-x2)*(x-x3)*y4/((x4-x0)*(x4-x1)*(x4-x2)*(x4-x3));
end
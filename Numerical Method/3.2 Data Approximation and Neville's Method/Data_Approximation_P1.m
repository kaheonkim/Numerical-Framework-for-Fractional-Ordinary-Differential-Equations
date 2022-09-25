x0=input('x0 값을 입력해주세요.');
x1=input('x1 값을 입력해주세요.');
y0=input('f(x0) 값을 입력해주세요.');
y1=input('f(x1) 값을 입력해주세요.');
x=input('x값을 입력해주세요.');

fprintf('f(x)값은 ');
fprintf('%3.9f',P(x,x0,x1,y0,y1));

function y=P(x,x0,x1,y0,y1)
y=(x-x1)/(x0-x1)*y0+(x-x0)/(x1-x0)*y1
end
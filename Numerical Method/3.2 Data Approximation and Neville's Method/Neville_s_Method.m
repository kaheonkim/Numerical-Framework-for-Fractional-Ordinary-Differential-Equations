x(1)=input('x0 값을 입력하세요.');
x(2)=input('x1 값을 입력하세요.');
x(3)=input('x2 값을 입력하세요.');
x(4)=input('x3 값을 입력하세요.');
x(5)=input('x4 값을 입력하세요.');
z=input('x 값을 입력하세요.');
i=input('0부터 4까지의 숫자를 골라주세요.');
j=input('0부터 4까지의 전이랑 다 숫자를 골라주세요.');
k=input('0부터 4까지의 전 숫자들이랑 다른 숫자를 골라주세요.');

fprintf('f(x) 값은');
fprintf('%3.9f',P(z,x(i+1),x(j+1),x(k+1),f(x(i+1)),f(x(j+1)),f(x(k+1))));

function y=P(x,x1,x2,x3,y1,y2,y3)
y=(x-x2)*(x-x3)*y1/((x1-x2)*(x1-x3))...
    +(x-x1)*(x-x3)*y2/((x2-x1)*(x2-x3))...
    +(x-x1)*(x-x2)*y3/((x3-x1)*(x3-x2));
end

function y=f(x)
y=exp(x);
end
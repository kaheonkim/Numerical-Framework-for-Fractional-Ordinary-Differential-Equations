%x(1)=input('x0 값을 입력하세요.');
%y(1)=input('y0 값을 입력하세요.');

%x(2)=input('x1 값을 입력하세요.');
%y(2)=input('y1 값을 입력하세요.');

%x(3)=input('x2 값을 입력하세요.');
%y(3)=input('y2 값을 입력하세요.');

%x(4)=input('x3 값을 입력하세요.');
%y(4)=input('y3 값을 입력하세요.');

%x(5)=input('x4 값을 입력하세요.');
%y(5)=input('y4 값을 입력하세요.');

x(1)=1;
x(2)=1.3;
x(3)=1.6;
x(4)=1.9;
x(5)=2.2;

y(1)=0.7651977;
y(2)=0.6200860;
y(3)=0.4554022;
y(4)=0.2818186;
y(5)=0.1103623;

z=input('x값을 입력하세요.');

i=input('원하는 Q_(i,1)^(x)에서 i값 말해주세요.');

fprintf('f(x) approximates to');
fprintf('%3.9f',Q(z,x(i),x(i+1),y(i),y(i+1)));


function y=Q(x,x1,x2,y1,y2)
y=((x-x1)*y2-(x-x2)*y1)/(x2-x1);
end


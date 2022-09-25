A=zeros(4,5);

x(1)=1;
x(2)=1.3;
x(3)=1.6;
x(4)=1.9;
x(5)=2.2;
z=1.5;

y(1)=0.7651977;
y(2)=0.6200860;
y(3)=0.4554022;
y(4)=0.2818186;
y(5)=0.1103623;



for i=1:5
    A(i,1)=y(i);
end
for j=2:5
    for i=j:5
        A(i,j)=(A(i,j-1)-A(i-1,j-1))/(x(i)-x(i-j+1));
    end
end

fprintf('Forward Differences:');
fprintf('%f',P(A( 1,1),A(2,2),A(3,3),A(4,4),A(5,5),1/3,0.3));
fprintf('\nBackward Differences:');
fprintf('%f',P(A(5,1),A(5,2),A(5,3),A(5,4),A(5,5),-2/3,0.3));
fprintf('\nCentered Differences:');
fprintf('%f',Q(A(3,1),A(3,2),A(4,2),A(4,3),A(4,4),A(5,4),A(5,5),-1/3,0.3));

function y=P(x0,x1,x2,x3,x4,s,h)
y=x0+s*h*x1+s*(s-1)*h^2*x2+s*(s-1)*(s-2)*h^3*x3...
    +s*(s-1)*(s-2)*(s-3)*h^4*x4;
end

function y=Q(x0,x1,x2,x3,x4,x5,x6,s,h)
y=x0+s*h/2*(x1+x2)+h^2*s^2*x3+1/2*s*(s^2-1)*h^3*(x4+x5)...
    +s^2*(s^2-1)*h^4*x6;
end

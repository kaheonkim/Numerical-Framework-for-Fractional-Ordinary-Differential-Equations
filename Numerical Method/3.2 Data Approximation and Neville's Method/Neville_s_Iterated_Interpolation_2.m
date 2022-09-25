x(1)=1;
x(2)=1.3;
x(3)=1.6;
x(4)=1.9;
x(5)=2.2;
z=1.5;

y(1)=0.7651977;
y(2)=0.6200860;
y(3)=0.4554922;
y(4)=0.2818186;
y(5)=0.1103623;


function y=P(z,x,y,i,j)
if j==0
y=((z-x(i))*y(i+1)-(x-x(i+1))*y(i))/(x(i+1)-x(i));
return;
end
for i=1:5
    for j=1:i
        P(z,x,y,i,j)= ((z-x(i-j+1))*P(z,i,j-1)-(z-x(i+1))*P(x,i-1,j-1))...
            /(x(i+1)-x(i-j+1));
    end
end
end

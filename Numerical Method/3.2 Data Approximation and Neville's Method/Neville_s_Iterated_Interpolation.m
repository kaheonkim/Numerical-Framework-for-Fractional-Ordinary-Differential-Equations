x(1)=1;
x(2)=1.3;
x(3)=1.6;
x(4)=1.9;
x(5)=2.2;

y(1)=0.7651977;
y(2)=0.6200860;
y(3)=0.4554922;
y(4)=0.2818186;
y(5)=0.1103623;



i=input('Q_(i,j)(x)에서 i값은?');
j=input('Q_(i,j)(x)에서 j값은?');
x=input('Q_(i,j)(x)에서 x값은?');

function y=Q(i,j,x)
Q(i,0)=y(i+1)
for n=1:i
    for k=1:j
        y=((x-x(i-j+1))*Q(i,j-1,x)-(x-x(i+1))*Q(i-1,j-1,x))...
            /(x(i+1)-x(i-j+1));
    end
end
end



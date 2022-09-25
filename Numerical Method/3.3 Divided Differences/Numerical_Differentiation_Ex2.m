h=[0.1 -0.1 0.1 0.2 0.1];
%Original function
f=@(x) x*exp(x);
df=@(x) exp(x)+f(x);


x=input('x value');
%Three-Point Endpoint Formula
fe3=@(h) 1/(2*h)*(-3*f(x)+4*f(x+h)-f(x+2*h));

%Three-Point Midpoint Formula
fm3=@(h) 1/(2*h)*(f(x+1)-f(x-1));

%Five-Point Endpoint Formula
fe5=@(h) 1/(12*h)*(-25*f(x)+48*f(x+h)-36*f(x+2*h)+16*f(x+3*h)-3*f(x+4*h));

%Five-Point Midpoint Formula
fm5=@(h) 1/(12*h)*(f(x-2*h)-8*f(x-h)+8*f(x+h)-f(x+2*h));

H=[fe3(h(1)) fe3(h(2)) fm3(h(3)) fm3(h(4)) fm5(h(5))];

%Actual Error
for i=1:5
    HH(i)=abs(H(i)-df(x));
end

table(H',HH')
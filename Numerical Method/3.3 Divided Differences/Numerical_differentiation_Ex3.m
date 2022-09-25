%Original function
f=@(x) x*exp(x);
df=@(x) exp(x)+f(x);
ddf=@(x) exp(x)+exp(x)+f(x);
h=[0.1 0.2];

x=input('x value');

%Second Derivative Midpoint Formula
fM2=@(h) 1/h^2*(f(x-h)-2*f(x)+f(x+h));

H=[fM2(h(1)) fM2(h(2))];

for i=1:2
    HH(i)=(H(i)-ddf(x));
end                                                                                                                                                                            

table(h',H',HH')
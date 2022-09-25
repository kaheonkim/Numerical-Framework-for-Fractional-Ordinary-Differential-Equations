%original function
f=@(x) sin(x);
df=@(x) cos(x);

%x value(what we want to approximate)
x=0.900;

%approximation to f'(0.900)
af=@(h) (f(x+h)-f(x-h))/(2*h);

%h values
H=[0.001 0.002 0.005 0.010 0.020 0.050 0.100];

%estimated values
for i=1:7
    HH(i)=af(H(i));
end

%actual errors
for i=1:7
    HHH(i)=HH(i)-df(x);
end

table(H',HH',HHH')
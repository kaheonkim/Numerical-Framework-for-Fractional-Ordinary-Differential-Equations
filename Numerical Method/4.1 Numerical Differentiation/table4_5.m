x0=0.900;
H=[0.001 0.002 0.005 0.010 0.020 0.050 0.100];

f=@(x) sin(x);
df=@(x) cos(x);

for i=1:length(H)
    Df(i)=1/(2*H(i))*(-f(x0-H(i))+f(x0+H(i)));
    E(i)=abs(df(x0)-Df(i));
end

h=H';
Df=Df';
error=E';

table(h,Df,error)
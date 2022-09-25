x0=2;
f=@(x) x*exp(x);
df=@(x) exp(x)+x*exp(x);

H=[0.1, 0.2];

for i=1:length(H)
    
    ddf(i)=1/(H(i)^2)*(f(x0-H(i))-2*f(x0)+f(x0+H(i)));
end

h=H';
DDf=ddf';

table(h,DDf)
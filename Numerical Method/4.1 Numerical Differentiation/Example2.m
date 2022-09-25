x0=2;
f=@(x)x*exp(x);
df=@(x) exp(x)+x*exp(x);
H=[0.1,-0.1,0.2];

absf=@(x) abs(x-df(x0));

ap31=@(h) 1/(2*h)*(-3*f(x0)+4*f(x0+h)-f(x0+2*h));
ap32=@(h) 1/(2*h)*(f(x0+h)-f(x0-h));

ap51=@(h) 1/(12*h)*(f(x0-2*h)-8*f(x0-h)+8*f(x0+h)-f(x0+2*h));
ap52=@(h) 1/(12*h)*(-25*f(x0)+48*f(x0+h)-36*f(x0+2*h)+16*f(x0+3*h)-3*f(x0+4*h));

for i=1:length(H)
    AP3E(i)=absf(ap31(H(i)));
    AP3M(i)=absf(ap32(H(i)));
    AP5M(i)=absf(ap51(H(i)));
    AP5E(i)=absf(ap52(H(i)));
end
h=H';
TE=AP3E';
TM=AP3M';
FE=AP5E';
FM=AP5M';
table(h,TE,TM,FE,FM)
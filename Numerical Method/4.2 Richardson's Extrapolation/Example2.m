f=@(x) log(x);
H=[0.1 0.05];
n1=@(h) (f(1.8+h)-f(1.8))/h;

for i=1:length(H)
    N1(i)=n1(H(i));
end

N1=N1';
h=H';

table(h,N1)
N2=@(h) 2*n1(h/2)-n1(h);

fprintf('%f',N2(0.1));
f=@(x)log(x);
df=@(h) (f(1.8+h)-f(1.8))/h;

N=[0.1 0.05 0.01];
for i=1:length(N)
    DF1(i)=df(N(i));
    DF2(i)=abs(N(i))/(2*1.8^2);
end

table(N',DF1',DF2')
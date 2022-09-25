a=0;
b=pi/2;
TOL=10^(-10);
p_0=pi/4;
A=zeros(1,20);

%example.1
f = @(x) cos(x)-x;
df = @(x) -sin(x)-1;

%exmaple.2

for i=0:19
    A(1,i+1)=p_0;
    p=p_0-f(p_0)/df(p_0);
    if abs(p-p_0)<TOL
    end
    if abs(p-p_0)>TOL
        p_0=p;
    end
    
end

N=0:19;

number = N'; Approx = A';

Z=[N;A];

table(number,Approx)

fprintf('n   p_n \n');
fprintf('%5d %10.9f\n',Z);




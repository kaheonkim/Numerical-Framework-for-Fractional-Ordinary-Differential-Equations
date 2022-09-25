a=0;
b=pi/2;
TOL=10^(-10);
p_0=0.5;
p_1=pi/4;
A=zeros(1,20);
A(1,1)=p_0;
A(1,2)=p_1;

for i=2:19
    q_0=f(p_0);
    q_1=f(p_1);
    p_2=p_1-(q_1-p_1)*(p_1-p_0)/((q_1-p_1)-(q_0-p_0));
    if abs(p_2-p_1)<TOL
    end
    if abs(p_2-p_1)>TOL
        p_0=p_1;
        p_1=p_2;
    end
    A(1,i+1)=p_2;
end

N=0:19;

Z=[N;A];


fprintf('n   p_n \n');
fprintf('%5d %10.9f\n',Z);

function y=f(x)
y=cos(x);
end

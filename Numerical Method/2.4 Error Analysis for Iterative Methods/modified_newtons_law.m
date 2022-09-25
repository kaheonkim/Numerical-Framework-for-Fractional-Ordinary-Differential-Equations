p_0=1;
TOL=10^(-10);
P=zeros(1,5);
N=1:5;

for i=1:5
    p_1=p_0-(f0(p_0)*f1(p_0))/(f1(p_0)^2-f0(p_0)*f2(p_0));
    if abs(p_1-p_0)<TOL
    end
    if abs(p_1-p_0)>TOL
        p_0=p_1;
    end
    P(1,i)=p_0;
end

Z=[N;P];

table(N',P')
fprintf('    n     p_n\n');
fprintf('%g %.f \n',Z);

function y=f0(x)
    y=exp(x)-x-1;
end

function y=f1(x)
    y=exp(x)-1;
end

function y=f2(x)
    y=exp(x);
end


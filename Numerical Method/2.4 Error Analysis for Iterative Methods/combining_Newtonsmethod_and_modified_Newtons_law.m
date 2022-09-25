p_0=1.5;
q_0=1.5;
N=1:20;
TOL=10^-10;

for i=1:20
    p_1=p_0-f0(p_0)/f1(p_0);
    if abs(p_0-p_1)<TOL
    end
    if abs(p_0-p_1)>TOL
        p_0=p_1;
        a=i;
    end
    A(1,i)=p_0;
end

for i=1:20
    q_1=q_0-(f0(q_0)*f2(q_0))/(f1(q_0)^2-f0(q_0)*f2(q_0));
    if abs(q_0-q_1)<TOL
    end
    if abs(q_0-q_1)>TOL
        q_0=q_1;
        b=i;
    end
    B(1,i)=q_0;
end

Z=[N;A;B];
fprintf('n    p_n    q_n\n');
fprintf('%5d    %4.10f   %4.10f  \n',Z);

fprintf('%5d %5d',a,b);

function y=f0(x)
y=x^3+4*x^2-10;
end

function y=f1(x)
y=3*x^2+8*x;
end

function y=f2(x)
y=6*x+8;
end
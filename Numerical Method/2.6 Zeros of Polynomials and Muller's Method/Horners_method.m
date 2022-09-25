x0=-2;
n=0;
tol=10^-10;

for i=1:50
    x1=x0-P0(x0)/P1(x0);
    if abs(x0-x1)<tol
    end
    if abs(x0-x1)>tol
        A(1,i)=x0;
        n=n+1;
    end
    x0=x1;
end

N=1:n;

P=[N;A];
fprintf('n       x_n\n');
fprintf('%3d     %3.9f\n',P);


function y=P0(x)
y=2*x^4-3*x^2+3*x-4;
end

function y=P1(x)
y=8*x^3-6*x+3;
end


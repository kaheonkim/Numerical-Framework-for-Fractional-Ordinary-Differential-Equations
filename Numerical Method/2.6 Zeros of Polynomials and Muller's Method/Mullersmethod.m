p0=input('p0를 설정해주세요');
p1=input('p1을 설정해주세요');
p2=input('p2를 설정해주세요');
tol=10^-10;
A(1,1)=p0;
A(1,2)=p1;
for i=1:100
    h1=p1-p0;
    h2=p2-p1;
    d1=(f(p1)-f(p0))/h1;
    d2=(f(p2)-f(p1))/h2;
    d=(d2-d1)/(h2+h1);
    b=d2+h2*d;
    D=(b^2-4*f(p2)*d)^(1/2);
    if abs(b-D)<abs(b+D)
        E=b+D;
    else
        E=b-D;
    end
    h=-2*f(p2)/E;
    p=p2+h;
    if abs(h)>tol
        n=i+1;
        A(1,i+2)=p;
    end
    p0=p1;
    p1=p2;
    p2=p;
end
N=0:n;
A1=real(A);
A2=-imag(A);%켤레복소수도 근이 되기 때문에 복소수 파트는 음양의 부호가 상관 없는 것인가?
B=f(A);
B1=real(B);
B2=-imag(B);%앞에서와 마찬가지.
P=[N;A1;A2;B1;B2];
fprintf(' n   p_n   real        imag           f(p_n)       real      imag \n');
fprintf('%5d   %3.9f    %3.9f    %3.9f    %3.9f \n',P);

function y=f(x)
y=x.^4-3*x.^3+x.^2+x+1;
end

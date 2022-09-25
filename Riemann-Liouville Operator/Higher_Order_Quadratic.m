clear;clc;
%Alpha
al=0.25;
m=ceil(al);

%Starting point of the interval
T=1;

%Ending point of the interval
x0=0;

%number of iterlations
E=8;

%f of the given ODE
f=@(t,y) gamma(4+al)/6*t^3+t^(3+al)-y;

%exact solution
g = @(t) t^(3+al);



for i=1:E
    NN(i)=10*2^(i-1);
    N=10*2^(i-1);
    h=(T-x0)/N;
    Al=1/gamma(al);
    yi=zeros(1,N+3);
    
    yi=zeros(1,N+3);
    y1=zeros(1,N+3);
    y2=zeros(1,N+3);
    y3=zeros(1,N+3);
    
    f1=zeros(1,N+3);
    f2=zeros(1,N+3);
    f3=zeros(1,N+3);
    
    A0=zeros(1,N+3);
    A1=zeros(1,N+3);
    A2=zeros(1,N+3);
    A3=zeros(1,N+3);
    
    G1=1/al;
    G2=1/(al*(al+1));
    G3=1/(al*(al+1)*(al+2));
    a0=(al+4)/2;
    a1=-2*(al+3);
    a2=(2*al^2+9*al+12)/2;
    
    tt(1)=x0;
    tt(2)=x0+h/4;
    tt(3)=x0+h/2;
    for j=1:N
        tt(j+3)=x0+h*j;
    end
    
    p0=0;
    for k=1:m+1
        p0=p0+yi(k)*tt(k)^(k-1)*factorial(k-1);
    end
    
    y3(1)=yi(1);
    f3(1)=f(tt(1),y3(1));
    
    y2(2)=p0+Al*(1/al*(h/4)^al*f3(1));
    f2(2)=f(tt(2),y1(2));
    
    y3(2)=p0+Al*(1/al*(h/4)^al*f3(1)+1/(al*(al+1))*(h/4)^al*(f2(2)-f3(1)));
    f3(2)=f(tt(2),y3(2));
    
    y1(3)=p0+Al*1/al*(h/2)^al*f1(2);
    f1(3)=f(tt(3),y1(3));
    
    y2(3)=p0+Al*(1/al*(h/2)^al*f3(1)+1/(al*(al+1))*(h/2)^al*(f1(3)-f3(1)));
    f2(3)=f(tt(3),y2(3));
    
    y3(3)=p0+Al*(G1*(h/2)^al*f3(1)...
    -G2*(h/2)^(al+1)*(-3/h^2*f3(1)+4/h^2*f3(2)-1/h^2*f2(3)));
    f3(3)=f(tt(3),y3(3));
    
    y1(4)=p0+Al/al*h^al*f3(3);
    f1(4)=f(tt(4),y1(4));
    
    y2(4)=p0+Al*(G1*h^al*(2*f3(3)-f1(4))+2*G2*h^al*(f1(4)-f3(3)));
    f2(4)=f(tt(4),y2(4));
    
    y3(4)=p0+Al*((1/(3*h)*h^al-2/(al*(al+1))*h^al+8/(3*al*(al+1)*(al+2))*h^al)*f1(4)...
        +(-2/(al+1)*h^al+8/((al+1)*(al+2))*h^al)*f3(3)...
        +16/3*(1/(2*(al+1))*h^al-1/(al*(al+1))*h^al)*f3(2));
    f3(4)=f(tt(4),y3(4));
    
    y1(5)=p0+Al*f3(4)/al*(2*h)^al;
    f1(5)=f(tt(5),y1(5));
    
    y2(5)=p0+Al*(1/al*(2*h)^al*(3*f3(4)-2*f1(5))+(f1(5)-f3(4))*2/(al*(al+1))*(2*h)^al);
    f2(5)=f(tt(5),y2(5));
    
    y3(5)=p0+Al*(4/3*(2/(al+1)*(2*h)^al-4/(al*(al+1))*(2*h)^al)*f3(3)...
        +(-2/(al+1)*(2*h)^al+8/((al+1)*(al+2))*(2*h)^al)*f3(4)...
        +(1/(3*al)*(2*h)^al-2/(al*(al+1))*(2*h)^al+16/(3*al*(al+1)*(al+2))*(2*h)^al)*f2(5));
    f3(5)=f(tt(5),y3(5));
    
    

    B00=@(n) G1*(((n+1)*h)^al)...
        -G2*((n*h)^al*n+((n+1)*h)^al*3*(n+1))...
        -4*G3*((n*h)^al*n^2-((n+1)*h)^al*(n+1)^2);
    
    B10=@(n) 4*G2*((n*h)^al*n+((n+1)*h)^al*(n+1))...
        +8*G3*((n*h)^al*n^2-((n+1)*h)^al*(n+1)^2);
    
    B20=@(n) 2/(h^2)*...
    (-G1*(n*h)^al*h^2/2 ...
    -G2*((n*h)^(al+1)*3*h/2+((n+1)*h)^(al+1)*h/2)...
    -2*G3*((n*h)^(al+2)-((n+1)*h)^(al+2)));
    
    B0J=@(j,n) 1/(2*h^2)*(-h*G2*(((n-j)*h)^(al+1)+((n+1-j)*h)^(al+1))...
        -2*G3*(((n-j)*h)^(al+2)-((n+1-j)*h)^(al+2)));
    
    B1J=@(j,n) 1/(h^2)*(G1*((n+1-j)*h)^al*(h^2)...
        +G2*((n-j)*h)^(al+1)*2*h...
        +2*G3*(((n-j)*h)^(al+2)-((n+1-j)*h)^(al+2)));
    
    B2J=@(j,n) 1/(2*h^2)*(-G1*((n-j)*h)^al*2*h^2 ...
        -G2*(((n-j)*h)^(al+1)*3*h-(((n+1-j)*h)^(al+1)*h))...
    -2*G3*(((n-j)*h)^(al+2)-((n+1-j)*h)^(al+2)));
    
    
    %lag term1

    for l=1:N+3
        sol(l)=g(tt(l));
    end
    
    for l=6:N+3
        A0(l)=B00(l-4)*f3(1)+B10(l-4)*f3(3)+B20(l-4)*f3(4);
        if l==6
            A1(l)=B0J(1,l-4)*f3(1)+B1J(1,l-4)*f3(4)+B2J(1,l-4)*f3(5);
            A3(l)=a0*f3(1)+a1*f3(4)+a2*f3(5);
        else
            A1(l)=B0J(1,l-4)*f3(1)+B1J(1,l-4)*f3(4)+B2J(1,l-4)*f3(5);
            for j=2:l-5
                A1(l)=A1(l)+B0J(j,l-4)*f3(j+2)+B1J(j,l-4)*f3(j+3)+B2J(j,l-4)*f3(j+4);
            end
            A3(l)=a0*f3(l-3)+a1*f3(l-2)+a2*f3(l-1);
        end
            y2(l)=p0+Al*(A0(l)+A1(l))+h^al/gamma(al+3)*A3(l);
            f2(l)=f(tt(l),y2(l));
            A2(l)=B0J(l-4,l-4)*f3(l-2)+B1J(l-4,l-4)*f3(l-1)+B2J(l-4,l-4)*f2(l);
            y3(l)=p0+Al*(A0(l)+A1(l)+A2(l));
            f3(l)=f(tt(l),y3(l));
    end
    Err1(i)=abs(y3(N+3)-g(tt(N+3)));
    Err2(i)=max(abs(y3-sol));
    Err3(i)=sqrt(h*sum(y3-sol)^2);
    
end

for i = 1 : E
    for k = 1 : E-1
        ERR1(k) = log2(Err1(k)/Err1(k+1));
        ERR2(k) = log2(Err2(k)/Err2(k+1));
        ERR3(k) = log2(Err3(k)/Err3(k+1));
    end
end


     



for i=1:E-1
    NNN(i)=NN(i+1);
end



figure
plot(tt,sol,'r',tt,y3,'b-o')
grid on

figure
plot(tt,abs(sol-y3))



% figure
% plot(ttt',Err22')
% title('Qubic Error')
% 
% figure
% loglog(ttt',soll',ttt',y33')
% grid on
% 
% figure
% loglog(tt,sol,tt,y3)
% grid on
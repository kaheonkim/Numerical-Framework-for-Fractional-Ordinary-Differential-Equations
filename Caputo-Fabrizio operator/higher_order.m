clear;clc;

al=0.25;
m=ceil(al);

G1=1-al;
G2=al/(1-al);
G3=(1-al)/al;

yi=0;

%starting point
x0=0;

%ending point
T=1;


%Given equation
f=@(t,y) y-al*exp(t)*(-1+exp(t/(-1+al)));

%Exact solution
g=@(t) t*exp(t);

%number of iterations
E=10;


for i=1:E
    N=10*2^(i-1);
    h=(T-x0)/N;
    
    y=zeros(1,N+3);
    yp=zeros(1,N+3);
    ypp=zeros(1,N+3);
    
    y0=zeros(1,N+3);
    y1=zeros(1,N+3);
    y2=zeros(1,N+3);
    y3=zeros(1,N+3);
    
    ttt=zeros(1,N+3);
    ttt(1)=x0;
    ttt(2)=x0+h/4;
    ttt(3)=x0+h/2;
    
    for j=1:N
        ttt(j+3)=x0+h*j;
    end
        
    sol=zeros(1,N+3);
    
    for j=1:N+3
        sol(j)=g(ttt(j));
    end
    
    y(1)=yi;
    
    yp(2)=G1*f(ttt(2),y(1))+exp(-G2*ttt(2))*y(1)...
        +y(1)*(1-exp(-G2*h/4));
    
    y(2)=G1*f(ttt(2),yp(2))+exp(-G2*ttt(2))*y(1)...
        +yp(2)-exp(-G2*h/4)*y(1)...
        -G3*(yp(2)-y(1))/(h/4)*(1-exp(-G2*h/4));
    
    ypp(3)=G1*f(ttt(3),2*y(2)-y(1))+exp(-G2*ttt(3))*y(1)...
        +y(2)*(1-exp(-G2*h/2));
    
    yp(3)=G1*f(ttt(3),ypp(3))+exp(-G2*ttt(3))*y(1)...
        +ypp(3)-exp(-G2*h/2)*(2*y(2)-ypp(3))...
        -G3*(ypp(3)-y(2))/(h/4)*(1-exp(-G2*h/2));
    
    y(3)=G1*f(ttt(3),yp(3))+exp(-G2*ttt(3))*y(1)...
        +(yp(3)-exp(-G2*h/2)*y(1))...
        -G3*(2/h*y(1)-8/h*y(2)+6/h*yp(3)-exp(-G2*h/2)*(-6/h*y(1)+8/h*y(2)-2/h*yp(3)))...
        +G3^2*(16/h^2*y(1)-32/h^2*y(2)+16/h^2*yp(3))*(1-exp(-G2*h/2));
    
    ypp(4)=G1*f(ttt(4),3*y(1)-8*y(2)+6*y(3))+exp(-G2*ttt(4))*y(1)...
        +y(3)*(1-exp(-G2*h));
    
    yp(4)=G1*f(ttt(4),ypp(4))+exp(-G2*ttt(4))*y(1)...
        +ypp(3)-exp(-G2*h)*(2*y(3)-ypp(4))...
        -G3*(ypp(4)-y(3))/(h/2)*(1-exp(-G2*h));
    
    y(4)=G1*f(ttt(4),yp(4))+exp(-G2*ttt(4))*y(1)...
        +yp(4)-exp(-G2*h)*(8/3*y(2)-2*y(3)++1/3*yp(4))...
        -G3*(8/(3*h)*y(2)-6/h*y(3)+10/(3*h)*yp(4)-exp(-G2*h)*(-8/h*y(2)+10/h*y(3)-2/h*yp(4)))...
        +G3^2*(32/(3*h^2)*y(2)-16/h^2*y(3)+16/(3*h^2)*yp(4))*(1-exp(-G2*h));
    
    ypp(5)=G1*f(ttt(5),8*y(2)-14*y(3)+7*y(4))+exp(-G2*ttt(5))*y(1)...
        +y(1)*(1-exp(-G2*2*h));
    
    yp(5)=G1*f(ttt(5),ypp(5))+exp(-G2*ttt(5))*y(1)...
        +ypp(5)-exp(-G2*2*h)*(2*y(4)-ypp(5))...
        -G3*(ypp(5)-y(4))/h*(1-exp(-G2*2*h));
    
    y(5)=G1*f(ttt(5),yp(5))+exp(-G2*ttt(5))*y(1)...
        +yp(5)-exp(-G2*2*h)*(8/3*y(3)-2*y(4)+1/3*yp(5))...
        -G3*(4/(3*h)*y(3)-3/h*y(4)+5/(3*h)*yp(5)-exp(-G2*2*h)*(-4/h*y(3)+5/h*y(4)-1/h*yp(5)))...
        +G3^2*(8/(3*h^2)*y(3)-4/(h^2)*y(4)+4/(3*h^2)*yp(5))*(1-exp(-G2*2*h));
    
    ypp(6)=G1*f(ttt(6),8/3*y(3)-5*y(4)+10/3*y(5))+exp(-G2*ttt(6))*y(1)...
        +y(5)*(1-exp(-G2*3*h));
    
    yp(6)=G1*f(ttt(6),ypp(6))+exp(-G2*ttt(6))*y(1)...
        +ypp(6)-exp(-G2*3*h)*(3*y(5)-2*ypp(6))...
        -G3*(ypp(6)-y(5))/h*(1-exp(-G2*3*h));
    
    y(6)=G1*f(ttt(6),yp(6))+exp(-G2*ttt(6))*y(1)...
        +yp(6)-exp(-G2*3*h)*(3*y(4)-3*y(5)+yp(6))...
        -G3*(1/(2*h)*y(4)-2/h*y(5)+3/(2*h)*yp(6)-exp(-G2*3*h)*(-5/(2*h)*y(4)+4/h*y(5)-3/(2*h)*yp(6)))...
        +G3^2*(1/h^2*y(4)-2/h^2*y(5)+1/h^2*yp(6))*(1-exp(-G2*3*h));
    
    
    for l=6:N+2
        y0(l+1)=(1-al)*f(ttt(l+1),y(l-2)-3*y(l-1)+3*y(l))+exp(-G2*ttt(l+1))*y(1);
        y1(l+1)=exp(-G2*(l-4)*h)*y(5)-exp(-G2*(l-2)*h)*y(1)...
            -G3*(exp(-G2*(l-4)*h)*(1/(2*h)*y(1)-2/h*y(4)+3/(2*h)*y(5))-exp(-G2*(l-2)*h)*(-3/(2*h)*y(1)+2/h*y(4)-1/(2*h)*y(5)))...
            +G3^2*(1/h^2*y(1)-2/h^2*y(4)+1/h^2*y(5))*(exp(-G2*(l-4)*h)-exp(-G2*(l-2)*h));
        for k=6:l
            y2(l+1)=y2(l+1)...
                +exp(-G2*(l-k+1)*h)*y(k)-exp(-G2*(l-k+3))*y(k-2)...
                -G3*(exp(-G2*(l-k+1)*h)*(1/(2*h)*y(k-2)-2/h*y(k-1)+3/(2*h)*y(k))-exp(-G2*(l-k+3)*h)*(-3/(2*h)*y(k-2)+2/h*y(k-1)-1/(2*h)*y(k)))...
                +G3^2*(1/(h^2)*y(k-2)-2/(h^2)*y(k-1)+1/(h^2)*y(k))*(exp(-G2*(l-k+1)*h)-exp(-G2*(l-k+3)));
        end
        y2(l+1)=y(l-2)-3*y(l-1)+3*y(l)-exp(-G2*2*h)*y(l-1)...
            -G3*(3/(2*h)*y(l-2)-4/h*y(l-1)+5/(2*h)*y(l)-exp(-G2*2*h)*(-1/(2*h)*y(l-2)+1/(2*h)*y(l)))...
            +G3^2*(1/(h^2)*y(l-2)-2/(h^2)*y(l-1)+1/(h^2)*y(l))*(1-exp(-G2*2*h));
        y(l+1)=y0(l+1)+y1(l+1)+y2(l+1);
    end
end
abss=abs(sol-y);
plot(ttt,sol,ttt,y,'--')
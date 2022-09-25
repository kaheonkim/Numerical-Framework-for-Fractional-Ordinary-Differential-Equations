clear;clc;

al=0.25;
m=ceil(al);

G1=1-al;
G2=al/(1-al);
G3=1/G2;

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
E=12;

error=zeros(1,E);
con=zeros(1,E-1);
tic()
for i=1:E
    N=10*2^(i-1);
    h=(T-x0)/N;
    
    tt=zeros(1,N+1);
    sol1=zeros(1,N+1);
    tt(1)=x0;
    
    for j=1:N
        tt(j+1)=x0+h*j;
    end
    
    y1=zeros(1,N+1);
    y1(1)=yi;
    ya=(1-al)*f(tt(1)+h/2,y1(1))+exp(-1/G1*(tt(1)+h/2))*y1(1)...
        +y1(1)*(1-exp(-1/G1*h/2));
    
    yb=(1-al)*f(tt(1)+h/2,ya)+exp(-1/G1*tt(1)+h/2)*y1(1)...
        +(ya-exp(-1/G1*h/2)*y1(1))...
        -G1*(ya-y1(1))/(h/2)*(1-exp(-1/G1*h/2));
    
    yc=(1-al)*f(tt(2),2*yb-y1(1))+exp(-1/G1*tt(2))*y1(1)...
        +yb*(1-exp(-1/G1*h));
    y1(2)=(1-al)*f(tt(2),yc)+exp(-1/G1*tt(2))*y1(1)...;
        +yc-exp(-1/G1*h)*(2*y1(2)-yc)...
        -G1*(yc-y1(2))/(h/2)*(1-exp(-1/G1*h));
    
    
    
    H=zeros(1,N+1); 
    H(2)=G3*y1(1)*(1-exp(-G2*h));
    
    for j=1:N-1
        H(j+2)=exp(-G2*h)*H(j+1)+G3*(2*y1(j+1)-y1(j)-exp(-G2*h)*y1(j+1))...
            -(y1(j+1)-y1(j))/h*G3^2*(1-exp(-G2*h));
        y1(j+2)=G1*f(tt(j+2),2*y1(j+1)-y1(j))+exp(-G2*tt(j+2))*y1(1)...
            +G2*H(j+2);
    end
    
    for j=1:N+1
        sol1(j)=g(tt(j));
    end
    
    error1(i)=abs(y1(end)-sol1(end));
    error2(i)=sqrt(h*sum((y1-sol1).^2));
    
end
toc()
for i=1:E-1
    con1(i)=log2(error1(i)/error1(i+1));
    con2(i)=log2(error2(i)/error2(i+1));
end

error1=error1';
error2=error2';
cvgr1=[0;con1'];
cvgr2=[0;con2'];
N=1:E;N=N';

table(N,cvgr1,cvgr2)

% figure()
plot(tt,y1,'b',tt,sol1,'r')
% 
% 
figure()
plot(tt,abs(y1-sol1))
% title('error')

for i=1:4
    abss(i)=abs(y1(i)-sol1(i));
end
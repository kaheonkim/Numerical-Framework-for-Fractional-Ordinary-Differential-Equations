clear; clc;
al=0.25;
m=ceil(al);

f=@(t,y) y-al*exp(t)*(-1+exp(t/(-1+al)));

g=@(t) t*exp(t);

yi=0;

x0=0;
T=1;
E=8;

err1=zeros(1,E);
err2=zeros(1,E);
err3=zeros(1,E);
err4=zeros(1,E);
NN=zeros(1,E);
tic()
for i=1:E
    N=10*2^(i-1);
    NN(i)=10*2^(i-1);
    
    y1=zeros(1,N+1);
    y11=zeros(1,N+1);
    y12=zeros(1,N+1);
    
    y2=zeros(1,N+1);
    y21=zeros(1,N+1);
    y22=zeros(1,N+1);
    
    y3=zeros(1,N+1);
    y31=zeros(1,N+1);
    y32=zeros(1,N+1);
    
    y4=zeros(1,N+2);
    y4p=zeros(1,N+2);
    y4pp=zeros(1,N+2);
    y41=zeros(1,N+2);
    y42=zeros(1,N+2);
    
    f1=zeros(1,N+1);
    f2=zeros(1,N+1);
    f3=zeros(1,N+1);
    f4=zeros(1,N+2);
    f4p=zeros(1,N+2);
    f4pp=zeros(1,N+2);
    
    tt=zeros(1,N+1);
    ttt=zeros(1,N+2);
    
    
    sol1=zeros(1,N+1);
    sol2=zeros(1,N+2);
    
    
    h=(T-x0)/N; 
    G1=(1-al)/al;
    
    
    for l=0:N
        tt(l+1)=x0+h*l;
    end
    
    for l=1:N
        ttt(1)=x0;
        ttt(2)=x0+h/2;
        ttt(l+2)=x0+h*l;
    end
    f0=f(x0,yi);
    
    y1(1)=yi(1);
    y1(2)=g(tt(2));
    
    y2(1)=yi(1);
    y2(2)=g(tt(2));
    
    y3(1)=yi(1);
    y3(2)=g(tt(2));
    
    f1(1)=f(tt(1),y1(1));
    f1(2)=f(tt(2),y1(2));
    
    f2(1)=f(tt(1),y2(1));
    f2(2)=f(tt(2),y2(2));
    
    f3(1)=f(tt(1),y3(1));
    f3(2)=f(tt(2),y3(2));
    
    for j=1:N-1
        y11(j+2)=(1-al)*f1(j+1)+y1(1)*exp(-1/G1*tt(j+2));
        y12(j+2)=y1(1)*(1-exp(-al/(1-al)*h));
        for k=1:j
            y12(j+2)=y12(j+2)+y1(k)*(exp(-1/G1*h*(j-k))-exp(-1/G1*h*(1+j-k)));
        end
        y1(j+2)=y11(j+2)+y12(j+2);
        f1(j+2)=f(tt(j+2),y1(j+2));
    end
    
    for j=1:N+1
        sol1(j)=g(tt(j));
    end
    
    for j=1:N+2
        sol2(j)=g(ttt(j));
    end
    

    for j=1:N-1
        y21(j+2)=(1-al)*(2*f2(j+1)-f2(j))+exp(-1/G1*tt(j+2))*y2(1);
        y22(j+2)=2*y2(j+1)-y2(j)-exp(-1/G1*h)*y2(j+1)-G1*(y2(j+1)-y2(j))/h*(1-exp(-1/G1*h));
        for k=0:j-1
            y22(j+2)=y22(j+2)+exp(-1/G1*(j-k)*h)*y2(k+2)-exp(-1/G1*(j+1-k)*h)*y2(k+1)...
                -G1*(y2(k+2)-y2(k+1))/h*(exp(-1/G1*(j-k)*h)-exp(-1/G1*(j+1-k)*h));
        end
        y2(j+2)=y21(j+2)+y22(j+2);
        f2(j+2)=f(tt(j+2),y2(j+2));
    end

    
    for j=1:N-1
        y31(j+2)=(1-al)*f(tt(j+2),2*y3(j+1)-y3(j))+exp(-1/G1*tt(j+2))*y3(1);
        y32(j+2)=2*y3(j+1)-y3(j)-exp(-1/G1*h)*y3(j+1)-G1*(y3(j+1)-y3(j))/h*(1-exp(-1/G1*h));
        for k=0:j-1
            y32(j+2)=y32(j+2)+exp(-1/G1*(j-k)*h)*y3(k+2)-exp(-1/G1*(j+1-k)*h)*y3(k+1)...
                -G1*(y3(k+2)-y3(k+1))/h*(exp(-1/G1*(j-k)*h)-exp(-1/G1*(j+1-k)*h));
        end
        y3(j+2)=y31(j+2)+y32(j+2);
        f3(j+2)=f(tt(j+2),y3(j+2));
    end
    
    
    
   
    
    y4(1)=yi(1);
    f4(1)=f(ttt(1),y4(1));
    
    y4p(2)=(1-al)*f(ttt(2),y4(1))+exp(-1/G1*ttt(2))*y4(1)...
        +y4(1)*(1-exp(-1/G1*h/2));
    f4p(2)=f(ttt(2),y4p(2));
    
    y4(2)=(1-al)*f4p(2)+exp(-1/G1*ttt(2))*y4(1)...
        +(y4p(2)-exp(-1/G1*h/2)*y4(1))...
        -G1*(y4p(2)-y4(1))/(h/2)*(1-exp(-1/G1*h/2));
    f4(2)=f(ttt(2),y4(2));
    
    y4p(3)=(1-al)*f(ttt(3),2*y4(2)-y4(1))+exp(-1/G1*ttt(3))*y4(1)...
        +y4(2)*(1-exp(-1/G1*h));
    f4p(3)=f(ttt(3),y4p(3));
    
    y4(3)=(1-al)*f4p(3)+exp(-1/G1*ttt(3))*y4(1)...;
        +y4p(3)-exp(-1/G1*h)*(2*y4(2)-y4p(3))...
        -G1*(y4p(3)-y4(2))/(h/2)*(1-exp(-1/G1*h));
    f4(3)=f(ttt(3),y4(3));
    
    y4(4)=(1-al)*f(ttt(4),2*y4(3)-y4(2))+exp(-1/G1*ttt(4))*y4(1)...
        +exp(-1/G1*h)*y4(3)-exp(-1/G1*2*h)*y4(1)...
        -G1*(y4(3)-y4(1))/h*(exp(-1/G1*h)-exp(-1/G1*2*h))...
        +2*y4(3)-y4(1)-exp(-1/G1*h)*y4(3)...
        -G1*(y4(3)-y4(1))/h*(1-exp(-1/G1*h));
    
    
    
   for j=3:N
       y41(j+2)=(1-al)*f(ttt(j+2),2*y4(j+1)-y4(j))+exp(-1/G1*ttt(j+2))*y4(1);
       y42(j+2)=exp(-1/G1*(j-1)*h)*y4(3)-exp(-1/G1*j*h)*y4(1)...
           -G1*(y4(3)-y4(1))/h*(exp(-1/G1*(j-1)*h)-exp(-1/G1*j*h))...
           +2*y4(j+1)-y4(j)-exp(-1/G1*h)*y4(j+1)...
           -G1*(y4(j+1)-y4(j))/h*(1-exp(-1/G1*h));
       for k=2:j-1
           y42(j+2)=y42(j+2)...
               +exp(-1/G1*(j-k)*h)*y4(k+2)-exp(-1/G1*(j-k+1)*h)*y4(k+1)...
               -G1*(y4(k+2)-y4(k+1))/h*(exp(-1/G1*(j-k)*h)-exp(-1/G1*(j-k+1)*h));
       end
       y4(j+2)=y41(j+2)+y42(j+2);
   end
    
    err1(i)=abs(y1(end)-sol1(end));
    err2(i)=abs(y2(end)-sol1(end));
    err3(i)=abs(y3(end)-sol1(end));
    err4(i)=abs(y4(end)-sol2(end));
    err41(i)=sqrt(h*sum(y4-sol2)^2);
    
end
toc()
con1=zeros(1,E-1);
con2=zeros(1,E-1);
con3=zeros(1,E-1);
con4=zeros(1,E-1);

for i=1:E-1
    con1(i)=log2(err1(i)/err1(i+1));
    con2(i)=log2(err2(i)/err2(i+1));
    con3(i)=log2(err3(i)/err3(i+1));
    con4(i)=log2(err4(i)/err4(i+1));
    con41(i)=log2(err41(i)/err41(i+1));
end

EE=1:E;
EEE=1:E-1;
EE = EE';
error1 = err1';roc1 = [0;con1'];
error2 = err2';roc2 = [0;con2'];
error3 = err3';roc3 = [0;con3'];
error4 = err4';roc4 = [0;con4'];
error41=err41';roc41=[0;con41'];



table(error1,roc1,error2,roc2,error3,roc3,error4,roc4,error41,roc41)

figure()
plot(tt,y2,'--',tt,sol1)
title('second order graph(y2)')

figure()
plot(tt,abs(y2-sol1))
title('second order error(y2)')

figure()
plot(tt,y3,'--',tt,sol1)
title('second order graph(y3)')

figure()
plot(tt,abs(y3-sol1))
title('second order error(y3)')
figure()
plot(tt,y1,'--',tt,sol1)
title('y1')

figure()
plot(tt,y2,'--',tt,sol1)
title('y2')

figure()
plot(tt,y3,'--',tt,sol1)
title('y3')


figure()
plot(ttt,y4,'b',ttt,sol2,'r')

figure()
plot(ttt,abs(y4-sol2))
title('second order error(y4)')
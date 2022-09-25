clear;clc;
T=1;
x0=0;
al=0.25;
m=ceil(al);

f=@(t,y) gamma(4+al)/6*t^3+t^(3+al)-y;

%Number of Iteration
E=8;
%Exact Solution
g = @(t) t^(3+al);

R=zeros(1,E+1);
R(1)=1;
RR=zeros(1,E+1);
RRR=zeros(1,E+1);
%Initial values
yi=zeros(1,m+1);
f3(1)=f(0,yi(1));
NN=zeros(1,E);
NNN=zeros(1,E);

for i=1:E-1
    NNN(i)=NN(i+1);
end
for i = 1 : E
    
 N = 10*2^(i-1);
 NN(i)=10*2^(i-1);
 NNN(i)=1/(10*2^(i-1));
 h=(T-x0)/N;
 tt=zeros(1,N+1);
 sol=zeros(1,N+1);
 for l=1:N+1
     tt(l) =x0+h*(l-1);
     sol(l)=g(tt(l));
 end
 
%initial value

B0=@(n,j) 1/al*((n+1-j)*h)^al+1/(h*al*(al+1))...
    *(((n-j)*h)^(al+1)-((n+1-j)*h)^(al+1));
B1=@(n,j) -1/al*((n-j)*h)^al-1/(h*al*(al+1))...
    *(((n-j)*h)^(al+1)-((n+1-j)*h)^(al+1));
%y2: SPECE Method, y3: Second Order Method
y2(1)=0;
y3(1)=1/gamma(al)*B0(-1,-1)*f(tt(1),0);
p0=0;
for k=1:m+1
    p0=p0+yi(k)*tt(k)^(k-1)*factorial(k-1);
end

y2(2)=p0+h^al/gamma(al+2)*(al+2)*f(tt(1),y3(1));
f2(2)=f(tt(2),y2(2));
y3(2)=1/gamma(al)*(B1(0,0)*f2(2)+B1(0,0)*f2(2));
f3(2)=f(tt(2),y3(2));
r=zeros(1,N+1);
r(1)=abs(g(tt(1))-p0);
r(2)=abs(g(tt(2))-p0-h^al/gamma(al+2)*(al+2)*f(tt(1),g(tt(1))));
YY=zeros(1,N+1);


%y2(2)=y2_(1)
for j=2:N
    p1=0;
    for k=1:m+1
        p1=p1+yi(k)*tt(j)^(k-1)/factorial(k-1);
    end
    B00=0;
    B11=0;
    B000=0;
    B111=0;
    for l=1:j-1
        B00=B00+B0(j-1,l-1)*f3(l);
        B11=B11+B1(j-1,l-1)*f3(l+1);
    end
    for l=1:j-1
        B000=B000+B0(j-1,l-1)*f(tt(l),g(tt(l)));
        B111=B111+B1(j-1,l-1)*f(tt(l+1),g(tt(l+1)));
    end
    y2(j+1)=p1+1/gamma(al)*(B00+B11)+h^al/gamma(al+2)*(-f3(j-1)+(al+2)*f3(j));
    f2(j+1)=f(tt(j+1),y2(j+1));
    y3(j+1)=p1+1/gamma(al)*(B00+B11)+1/gamma(al)*(B0(j-1,j-1)*f3(j)+B1(j-1,j-1)*f2(j+1));
    f3(j+1)=f(tt(j+1),y3(j+1));
    r(j+1)=abs(g(tt(j+1))-p1-1/gamma(al)*(B000+B111)-h^al/gamma(al+2)...
        *(-g(tt(j-1))+(al+2)*g(tt(j))));
end
Errpt1(i)=abs(y3(N+1)-g(tt(N+1)));
Errm1(i) = max(abs(sol-y3));
ErrL12(i) = sqrt(h*sum((abs(sol-y3)).^2));
Errpt2(i)=abs(y2(N+1)-g(tt(N+1)));
Errm2(i) = max(abs(sol-y2));
ErrL22(i) = sqrt(h*sum((abs(sol-y2)).^2));
R(i)=r(N+1);
ERR(i)=abs(g(tt(N+1))-y3(N+1));
end

for i=1:N+1
    sol1(i)=g(tt(i));
    sol2(i)=abs(g(tt(i))-y3(i));
end

for i = 1 : E
    NN(i,:) = 2^(i-1);
    for k = 1 : E-1
        Ohf1(k) = log2(Errpt1(k)/Errpt1(k+1));
        Ohm1(k) = log2(Errm1(k)/Errm1(k+1));
        OhL12(k) = log2(ErrL12(k)/ErrL12(k+1));
        Ohf2(k) = log2(Errpt2(k)/Errpt2(k+1));
        Ohm2(k) = log2(Errm2(k)/Errm2(k+1));
        OhL22(k) = log2(ErrL22(k)/ErrL22(k+1));
        RR(k)=abs(R(k)/R(k+1));
        RRR(k)=log2(RR(k));
    end
    EOPT1 = Errpt1(:);
    EOCPT1 = [0;Ohf1(:)];
    EOM1 = Errm1(:);
    EOCM1 = [0;Ohm1(:)];
    EOL12 = ErrL12(:);
    EOCL12 = [0;OhL12(:)];
    EOPT2 = Errpt2(:);
    EOCPT2 = [0;Ohf2(:)];
    EOM2 = Errm2(:);
    EOCM2 = [0;Ohm2(:)];
    EOL22 = ErrL22(:);
    EOCL22 = [0;OhL22(:)];
    table(NNN',EOCPT1,EOCL12,EOCM1,EOCPT2,EOCL22,EOCM2)
end



for i=1:N+1
    sol(i)=g(tt(i));
    Err2(i)=abs(y3(i)-sol(i));
end



figure
plot(tt,y3,'b-o',tt,sol1,'r')
grid on

% figure
% plot(tt,Err2)
% grid on
% 
% figure 
% loglog(tt,y3)
% grid on
% 
% table(NN',ERR')

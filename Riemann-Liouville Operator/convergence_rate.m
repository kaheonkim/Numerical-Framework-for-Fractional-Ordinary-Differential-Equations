clear;clc;
%% Basic Setting
al=0.25;
m=ceil(al);
x0=0;
T=2;
%number of iterations
E=10;
yi = zeros(1,m+1);

f=@(t,y) gamma(4+al)/6*t^3+t^(3+al)-y;

g = @(t) t^(3+al);

%initial values
yi(1) = 0;


%y(j) 
for i = 1 : E
%% Making background
 % Internal Variables
 N = 10*2^(i-1);
 l(i)=10*2^(i-1);
 h = (T-x0)/N;
 G1 = h^al/gamma(al+1);
 G2 = h^al/gamma(al+2);
 y = zeros(1,N+1);
 y(1) = yi(1);
 tt=zeros(1,N+1);
 tt(1)=x0;
 for j=1:N
     tt(j+1)=x0+h*j;
 end

 %% Calculating for Coefficients
 b = zeros(1,N);
 a = zeros(1,N);
 for k = 1 : N
  b(k) = k^al-(k-1)^al;
  a(k) = (k+1)^(al+1)-2*k^(al+1)+(k-1)^(al+1);
 end
 
 for j = 1 : N

  p1 = 0;
  for k = 0 : m-1
   p1 = p1 + ((j*h)^k/factorial(k))*yi(k+1);
  end


  p2 = 0;
  for k = 0 : j-1
   p2 = p2 + b(j-k)*f(x0+k*h,y(k+1));
  end
  
 p = p1 + G1*p2;
 

  y2 = 0;
  for k = 1 : j-1
   y2 = y2 + a(j-k)*f(x0+k*h,y(k+1));
  end

  y(j+1) = p1 + G2*(f(x0+j*h,p)+(((j-1)^(al+1))-(j-1-al)*(j^al))*f(x0,y(1))+y2);

 end
 
sol = zeros(1,N+1);
for j = 1 : N+1
    sol(j) = g(x0+(h*(j-1)));
end

%Chenk Maximum Error
%fprintf("%f, %d, %f\n", mpt,mi,merr);

err1(i) = abs(sol(end)-y(end));
err2(i) = max(abs(sol-y));
err3(i) = sqrt(h*sum((abs(sol-y)).^2));
end
 


for i=1:E-1
    q1(i)=log2(abs(err1(i)/err1(i+1)));
    q2(i)=log2(abs(err2(i)/err2(i+1)));
    q3(i)=log2(abs(err3(i)/err3(i+1)));
    n(i)=1/(10*2^(i-1));
end

%1~7
plot(tt,sol,'r',tt,y,'b-o')
grid on
table(n',q1',q2',q3')
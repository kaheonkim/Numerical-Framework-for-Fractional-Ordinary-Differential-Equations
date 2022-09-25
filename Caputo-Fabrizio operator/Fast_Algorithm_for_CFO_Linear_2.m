%% Caputo-Fabrizio Linear Method

% Kind of Method; 1 = Classic, 2 = Fast 
kind = 2;

%% Choose interval
% starting node
x0 = 0;
% ending node
T = 1;

%% Examples
% Example.1 - Good.
% al = 4/5;
% m = ceil(al);
% yi = zeros(1,m+1);
% M = @(x) 1;
% f = @(t,y) M(al)*(0.625*exp(-4*t)-0.625+2.5*t)+t^4-y^2;
% g = @(t) t^2;

% Example.2 - Vary Vary bad.
% al = 0.1; % - al can be 0.1, 0.5 and 0.9
% m = ceil(al);
% yi = zeros(1,m+1);
% M = @(x) 1;
% f = @(t,y) ((al-al^2-1)*exp(al*t/(al-1))-(1+2*al*(-1+al))*(-1+2*al*t)-al*((1-3*al+4*al^2)*cos(t)+al*sin(t)))/(al+2*al^2*(al-1)) + 2*y;
% g = @(t) t+cos(t);

% Example.3 - Good!
al = 0.9; % - al can be 0.1, 0.5 and 0.9
m = ceil(al);
yi = zeros(1,m+1);
M = @(x) 1;
f = @(t,y) -al*exp(t)*(-1+exp(t/(-1+al))) + y;
g = @(t) t*exp(t);

% Example.4 - Good....?
% al = 0.5;
% m = ceil(al);
% yi = zeros(1,m+1);
% M = @(x) 1;
% f = @(t,y) 6*t^2 - 18*t + 19 - 19*exp(-t) ;
% g = @(t) t^3 -1.5*t^2+0.5*t;


% Example.5 - graph is good error is good. but convergence rate is very bad...
% al = 0.99; % - al can be 0.99, 0.95 and 0.85
% m = ceil(al);
% yi = zeros(1,m+1);
% M = @(x) 1;
% f = @(t,y) t^2 + 2*t^(2-al)/gamma(3-al) - y;
% g = @(t) t^2;

% Example.6 - bad...
% al = 0.9; % - al can be 0.99, 0.95 and 0.9
% m = ceil(al);
% yi = zeros(1,m+1);
% M = @(x) 1;
% f = @(t,y) t^4 - 0.5*t^3 + 3*t^(3-al)/gamma(4-al) + 24*t^(4-al)/gamma(5-al)-y;
% g = @(t) t^4 - 0.5*t^3;

% Example.7 - Graph is similar but convergence rate is bad
% al = 0.98; % - al can be 0.98, 0.95 and 0.9
% m = ceil(al);
% yi = zeros(1,m+1);
% M = @(x) 1;
% f = @(t,y) 1 - y^2;
% g = @(t) (exp(2*t)-1)/(exp(2*t)+1);

% Example.8
% al = 0.5; %0.2, 0.5, 0.8
% m = ceil(al);
% yi = zeros(1,m+1);
% M = @(x) 1;
% f = @(t,y) (al+al*t-1)/al^2 - exp(-al*t/(1-al))*(al-1)/al^2 + y^2 - t^4/4;
% g = @(t) t^2/2;

% Example.9
% al = 0.2; %0.5, 0.8
% m = ceil(al);
% yi = zeros(1,m+1);
% M = @(x) 1;
% f = @(t,y) exp(-t)*(al+t+exp(t*(2*al-1)/(al-1))-2*al*t-2*al*exp(t*(2*al-1)/(al-1)))/(2*al-1)^2 ...
%     + (9*al...
%     + 2*exp(-al*t/(1-al))...
%     + 2*al*t...
%     - 9*al*exp(-al*t/(1-al))...
%     - 8*al^2*t...
%     + 8*al^3*t...
%     -12*al^2 ...
%     +4*al^3 ...
%     +11*al^2*exp(-al*t/(1-al))...
%     -3*al^3*exp(-al*t/(1-al))...
%     -2)...
%     /(al^2*(2*al-1)^2)...
%     + y^2 - (t*exp(-t)-t+t^2)^2;
% g = @(t) t*exp(-t)-t+t^2;

% Example.10
% al = 0.2; %0.2, 0.5, 0.8
% m = ceil(al);
% yi = zeros(1,m+1);
% M = @(x) 1;
% f = @(t,y) (((al - 1)*(al*sin(2*t) - 2*cos(2*t) + 2*al*cos(2*t)))/(5*al^2 - 8*al + 4) - (exp((al*t)/(al - 1))*(2*al - 2)*(al - 1))/(5*al^2 - 8*al + 4))/(al - 1) + (2*(((al - 1)*(4*cos(2*t) - 4*al*sin(2*t) + 8*t*sin(2*t) + 11*al^2*cos(2*t) - 3*al^3*cos(2*t) + 8*al^2*sin(2*t) - 4*al^3*sin(2*t) - 12*al*cos(2*t) + 4*al*t*cos(2*t) - 24*al*t*sin(2*t) - 8*al^2*t*cos(2*t) + 5*al^3*t*cos(2*t) + 26*al^2*t*sin(2*t) - 10*al^3*t*sin(2*t)))/(5*al^2 - 8*al + 4)^2 + (exp((al*t)/(al - 1))*(al - 1)*(3*al^3 - 11*al^2 + 12*al - 4))/(5*al^2 - 8*al + 4)^2))/(al - 1) + (sin(t)*((48*al^7 - 144*al^6 + 120*al^5 + 90*al^4 - 240*al^3 + 180*al^2 - 60*al + 15/2)/(2*al^2 - 2*al + 1)^4 - 3/2) - t^3*sin(t)*(1/(2*(2*al^2 - 2*al + 1)) - 1/2) + (6*t*sin(t)*(- 2*al^6 + 12*al^5 - 27*al^4 + 29*al^3 - 15*al^2 + 3*al))/(2*al^2 - 2*al + 1)^3 + (t^3*cos(t)*(al - 1)^2)/(2*al^2 - 2*al + 1) - (24*al*exp((al*t)/(al - 1))*(2*al^6 - 11*al^5 + 25*al^4 - 30*al^3 + 20*al^2 - 7*al + 1))/(2*al^2 - 2*al + 1)^4 + (24*al*cos(t)*(2*al^6 - 11*al^5 + 25*al^4 - 30*al^3 + 20*al^2 - 7*al + 1))/(2*al^2 - 2*al + 1)^4 + (6*al*t^2*cos(t)*(al - 1)^3)/(2*al^2 - 2*al + 1)^2 + (6*t*cos(t)*(al - 1)^4*(2*al^2 + 2*al - 1))/(2*al^2 - 2*al + 1)^3 + (3*t^2*sin(t)*(2*al - 1)*(al - 1)^2)/(2*al^2 - 2*al + 1)^2)/(al - 1) + (3*(t^2*cos(t)*(1/(2*(2*al^2 - 2*al + 1)) - 1/2) + (2*sin(t)*(al - 1)^4*(2*al^2 + 2*al - 1))/(2*al^2 - 2*al + 1)^3 - (2*al*exp((al*t)/(al - 1))*(2*al^5 - 12*al^4 + 27*al^3 - 29*al^2 + 15*al - 3))/(2*al^2 - 2*al + 1)^3 + (2*al*cos(t)*(2*al^5 - 12*al^4 + 27*al^3 - 29*al^2 + 15*al - 3))/(2*al^2 - 2*al + 1)^3 + (t^2*sin(t)*(al - 1)^2)/(2*al^2 - 2*al + 1) - (2*t*cos(t)*(al - 1)*(2*al^2 - 3*al + 1))/(2*al^2 - 2*al + 1)^2 - (4*t*sin(t)*(al - 1)^2*(- al^2 + al))/(2*al^2 - 2*al + 1)^2))/(al - 1) + y^2 - (t*sin(2*t)-t^3*cos(t))^2;
% g = @(t) t*sin(2*t)-t^3*cos(t);

% Example.11
% al = 0.9; %0.2, 0.5, 0.8
% m = ceil(al);
% yi = zeros(1,m+1);
% M = @(x) 1;
% beta = al/(1-al);
% f = @(t,y) M(al)*(6*(exp(-beta*t)-1)+2*beta*(3*t+exp(-beta*t)-1)+beta^2*(2*t-3*t^2))/(beta^2*al)+y^2-(t^2-t^3)^2;
% g = @(t) t^2-t^3;

% Example.12
% al = 0.5; %0.2, 0.5, 0.8
% m = ceil(al);
% yi = zeros(1,m+1);
% M = @(x) 1;
% beta = al/(1-al);
% if al == 0.5
%     f = @(t,y) -2*M(al)*(exp(-t) + t*exp(-t) - 1);
% else
%     f = @(t,y) -M(al)*((exp(-beta*t)-1)-beta*(exp(-t)-1))/(beta*(beta-1)*(al-1)) +y^2 - (exp(-t)-1+t)^2;
% end
% g = @(t) exp(-t)-1+t;

% Example.13
% al = 0.8; %0.2, 0.5, 0.8
% m = ceil(al);
% yi = zeros(1,m+1);
% M = @(x) 1;
% beta = al/(1-al);
% f = @(t,y) M(al)*(beta^3*(exp(-beta*t)-cos(t)+t*sin(t))-beta^2*(2*sin(t)+t*cos(t))-t*cos(t)+beta*(cos(t)-exp(-beta*t)+t*sin(t)))/((beta^2+1)^2*(al-1))+y^2-t^2*cos(t)^2;
% g = @(t) t*cos(t);

% choose initial value
yi(1) = g(x0);


%%  # of repetitive
E = 8;

%% # of Starting Theory
ST = 1;

Errpt = zeros(1,E);
Errm = zeros(1,E);
ErrL2 = zeros(1,E);

%% Body of Algorithm
for i = 1 : E
    %% Making background
    % Internal Variables
    N = 10*2^(i-1);
    h = (T-x0)/N;
    
    AL = (1-al)/(al*h);
    IAL = (al*h)/(1-al);
    AA = al/(1-al);
    IAA = 1/AA;
    
    y = zeros(1,N+1);
    y(1) = yi(1);

    %% making coefficient
    if kind == 1
       a = zeros(1,N);
       for j = 1 : N
           a(j) = AL^2*(exp(IAL*(j-1)) - 2*exp(IAL*j) + exp(IAL*(j+1)));
       end
    end
    
    %% Body of Process
    %Classical Method
    if kind == 1
          for n = 1 : N
              if n == 1
                  %% Starting Theory
                  % calculating y_{1/4} node
                  yq = y(1);
                  for ii = 1 : ST
                      yq = (...
                          (1-al)*f(x0+h/4,yq)/M(al)...
                          +exp(-IAL/4)*y(1)...
                          -y(1)*(exp(-IAL/4)-IAA*(4/h)*(1-exp(-IAL/4)))...
                          )...
                          /(IAA*(4/h)*(1-exp(-AA*h/4)));
                  end
                  Historyfunction = -y(1)*(exp(-IAL/4)-IAA*(4/h)*(1-exp(-IAL/4))) + yq*(1-IAA*(4/h)*(1-exp(-IAL/4)));
                  % calculating y_{1/2} node
                  yh = -y(1)+2*yq;
                  for ii = 1 : ST
                      yh = (...
                          (1-al)*f(x0+h/2,yh)/M(al)...
                          +exp(-IAL/2)*y(1)...
                          +exp(-AA*h/4)*Historyfunction...
                          -(IAA*(2/h)*(1-exp(-IAL/4))-IAA^2*(16/h^2)*(1-exp(-IAL/4)))*y(1)...
                          -(exp(-IAL/4)-IAA*(8/h)+2*IAA^2*(16/h^2)*(1-exp(-IAL/4)))*yq...
                          )...
                          /(IAA*(6/h-exp(-AA*h/4)*2/h)-IAA^2*(16/h^2)*(1-exp(-AA*h/4)));
                  end
                  Historyfunction = -(IAA*(2/h)*(1-exp(-IAL/4)) -IAA^2*(16/h^2)*(1-exp(-IAL/4)))*y(1)...
                      -(exp(-IAL/4) -IAA*(8/h) +2*IAA^2*(16/h^2)*(1-exp(-IAL/4)))*yq...
                      +(1 -IAA*(6/h-exp(-IAL/4)*2/h) +IAA^2*(16/h^2)*(1-exp(-IAL/4)))*yh;
                  % calculating y_1 node
                  y(2) = 3*y(1)-8*yq+6*yh;
                  for ii = 1 : ST
                      y(2) = (...
                          (1-al)*f(x0+h,y(2))/M(al)...
                          +exp(-IAL)*y(1)...
                          +exp(-IAL/2)*Historyfunction...
                          +(-AL*(1+exp(-IAL/2))+AL^2*4*(1-exp(-IAL/2)))*y(1)...
                          -(exp(-IAL/2)-AL*4+AL^2*8*(1-exp(-IAL/2)))*yh...
                          )...
                          /(AL*(3-exp(-IAL/2))-AL^2*4*(1-exp(-IAL/2)));
                  end  
              else
                  % initial value
                  y1 = exp(-al*(x0+h*n)/(1-al))*y(1);

                  % making y2 
                  y2 = 0;
                  for j = 1 : n-2
                      y2 = y2 + a(j)*y(j+1);
                  end

                  % making predictor of Classical method
                  yp = ((1-al)*f(x0+h*n,-y(n-1)+2*y(n))/M(al) + y1 + exp(-IAL*n)*(1-AL*(exp(IAL)-1))*y(1) + IAL*exp(-IAL*n)*y2 + AL*(1-2*exp(-IAL)+exp(-IAL*2))*y(n))*IAL/(1-exp(-IAL));

                  % making answer
                  y(n+1) = ((1-al)*f(x0+h*n,yp)/M(al) + y1 + exp(-IAL*n)*(1-AL*(exp(IAL)-1))*y(1) + IAL*exp(-IAL*n)*y2 + AL*(1-2*exp(-IAL)+exp(-IAL*2))*y(n))*IAL/(1-exp(-IAL));
              end
          end
          
    else
          %Fast Method
          Historyfunction = 0;
          for n = 1 : N
              if n == 1
                  %% Starting Theory
%                   y(2) = g(h);
                  % calculating y_{1/4} node
                  yq = y(1);
                  for ii = 1 : ST
                      yq = (...
                          (1-al)*f(x0+h/4,yq)/M(al)...
                          +exp(-IAL/4)*y(1)...
                          -y(1)*(exp(-IAL/4)-IAA*(4/h)*(1-exp(-IAL/4)))...
                          )...
                          /(IAA*(4/h)*(1-exp(-AA*h/4)));
                  end
                  Historyfunction = -y(1)*(exp(-IAL/4)-IAA*(4/h)*(1-exp(-IAL/4))) + yq*(1-IAA*(4/h)*(1-exp(-IAL/4)));
                  % calculating y_{1/2} node
                  yh = -y(1)+2*yq;
                  for ii = 1 : ST
                      yh = (...
                          (1-al)*f(x0+h/2,yh)/M(al)...
                          +exp(-IAL/2)*y(1)...
                          +exp(-AA*h/4)*Historyfunction...
                          -(IAA*(2/h)*(1-exp(-IAL/4))-IAA^2*(16/h^2)*(1-exp(-IAL/4)))*y(1)...
                          -(exp(-IAL/4)-IAA*(8/h)+2*IAA^2*(16/h^2)*(1-exp(-IAL/4)))*yq...
                          )...
                          /(IAA*(6/h-exp(-AA*h/4)*2/h)-IAA^2*(16/h^2)*(1-exp(-AA*h/4)));
                  end
                  Historyfunction = -(IAA*(2/h)*(1-exp(-IAL/4)) -IAA^2*(16/h^2)*(1-exp(-IAL/4)))*y(1)...
                      -(exp(-IAL/4) -IAA*(8/h) +2*IAA^2*(16/h^2)*(1-exp(-IAL/4)))*yq...
                      +(1 -IAA*(6/h-exp(-IAL/4)*2/h) +IAA^2*(16/h^2)*(1-exp(-IAL/4)))*yh;
                  % calculating y_1 node
                  y(2) = 3*y(1)-8*yq+6*yh;
                  for ii = 1 : ST
                      y(2) = (...
                          (1-al)*f(x0+h,y(2))/M(al)...
                          +exp(-IAL)*y(1)...
                          +exp(-IAL/2)*Historyfunction...
                          +(-AL*(1+exp(-IAL/2))+AL^2*4*(1-exp(-IAL/2)))*y(1)...
                          -(exp(-IAL/2)-AL*4+AL^2*8*(1-exp(-IAL/2)))*yh...
                          )...
                          /(AL*(3-exp(-IAL/2))-AL^2*4*(1-exp(-IAL/2)));
                  end

                  %making historyfunction
                  Historyfunction = 0;
                  Historyfunction = exp(-IAL)*Historyfunction - y(1)*(AL*exp(-IAL)-AL^2*(1-exp(-IAL))) + y(2)*(AL-AL^2*(1-exp(-IAL)));
              else
                 %making predictor of Fast method
                 yp = ((1-al)*f(x0+h*n,-y(n-1)+2*y(n))/M(al)...
                      + exp(-AA*(x0+h*n))*y(1)...
                      + IAL*exp(-IAL)*Historyfunction...
                      - y(n)*(exp(-IAL)-AL*(1-exp(-IAL))))*IAL/(1-exp(-IAL));
 
                 %making answer
                 y(n+1) = ((1-al)*f(x0+h*n,yp)/M(al)...
                          + exp(-AA*(x0+h*n))*y(1)...
                          + IAL*exp(-IAL)*Historyfunction...
                          - y(n)*(exp(-IAL)-AL*(1-exp(-IAL))))*IAL/(1-exp(-IAL));
              
                 %making historyfunction
                 Historyfunction = exp(-IAL)*Historyfunction - y(n)*(AL*exp(-IAL)-AL^2*(1-exp(-IAL))) + y(n+1)*(AL-AL^2*(1-exp(-IAL)));
              end
          end
    end
    %% Calculating for Solution & Error
    sol = zeros(1,N+1);
    merr = 0;
    for j = 1 : N+1
        sol(j) = g(x0+(h*(j-1)));
        err1 = abs(sol(j)-y(j));
        if err1 > merr
            merr = err1;
            mpt = h*(j-1);
            mi = j;
        end
    end
    %Chenk Maximum Error
    %fprintf("%f, %d, %f\n", mpt,mi,merr);
    Errpt(i) = abs(sol(end)-y(end));
    Errm(i) = max(abs(sol-y));
    ErrL2(i) = sqrt(h*sum((abs(sol-y)).^2));
end

%% Calculating for Convergence rate
%making for the number of time steps that the algorithm
NN = zeros(E,1);
for i = 1 : E
    NN(i,:) = 2^(i-1);
end
if E == 1
    Approximate = y(:);
    Exact = sol(:);
    Abs_Error = zeros(N+1,1);
    for i = 1 : N+1
        Abs_Error(i,1) = abs(sol(i)-y(i));
    end
    table(Approximate,Exact,Abs_Error)
    
elseif E > 1
    Ohf = zeros(1,E-1);
    Ohm = zeros(1,E-1);
    OhL2 = zeros(1,E-1);
    for i = 1 : E-1
        Ohf(i) = log2(Errpt(i)/Errpt(i+1));
        Ohm(i) = log2(Errm(i)/Errm(i+1));
        OhL2(i) = log2(ErrL2(i)/ErrL2(i+1));
    end
    EOPT = Errpt(:);
    EOCPT = [0;Ohf(:)];
    EOM = Errm(:);
    EOCM = [0;Ohm(:)];
    EOL2 = ErrL2(:);
    EOCL2 = [0;OhL2(:)];
    table(NN,EOPT,EOCPT,EOL2,EOCL2,EOM,EOCM)
%     table(NN,EOM,EOCM,EOL2,EOCL2)
%     table(NN,EOM,EOCM,EOL2,EOCL2)
end

t = linspace(x0,T,N+1);
NN = 10*NN;
Stepsize = zeros(1,E);
for j = 1 : E
    Stepsize(j) = 10*2^(j-1);
end
[~,m1,~] = regression(log10(Stepsize),log10(Errpt));

[~,m2,~] = regression(log10(Stepsize),log10(ErrL2));

[~,m3,~] = regression(log10(Stepsize),log10(Errm));

%% Drawing figure
figure
loglog(NN,Errpt,'-d',NN,ErrL2,'-s',NN,Errm,'-o')
title('log-log plot of errors vs. h');
xlabel('Stepsize = 1/h')
ylabel('error')
legend('Pointwise error at Final time','L2 error','Max error')

figure
plot(t,sol,t,y,'--')
title('Graph of Exact solution and Approximation')
legend('Exact','Approximation')

figure
plot(t,abs(sol-y))
title('Error of between Approximation value and exact value')
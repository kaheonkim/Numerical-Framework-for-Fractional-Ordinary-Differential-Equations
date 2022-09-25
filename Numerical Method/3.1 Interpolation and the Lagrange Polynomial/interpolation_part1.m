x0=input('x0을 골라주세요.');
x1=input('x1를 골라주세요.');
x2=input('x2를 골라주세요.');
xf=input('x를 골라주세요.');


fprintf('f(x)=')
fprintf('%3.9f',f(xf));
fprintf('\n P(x)=');
fprintf('%3.9f',P(xf,x0,x1,x2));

X=linspace(0,10);
Y=f(X);
y=P(X,x0,x1,x2);
plot(X,Y,X,y);
grid on
legend('exact','approx')

function y=P(x,x0,x1,x2)
y=L0(x,x0,x1,x2).*f(x0)+L1(x,x0,x1,x2).*f(x1)...
+L2(x,x0,x1,x2).*f(x2);
end


function y=L0(x,x0,x1,x2)
y=(x-x2).*(x-x1)./((x0-x1).*(x0-x2));
end

function y=L1(x,x0,x1,x2)
y=(x-x0).*(x-x2)./((x1-x2).*(x1-x0));
end

function y=L2(x,x0,x1,x2)
y=(x-x0).*(x-x1)./((x2-x1).*(x2-x0));
end


function y=f(x)
y=1./x;
end

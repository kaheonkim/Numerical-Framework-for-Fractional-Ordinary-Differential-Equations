for i=1:10
    A(1,i)=cos(1/i);
    p_1=A(1,i);
    p_2=cos(1/(i+1));
    p_3=cos(1/(i+2));
    p_1_=p_1-((p_2-p_1)^2)/((p_3-2*p_2+p_1));
    B(1,i)=p_1_;
end

N=1:10;
C=[N;A;B];
fprintf('n    p_0    p_hat_n\n');
fprintf('%5d        %3.9f       %3.9f      \n',C);
fun = @(x) 2*x(1) + exp(x(2));
x0 = [1,2];
A  = [2,1;3,2];
b  = [3;3];
Aeq = [5,1;2,2];
beq = [4;2];
lb = [2,1];
ub = [4,4];

fmincon(fun,x0,A,b,Aeq,beq,lb,ub,@nonlcon1);

function [c,ceq] = supernonlincon(x)
[c1, ceq1] = nlconboostandsust(x);
[c2, ceq2] = nlconsust(x);
c = [c1; c2];
ceq = [ceq1; ceq2];
end
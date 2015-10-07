function L = applyPreconditioner(z,A0,c,tau)
% Function that apply the preconditioner to vector Z

Z = reshape(z,size(A0));
n = size(A0,1);
A = A0' + c*eye(n);
B = A0 - c*eye(n);
Tm1Z = solveTSylverster(A,B,Z);
L = Tm1Z * expm(tau*A0/2);
L = vec(L);
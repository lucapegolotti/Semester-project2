function LcX = applyLc(A0,A1,c,X,tau,nsteps)
% check that X is a matrix 
stepsize = tau/(2*nsteps);                     
[Z1,Z2] = solveODE(A0,A1,X,tau/2,stepsize,'RK4');
n = size(A0);
Z1 = reshape(Z1,n);
Z2 = reshape(Z2,n);
Z2 = Z2';
I = eye(n(1));
LcX = Z2' * (A0 - c*I) + (A0' + c*I)*Z2+Z1' * A1 + A1' * Z1;
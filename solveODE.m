function [Z1,Z2] = solveODE(A0,A1,X,tau,stepsize)

% Computes the value of Z1(tau/2) and Z2(tau/2)
stepsize
n = size(A0,1);
x1 = vec(X);
x2 = vec(X');
x = [x1;x2];                                          % Setting initial condition for Z1 and Z2
A = assembleA(A0,A1,n);
z = explicitEuler(A,x,stepsize,0,tau/2);            % I temporarly use explicitEuler for simplicity


Z1 = z(1:n^2);
Z2 = z(n^2+1:end);



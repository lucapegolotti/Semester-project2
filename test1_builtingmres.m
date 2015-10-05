%% This code reproduces the first test of the paper. To change method, change the argument of solveODE in applyLC
clear all
clc

alpha = 1;
A0 = [-26 22 -1 -4; 2 -24 -4 1; 7 11 -24 -22; -13 15 -1 -9];
n = size(A0,1);
A1 = alpha*diag([-1,-0.5,0,0.5]);
W = eye(n);
Xin = zeros(n);
nsteps = 100;
tau = 1;
c = 1;
fun = @(x) vec(applyLc(A0,A1,c,x,tau,nsteps));
prec = @(x) applyPreconditioner(x,A0,c,tau);
X = gmres(fun,-vec(W),[],1e-2,20,prec);
L = retrieveOperator(A0,A1,1,1,nsteps);
cond(applyPreconditioner(L,A0,c,tau))
display('Solution of Linear system')

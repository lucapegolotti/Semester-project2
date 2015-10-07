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
X = GMRESforLcxWithPrec(A0,A1,1,Xin,1,-W,1e-3,nsteps);                  
L = retrieveOperator(A0,A1,1,1,nsteps);

display('Solution of Linear system')
X

[100*X(:),-100*(L\vec(W))]

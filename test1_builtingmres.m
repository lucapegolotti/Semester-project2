%% This code reproduces the first test of the paper. To change method, change the argument of solveODE in applyLC
clear all
clc

% Setting parameters
alpha = 1;
A0 = [-26 22 -1 -4; 2 -24 -4 1; 7 11 -24 -22; -13 15 -1 -9];
n = size(A0,1);
A1 = alpha*diag([-1,-0.5,0,0.5]);
W = eye(n);
Xin = zeros(n);
nsteps = 400;
tau = 1;
c = 1;
% Defining the linear operator
fun = @(x) vec(applyLc(A0,A1,c,reshape(x,[n,n]),tau,nsteps));

% Defining the preconditioner 
prec = @(x) applyPreconditioner(x,A0,c,tau);
X = gmres(fun,-vec(W),[],1e-8,n^2,prec);
% X = gmres(fun,-vec(W),[],1e-3,n^2);
L = retrieveOperator(A0,A1,1,1,nsteps);


Lexact = -(L\vec(W));
[100*X(:),100*Lexact]
abs(Lexact - X(:))./abs(Lexact)


clear all
clc

% Test for the solution of the T-Sylvester equation A*X + X'*B = C

n = 100;
A = rand(n);
B = rand(n);
C = rand(n);
X = solveTSylverster(A,B,C);
display('||A*X + X^T B - C|| = ');
norm(A*X + X'*B - C)/norm(X)
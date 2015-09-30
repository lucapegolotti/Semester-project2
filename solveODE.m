function [Z1,Z2] = solveODE(A0,A1,X,tau,stepsize,varargin)
% Computes the value of Z1(tau/2) and Z2(tau/2)
n = size(A0,1);
x1 = vec(X);
x2 = vec(X');
x = [x1;x2];                                          % Setting initial condition for Z1 and Z2
A = assembleA(A0,A1,n);
if (nargin==0)
    z = explicitEuler(A,x,stepsize,0,tau);            % Use explicit Euler for default
else
    if (strcmp(varargin(1),'FWDEULER'))
        z = explicitEuler(A,x,stepsize,0,tau); 
    end
    if (strcmp(varargin(1),'ODE45'))
    f = @(t,x) A*x;
    [~,z] = ode45(f,[0,tau],x);
    z = z(end,:);
    end
    if (strcmp(varargin(1),'RK4'))
    z = RK4(A,x,stepsize,0,tau); 
    end
end
Z1 = z(1:n^2);
Z2 = z(n^2+1:end);



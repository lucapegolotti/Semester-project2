%% this script reproduces the plot of test1

clear all
clc

% Setting parameters
alphavec = [1e-3 1e-2 1e-1 1 10];
A0 = [-26 22 -1 -4; 2 -24 -4 1; 7 11 -24 -22; -13 15 -1 -9];
n = size(A0,1);
W = eye(n);
Xin = zeros(n);
nsteps = 400;
tau = 1;
c = 1;
er1 = zeros(16,5);
count = 0;
for alpha = alphavec
    count = count + 1
    for maxit = 1:16;
        A1 = alpha*diag([-1,-0.5,0,0.5]);
        % Defining the linear operator
        fun = @(x) vec(applyLc(A0,A1,c,reshape(x,[n,n]),tau,nsteps));
        % Defining the preconditioner 
        prec = @(x) applyPreconditioner(x,A0,c,tau);
        [X] = gmres(fun,-vec(W),[],1e-16,maxit,prec);
        L = retrieveOperator(A0,A1,1,1,nsteps);
        er(maxit,count) = norm(X-L\(-vec(W)),'fro');
    end
end

semilogy(1:16,er(:,1),'-x','Linewidth',2)
hold on
semilogy(1:16,er(:,2),'-x','Linewidth',2)
semilogy(1:16,er(:,3),'-x','Linewidth',2)
semilogy(1:16,er(:,4),'-x','Linewidth',2)
semilogy(1:16,er(:,5),'-x','Linewidth',2)
legend('GMRES, norm A1 = 10^-3','GMRES, norm A1 = 10^-2','GMRES, norm A1 = 10^-1','GMRES, norm A1 = 10^0','GMRES, norm A1 = 10^1')
hold off

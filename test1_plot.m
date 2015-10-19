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
er = zeros(16,5);
erBCGstab = zeros(16,5);
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
        [X] = bicgstab(fun,-vec(W),1e-16,maxit,prec);
        erBCGstab(maxit,count) = norm(X-L\(-vec(W)),'fro');
    end
end
%%
semilogy(1:16,erBCGstab(:,1),'-xk','Linewidth',2,'Markersize',10)
hold on
semilogy(1:16,erBCGstab(:,2),'-ok','Linewidth',2,'Markersize',10)
semilogy(1:16,erBCGstab(:,3),'-sk','Linewidth',2,'Markersize',10)
semilogy(1:16,erBCGstab(:,4),'-dk','Linewidth',2,'Markersize',10)
semilogy(1:16,erBCGstab(:,5),'-^k','Linewidth',2,'Markersize',10)
semilogy(1:16,er(:,1),'--xr','Linewidth',2,'Markersize',10)
semilogy(1:16,er(:,2),'--or','Linewidth',2,'Markersize',10)
semilogy(1:16,er(:,3),'--sr','Linewidth',2,'Markersize',10)
semilogy(1:16,er(:,4),'--dr','Linewidth',2,'Markersize',10)
semilogy(1:16,er(:,5),'--^r','Linewidth',2,'Markersize',10)
I = legend('BCGstab $ \|A1\| = 10^{-3}$', ...
           'BCGstab $ \|A1\| = 10^{-2}$', ...
           'BCGstab $ \|A1\| = 10^{-1}$', ...
           'BCGstab,$ \|A1\| = 10^{0}$',  ...
           'BCGstab,$ \|A1\| = 10^{1}$',  ...
           'GMRES $ \|A1\| = 10^{-3}$',   ...
           'GMRES $ \|A1\| = 10^{-2}$',   ...
           'GMRES $ \|A1\| = 10^{-1}$',   ...
           'GMRES $ \|A1\| = 10^{0}$',    ...
           'GMRES $ \|A1\| = 10^{1}$')
set(I,'Interpreter','Latex');
hold off
set(gca,'fontsize', 18)
grid on
ylabel('Relative error');
xlabel('Iteration');
axis([1 16 1e-13 1])
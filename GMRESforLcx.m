function [X,k] = GMRESforLcx(A0,A1,c,Xin,tau,W,tol,nsteps)
n = size(A0);
Lc = @(x) vec(applyLc(A0,A1,c,reshape(x,n),tau,nsteps));
b = vec(W);
x0 = vec(Xin);
r = b - Lc(x0);
b = norm(r);
u = r/b;
U = u;
k = 0;
bj = tol + 1;
while bj>tol*b
    k = k+1;
    display(['Iteration of GMRES = ',num2str(k)]);
    e1 = zeros(k+1,1);
    e1(1) = 1;
    w = Lc(U(:,end));
    h = U'*w;
    up1 = w - U*h;
    hj = norm(up1);
    uj = up1/hj;
    U = [U,uj];
    if k~=1
        Hnew = zeros(k+1,k);
        Hnew(1:k,1:k-1)=H;
        Hnew(1:k,k) = h;
        Hnew(k+1,k) = hj;
        H = Hnew;
    else
        H = zeros(2,1);
        H(1) = h;
        H(2) = hj;
    end
    yj = H\(b*e1);
    bj = norm(e1*b-H*yj);
    display(['Residual = ',num2str(bj)]);
    
end
x = x0 + U(:,1:end-1)*yj;
X = reshape(x,n);
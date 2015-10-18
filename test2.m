clear all
clc

nx = 3;
ny = 3;
n = 2 * nx * ny;

hx = 1/(nx+1);
hy = 1/(ny+1);

% create D
Dxx = 1/hx^2 * full(gallery('tridiag',nx,1,-2,1));
Dyy = 1/hy^2 * full(gallery('tridiag',ny,1,-2,1));
Dx  = 1/hx   * full(gallery('tridiag',nx,-1,0,1));

% create F 
f0 = 5;
x = hx:hx:1-hx;
y = hy:hy:1-hy;
[X,Y] = meshgrid(x,y);
f = @(x,y) cos(x.*y).*sin(pi.*x);
F = f(X,Y);
% surf(F);
F = F(:);

% assemble matrices
Ix = eye(nx);
Iy = eye(ny);
Ixy= eye(nx*ny);
ey = zeros(ny,1); ey((nx+1)/2) = 1;
ex = zeros(nx,1); ex((ny+1)/2) = 1;

Zxy = zeros(nx*ny);
A0 = [Zxy Ixy; kron(Iy,Dxx) + kron(Dyy,Ix) Ixy];
A1 = [Zxy Zxy;diag(F)*(kron(Iy,Dx)) Zxy];
% C  = [kron(ey',ex') zeros(1,nx*ny)]
C0 = rand(nx*ny*2);
W = C0'*C0;

c = 1;
tau = 1;
nsteps = 500;
% Defining the linear operator
fun = @(x) vec(applyLc(A0,A1,c,reshape(x,[n,n]),tau,nsteps));

% Defining the preconditioner 
prec = @(x) applyPreconditioner(x,A0,c,tau);
tic 
X = gmres(fun,-vec(W),[],1e-12,n^2,prec);
display (strcat('Computation time = ',num2str(toc)));








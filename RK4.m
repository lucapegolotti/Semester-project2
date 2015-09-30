function z = RK4(A,x,stepsize,t0,t1)
%Fourth order non adaptive Runge Kutta method for the solution of y' = A*y
n = length(x);
t = t0;
z = x;
a = [0 0 0; 5/24 1/3 -1/24; 1/6 2/3 1/6];
a = kron(a,A);
b = [1/6;2/3;1/6];
A = kron(eye(3),A);
while t<t1
   t = t + stepsize;
   Z = [z;z;z];
   K = (eye(3*n)-stepsize*a)\A*Z;
   z = z + stepsize*(b(1)*K(1:n) + b(2)*K(n+1:2*n) + b(3)*K(2*n+1:3*n)); 
end
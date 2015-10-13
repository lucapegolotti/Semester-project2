function z = RK4(A,x,stepsize,t0,t1)
%Fourth order non adaptive Runge Kutta method for the solution of y' = A*y
t = t0;
z = x;
while t<t1
    t = t + stepsize;
    k_1 = A*z;
    k_2 = A*(z + 0.5*stepsize*k_1);
    k_3 = A*(z+0.5*stepsize*k_2);
    k_4 = A*(z+k_3*stepsize);
    z = z + (1/6)*(k_1+2*k_2+2*k_3+k_4)*stepsize;  
end
function z = explicitEuler(A,x,stepsize,t0,t1)
t = t0;
z = x;
while t<t1
    t = t + stepsize;
    z = z + stepsize * A*z;
end
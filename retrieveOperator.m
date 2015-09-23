function Lc = retrieveOperator(A0,A1,c,tau,nsteps)
m = size(A0,1);
n = m^2;
Lc = zeros(n,n);
for i = 1:n
    ei = zeros(n,1);
    ei(i) = 1;
    for j = 1:n
        ej = zeros(n,1);
        ej(j) = 1;
        Lc(i,j) = ei'*vec(applyLc(A0,A1,c,reshape(ej,[m,m]),tau,nsteps));
    end
end

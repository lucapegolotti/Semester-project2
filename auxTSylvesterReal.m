function W = auxTSylvesterReal(R,S,E)
% Step 3 of algorithm presented in "Consistent and
% Efficient solution of the Sylvester equation for *-congruence" [de Teran,
% Dopico]. R,S and E are real
p = size(R,1)/2;
W = zeros(size(R));
perm = [1 0 0 0; 0 0 1 0; 0 1 0 0; 0 0 0 1]; % permutation matrix in R2 such that vec(x) = perm*vec(x')
I = eye(2);
for j=p:-1:1
    jj = [2*j-1 2*j];
    W(jj,jj) = reshape((kron(I,R(jj,jj)) + kron(S(jj,jj),I)*perm)\vec(E(jj,jj)),2,2);
    cont = 0;
    for i = j-1:-1:1
        cont = cont + 1;
        ii = [2*i-1 2*i];
        aux1 = zeros(2);
        aux2 = zeros(2);
            for k = i + 1:j
                kk = [2*k-1 2*k];
                aux1 = aux1 + S(ii,kk)*W(kk,jj);
                aux2 = aux2 + R(ii,kk)*W(kk,jj);
            end    
        rhs = [vec(E(jj,ii)' - aux1);vec(E(ii,jj) - aux2)];
        A = [kron(I,S(ii,ii)) kron(R(jj,jj),I)*perm;kron(I,R(ii,ii)) kron(S(jj,jj),I)*perm];
        x = A\rhs;
        W(ii,jj) = reshape(x(1:4),[2,2]);
        W(jj,ii) = reshape(x(5:end),[2,2]);
        
    end
    E(1:2*j-2,1:2*j-2) = E(1:2*j-2,1:2*j-2) - R(1:2*j-2,jj)*W(jj,1:2*j-2) - (S(1:2*j-2,jj)*W(jj,1:2*j-2))';
end
        
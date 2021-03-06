function W = auxTSylvesterImag(R,S,E)
% Step 3 of algorithm presented in "Consistent and
% Efficient solution of the Sylvester equation for *-congruence" [de Teran,
% Dopico]. R,S or E ar imaginary
p = size(R,1);
W = zeros(p,p);

for j=p:-1:1
    W(j,j) = E(j,j)/(R(j,j) + S(j,j));
    
    for i = j-1:-1:1
        rhs = [E(j,i) - S(i,i+1:j)*W(i+1:j,j);E(i,j) - R(i,i+1:j)*W(i+1:j,j)];
        A = [S(i,i) R(j,j);R(i,i) S(j,j)];
        x = A\rhs;
        W(i,j) = x(1);
        W(j,i) = x(2);
    end
    E(1:j-1,1:j-1) = E(1:j-1,1:j-1) - R(i:j-1,j)*W(j,1:j-1) - conj((S(1:j-1,j)*W(j,1:j-1))');
end
        
function W = auxTSylvesterReal(R,S,E)
% Step 3 of algorithm presented in "Consistent and
% Efficient solution of the Sylvester equation for *-congruence" [de Teran,
% Dopico]. R,S and E are real
blockDimension = returnDiagonalBlocksDimension(R);
p = length(blockDimension);
W = zeros(size(R));
perm = [1 0 0 0; 0 0 1 0; 0 1 0 0; 0 0 0 1]; % permutation matrix in R2 such that vec(x) = perm*vec(x')
I = eye(2);
Rblock = @(i,j) selectRightBlock(blockDimension,R,i,j);
Sblock = @(i,j) selectRightBlock(blockDimension,S,i,j);


for j=p:-1:1
    Eblock = @(i,j) selectRightBlock(blockDimension,E,i,j);
    if (blockDimension(j)==2);
        auxW = reshape((kron(I,Rblock(j,j)) + kron(Sblock(j,j),I)*perm)\vec(Eblock(j,j)),2,2);
    else
        auxW = Eblock(j,j)/(Rblock(j,j) + Sblock(j,j));
    end
    W = insertBlockInBlockMatrix(W,auxW,blockDimension,j,j);
    for i = j-1:-1:1
        aux1 = zeros(blockDimension(i),blockDimension(j));
        aux2 = aux1;
        for k = i + 1:j
            aux1 = aux1 + Sblock(i,k)*selectRightBlock(blockDimension,W,k,j);
            aux2 = aux2 + Rblock(i,k)*selectRightBlock(blockDimension,W,k,j);
        end    
        rhs = [vec(Eblock(j,i)' - aux1);vec(Eblock(i,j) - aux2)];
        if(blockDimension(i) == 2 && blockDimension(j) == 2)
            A = [kron(I,Sblock(i,i)) kron(Rblock(j,j),I);kron(I,Rblock(i,i)) kron(Sblock(j,j),I)];
        elseif (blockDimension(i) == 1 && blockDimension(j) == 2)
            A = [kron(I,Sblock(i,i)) Rblock(j,j);kron(I,Rblock(i,i)) Sblock(j,j)];
        elseif (blockDimension(i) == 2 && blockDimension(j) == 1)
            A = [Sblock(i,i) kron(Rblock(j,j),I);Rblock(i,i) kron(Sblock(j,j),I)];
        else
            A = [Sblock(i,i) Rblock(j,j);Rblock(i,i) Sblock(j,j)];
        end
        x = A\rhs;
        n = length(x);
        W = insertBlockInBlockMatrix(W,reshape(x(1:n/2),[blockDimension(i),blockDimension(j)]),blockDimension,i,j);
        W = insertBlockInBlockMatrix(W,reshape(x(n/2+1:end),[blockDimension(i),blockDimension(j)])',blockDimension,j,i);
    end
    if (j~=1)
        aux = Eblock(1:j-1,1:j-1) - Rblock(1:j-1,j)*selectRightBlock(blockDimension,W,j,1:j-1) - (Sblock(1:j-1,j)*selectRightBlock(blockDimension,W,j,1:j-1))';
        E = insertBlockInBlockMatrix(E,aux,blockDimension,1:j-1,1:j-1);
    end
end
        
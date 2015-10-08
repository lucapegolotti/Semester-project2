function [nk] = returnDiagonalBlocksDimension(R)
% Given a quasi upper triangular matrix, the function returns the dimension
% of each block forming the diagonal (supposing that the maximum dimension
% is 2)

n = size(R,1);
aux = true;
i = 1;
nk = zeros(n,1);
cur_block_number = 1;
while(aux)
    if (i == n)
        nk(cur_block_number) = 1;
        cur_block_number = cur_block_number + 1;
        aux = false;
    elseif (R(i+1,i)~=0)
        nk(cur_block_number) = 2;
        cur_block_number = cur_block_number + 1;
        if (i + 2<=n)
            i = i + 2;
        elseif (i+1==n)
            aux = false;
        end
            
    else
        nk(cur_block_number) = 1;
        cur_block_number = cur_block_number + 1;
        if (i+1<=n)
            i = i+1;
        end
    end
end
n = cur_block_number-1;
nx = nk(1:n);
nk = [];
i = 0;
while i<n
    i = i + 1;
    if (i == n)
        nk = [nk;nx(i)];
        i = i + 1;
    elseif (nx(i)==1 && nx(i+1)==1)
        nk = [nk;2];
        i = i + 1;
    elseif (nx(i)==2)
        nk = [nk;2];
    else
        nk = [nk;1];
    end
end
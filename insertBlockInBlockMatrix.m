function W = insertBlockInBlockMatrix(W,B,b_dimension,i,j)
% Given the vector of dimensions of diagonal blocks of R the function
% inserts B into the ith and jth block of W. If i or j are vectors the right
% submatrix is inserted
n = size(W,1);
p = length(b_dimension);
if (p<i(end) || p<j(end) || sum(b_dimension)~=size(W,1) || size(B,1)~=sum(b_dimension(i)) || size(B,2)~=sum(b_dimension(j)))
    error('Problem with dimensions');
end
if (length(i) == 1 && length(j)==1)
    dimension_of_input_block = size(B);
    aux1 = sum(b_dimension(1:i-1))+1;
    aux2 = sum(b_dimension(1:j-1))+1;

    if (dimension_of_input_block(1)==1 && dimension_of_input_block(2)==1)
        W(aux1,aux2) = B;
    elseif (dimension_of_input_block(1)==1 && dimension_of_input_block(2)==2)
        W(aux1,[aux2,aux2+1]) = B;
    elseif (dimension_of_input_block(1)==2 && dimension_of_input_block(2)==1)
        W([aux1,aux1+1],aux2) = B;
    elseif (dimension_of_input_block(1)==2 && dimension_of_input_block(2)==2)
        W([aux1,aux1+1],[aux2,aux2+1]) = B;
    end
else
    % This could probably be improven
    aux1 = 1;
    for ii = i
        aux2 = 1;
        cur_n_rows = b_dimension(ii);
        for jj = j
            if (cur_n_rows==1 && b_dimension(jj)==1)
                W = insertBlockInBlockMatrix(W,B(aux1,aux2),b_dimension,ii,jj);
                aux2 = aux2 + 1;
            elseif (cur_n_rows==2 && b_dimension(jj)==1)
                aux_block = B([aux1,aux1+1],aux2);
                W = insertBlockInBlockMatrix(W,aux_block,b_dimension,ii,jj);
                aux2 = aux2 + 1;
            elseif (cur_n_rows==1 && b_dimension(jj)==2)
                aux_block = B(aux1,[aux2,aux2+1]);
                W = insertBlockInBlockMatrix(W,aux_block,b_dimension,ii,jj);
                aux2 = aux2 + 2;
            else
                aux_block = B([aux1, aux1 + 1],[aux2,aux2+1]);
                W = insertBlockInBlockMatrix(W,aux_block,b_dimension,ii,jj);
                aux2 = aux2 + 2;
            end
        end
        if (cur_n_rows == 2)
            aux1 = aux1 + 2;
        else
            aux1 = aux1 + 1;
        end
    end
end

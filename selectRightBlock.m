function [B] = selectRightBlock(b_dimension,W,i,j)
% Given the vector of dimensions of diagonal blocks of R the function
% returns the ith and jth block of W. If i or j are vectors the right
% submatrix is returned
n = size(W,1);
p = length(b_dimension);
if (p<i(end) || p<j(end) || sum(b_dimension)~=size(W,1))
    error('Problem with dimensions');
end
if (length(i) == 1 && length(j)==1)
    dimension_of_output_block = [b_dimension(i) b_dimension(j)];
    B=zeros(dimension_of_output_block);
   
    aux1 = sum(b_dimension(1:i-1))+1;
    aux2 = sum(b_dimension(1:j-1))+1;

    if (dimension_of_output_block(1)==1 && dimension_of_output_block(2)==1);
        B(1,1) = W(aux1,aux2);
    elseif (dimension_of_output_block(1)==1 && dimension_of_output_block(2)==2);
        B(1,1) = W(aux1,aux2);
        B(1,2) = W(aux1,aux2+1);
    elseif (dimension_of_output_block(1)==2 && dimension_of_output_block(2)==1);
        B(1,1) = W(aux1,aux2);
        B(2,1) = W(aux1+1,aux2);
    elseif (dimension_of_output_block(1)==2 && dimension_of_output_block(2)==2);
        B(1,1) = W(aux1,aux2);
        B(1,2) = W(aux1,aux2+1);
        B(2,1) = W(aux1+1,aux2);
        B(2,2) = W(aux1+1,aux2+1);
    end
else
    % This could be probably be improven
    dimension_of_output_block = [sum(b_dimension(i)) sum(b_dimension(j))];
    B=zeros(dimension_of_output_block);
    aux1 = 1;
    for ii = i
        aux2 = 1;
        cur_n_rows = b_dimension(ii);
        for jj = j
            aux_block = selectRightBlock(b_dimension,W,ii,jj);
            if (cur_n_rows==1 && b_dimension(jj)==1)
                B(aux1,aux2)=aux_block;
                aux2 = aux2 + 1;
            elseif (cur_n_rows==2 && b_dimension(jj)==1)
                B([aux1,aux1+1],aux2)=aux_block;
                aux2 = aux2 + 1;
            elseif (cur_n_rows==1 && b_dimension(jj)==2)
                B(aux1,[aux2,aux2+1])=aux_block;
                aux2 = aux2 + 2;
            else
                B([aux1, aux1 + 1],[aux2,aux2+1])=aux_block;
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
           
    
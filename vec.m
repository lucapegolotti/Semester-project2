function a = vec(A)

% Computes the vectorization of A
n = size(A,1)*size(A,2);
a = reshape(A,[n,1]);

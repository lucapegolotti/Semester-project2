function A = assembleA(A0,A1,n)
I = eye(n);
A11 = kron(A0',I);
A12 = kron(A1',I);
A21 = kron(-I,A1');
A22 = kron(-I,A0');
A = [A11,A12;A21,A22];



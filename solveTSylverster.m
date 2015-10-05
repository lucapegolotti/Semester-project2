function X = solveTSylverster(A,B,C) 
% Algorithm for the solution of T-Sylvester equation of the form AX + X'B =
% C. For further information about the method, see "Consistent and
% Efficient solution of the Sylvester equation for *-congruence" [de Teran,
% Dopico]. The Algorithm assumes A,B,C real matrices.

[R,S,U,V] = qz(A,B');
U = U';
V = V';
E = U'*C*conj(U);
[W] = auxTSylvester(R,S,E);                          % step 3 of algorithm
X = V'*W*conj(U');
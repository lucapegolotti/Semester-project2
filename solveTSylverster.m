function X = solveTSylverster(A,B,C,varargin) 
% Algorithm for the solution of T-Sylvester equation of the form AX + X'B =
% C. For further information about the method, see "Consistent and
% Efficient solution of the Sylvester equation for *-congruence" [de Teran,
% Dopico]. The Algorithm assumes A,B,C real matrices.
if (nargin<4)
    [R,S,U,V] = qz(A,B');    % use 'real' 
    U = U';
    V = V';
    E = U'*C*conj(U);
    [W] = auxTSylvesterImag(R,S,E);     % step 3 of algorithm
    X = V'*W*conj(U');
    Xr = real(X);
    X = Xr; 
else
    if (strcmp(varargin{1},'REAL'))
        if (mod(size(A,1),2)~=0 || size(A,1)~=size(A,2))
            error('Matrices must be square and with even number of rows and col');
        end
        [R,S,U,V] = qz(A,B','real');    % use 'real' 
        returnDiagonalBlocksDimension(R)
        U = U';
        V = V';
        R
        E = U'*C*conj(U);
        [W] = auxTSylvesterReal(R,S,E);     % step 3 of algorithm
        X = V'*W*U';
    end
end   
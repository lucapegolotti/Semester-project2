clear all
clc

i = 10:10:100;
eImag = [];
eReal = [];
tImag = [];
tReal = [];
for n = i
    A = rand(n);
    B = rand(n);
    C = rand(n);
    tic
    X = solveTSylverster(A,B,C); 
    tImag = [tImag;toc];
    eImag = [eImag;norm(A*X + X'*B - C)/norm(X)];
    tic
    X = solveTSylverster(A,B,C,'REAL');
    tReal = [tReal;toc];
    eReal = [eReal;norm(A*X + X'*B - C)/norm(X)];
end
subplot(1,2,1)
semilogy(i,eImag,i,eReal,'-x')
legend('Error using imag Qz','Error using real Qz');

subplot(1,2,2)
plot(i,tImag,i,tReal,'-x')
legend('Time using imag Qz','Time using real Qz');
    
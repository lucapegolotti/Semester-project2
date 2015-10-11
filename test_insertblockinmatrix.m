clear all
clc

W = zeros(6);
p = [1;2;1;2];
c = [1,2;3,4];
c1 = [1;2];
insertBlockInBlockMatrix(W,c1,p,2,1)

%% test with multiple blocks
clear all
clc

W = zeros(6);
p = [1;2;1;2];
c = rand(3,1)

insertBlockInBlockMatrix(W,c,p,[1,2],1)


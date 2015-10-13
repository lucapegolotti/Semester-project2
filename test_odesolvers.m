clear all
clc

y = 1;
e = [];

for i = 3:10
    h = 2^(-i);
    e = [e;abs(exp(1)-RK4(1,y,h,0,1))];
    % e = [e;abs(exp(1)-explicitEuler(1,y,h,0,1))];
end
h = 2.^(-[3:10]');
semilogy(h,e)
log(e(2:end)./e(1:end-1))./log(h(2:end)./h(1:end-1))

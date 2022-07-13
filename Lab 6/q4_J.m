clear all;
close all;

format long;

a = 1; b = 2; c = 1; d = 2;

h = 0.1;
N = (b-a)/h;
M = N;

x = a:h:b;
y = c:h:d;

u1 = zeros(N+1,M+1);
u2 = zeros(N+1,M+1);
uex= zeros(N+1,M+1);

for i = 1:N+1
    for j = 1:M+1
    u2(i,1)  = x(i)*log(x(i));
    u2(1,j)  = y(j)*log(y(j));
    u2(i,M+1)= x(i)*log(4*(x(i))^2);
    u2(N+1,j)= 2*y(j)*log(2*y(j));
    end
end
tol = 1e-6;
h1  = h*h;
k   = 0;

while max(max(abs(u1-u2))) > tol
    
    k  = k + 1;
    u1 = u2;
    
    for j = 2:M
        for i = 2:N
            u2(i,j) = (u1(i-1,j) + u1(i+1,j) + u1(i,j-1) + u1(i,j+1) - h1*f4(x(i),y(j)))/4;
        end
    end
    
end

figure(1);
mesh(x,y,u2);
title('approximate solution')

for j = 1:M+1
    for i = 1:N+1
        uex(i,j) = x(i)*y(j)*log(x(i)*y(j));
    end
end

figure(2);
mesh(x,y,uex);
title('exact solution')

error = max(max(abs(u2 - uex)))
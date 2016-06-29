function [xa,ya,xb,yb] = gen_line(pt_num,theta,l)

% range
range = 0.5;
A = rand(pt_num,2);
xa = A(:,1);
ya = A(:,2);

a = -theta;
b = theta;
r = (b - a) .* rand(pt_num,1) + a;

% use l as mean value, the range is 0.8l~1.2l

L = l * (range * rand(pt_num,1) + (1-range/2));

xb = xa + L .* sin(r * pi / 180);
yb = ya + L .* cos(r * pi / 180);

% A = [5 0 1 10; 0 10 5 10; 4 10 20 0; 23 0 5 5;...
%     5 0 5 10; 3 0 15 5; 0 10 20 0];
% 
% xa = A(:,1);
% ya = A(:,2);
% xb = A(:,3);
% yb = A(:,4);

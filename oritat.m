function x = oritat(x1,y1,x2,y2,x3,y3)
% this funciton jundge the orientatino of three
% points 1, 2, 3. the return number is defined by
% 0 --> collinear
% 1 --> clockwise
% 2 --> counter clockwise
% reference: http://www.geeksforgeeks.org/check-if-two-given-line-segments-intersect/

a = (y2 - y1)*(x3 - x2) - (y3 - y2)*(x2 - x1);
if a < 0
  x = 2;
elseif a > 0
  x = 1;
else
  x = 0;
end

% 
% slope12 = (y2 - y1) / (x2 - x1);
% slope23 = (y2 - y3) / (x2 - x3);
% 
% if slope12 < slope23
%   x = 2;
% elseif slope12 > slope23
%   x = 1;
% else
%   x = 0;
% end

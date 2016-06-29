function x = judgeintsec(x1,y1,x2,y2,x3,y3,x4,y4)
% this judge whether two segment intersect with each other
% x = 1 intersect
% x = 0 no intersect

o1 = oritat(x1,y1,x2,y2,x3,y3);   % line1 to other 2 pts
o2 = oritat(x1,y1,x2,y2,x4,y4);

o3 = oritat(x3,y3,x4,y4,x1,y1);   % line2 to other 2 pts
o4 = oritat(x3,y3,x4,y4,x2,y2);

if o1 ~= o2 & o3 ~= o4
    x = 1;
elseif o1==0 & o2==0 & o3==0 & o4==0
    x = 1;
else
    x = 0;
end

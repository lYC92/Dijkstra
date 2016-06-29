function [px,py] = intsec(x1,y1,x2,y2,x3,y3,x4,y4)
% This function calculate the intersection of two line, which
% first line given by (x1,y1), (x2,y2) and 
% second line given by (x3,y3),(x4,y4)

px = det([det([x1 y1; x2 y2]) det([x1 1; x2 1]); ...
    det([x3 y3; x4 y4]) det([x3 1; x4 1])]) / ...
  det([det([x1 1; x2 1]) det([y1 1; y2 1]); ...
    det([x3 1; x4 1]) det([y3 1; y4 1])]);
py = det([det([x1 y1; x2 y2]) det([y1 1; y2 1]); ...
    det([x3 y3; x4 y4]) det([y3 1; y4 1])]) / ...
  det([det([x1 1; x2 1]) det([y1 1; y2 1]); ...
    det([x3 1; x4 1]) det([y3 1; y4 1])]);

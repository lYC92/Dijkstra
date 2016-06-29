function [num,index] = nextPoint(A,passed)

% A = [ 0 0 2 3 4 3 0];
% now_indx = 3;
% don't go to the point that passed before

[m,ind] = sort(A);
for i = 1: length(m)
    if m(i) ~= 0 & ~ismember(ind(i),passed)
        index = ind(i);
        break;
    end
end
       
num = A(index);
    

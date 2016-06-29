clf
clear

%% generate a bunch of line segment
% 1st arg: number of points
% 2nd arg: angle between y axis (random value between 0-theta)
% 3rd arg: stick length (random value around l)

cnt_num = 50;
theta = 180; % angle to y is +-theta (degree)
l = 0.3;
[xa,ya,xb,yb] = gen_line(cnt_num, theta, l);

hold on
title('2D percolation model for CNT network')
set(gca,'YTick',[])
set(gca,'XTick',[])
axis([0 1 0 1])

for i = 1:cnt_num
    plot([xa(i) xb(i)],[ya(i),yb(i)])
end

%% Judge the intersection of each lines
% intersect_table(i,j) = 1 means the line i and line j have intersect.
% intersect_table is asymmetry lower trangular matrix
% intcoord(i,j,1) save the x coordinate of intersect of linei & linej
% intcoord(i,j,2) save the y coordinate of intersect of linei & linej
% intcoord is symmetric

intersect_table = zeros(cnt_num);
intcoord = zeros(cnt_num,cnt_num,2);
for i  = 1:cnt_num
    for j = i+1:cnt_num
        intersect_table(j,i) = ...
            judgeintsec(xa(i),ya(i),xb(i),yb(i),xa(j),ya(j),xb(j),yb(j));
%         intersect_table(i,j) = intersect_table(j,i);
        if intersect_table(j,i) == 1
            [intcoord(j,i,1),intcoord(j,i,2)] = ...
                intsec(xa(i),ya(i),xb(i),yb(i),xa(j),ya(j),xb(j),yb(j));
            intcoord(i,j,1) = intcoord(j,i,1);
            intcoord(i,j,2) = intcoord(j,i,2);
%             scatter(intcoord(j,i,1),intcoord(j,i,2))
        end
    end
end

%% find the which two line intersect
[line_x, line_y] = find(intersect_table);
int_num = length(line_x); % the number of intersect

% the list of intersect (point matrix)
% pt_mat(i,j) means the intersect of line i and line j
pt_mat = [line_x, line_y];

% for i = 1:int_num
%     text(intcoord(pt_mat(i,1),pt_mat(i,2),1),...
%         intcoord(pt_mat(i,1),pt_mat(i,2),2),...
%         num2str(i))
% end


%% get transport path & cost from one side to another
% Use Dijkstra's Algorithm to find the possible minimum path

% start point & final point
sr_pt_indx = 1;
fn_pt_indx = 8;

sr_pt = pt_mat(sr_pt_indx,:);
fn_pt = pt_mat(fn_pt_indx,:);
scatter(intcoord(pt_mat(sr_pt_indx,1),pt_mat(sr_pt_indx,2),1),...
        intcoord(pt_mat(sr_pt_indx,1),pt_mat(sr_pt_indx,2),2),'filled')
scatter(intcoord(pt_mat(fn_pt_indx,1),pt_mat(fn_pt_indx,2),1),...
        intcoord(pt_mat(fn_pt_indx,1),pt_mat(fn_pt_indx,2),2),'filled')

row = 1;  % fill the first row
label = inf(row,int_num); % label is the distance from starting point
path = ones(row,int_num) * sr_pt_indx;    % assign beginning point
label(sr_pt_indx) = 0;

now_indx = sr_pt_indx;   % now_indx is where you are
pass(1) = now_indx;     % record the points ha
loop_t = int_num;

while loop_t ~= 1
    for i = 1:int_num
        % whether two points has connection
        if intersect(pt_mat(now_indx,:), pt_mat(i,:))
            % calculate distance
            x1 = intcoord(pt_mat(now_indx,1),pt_mat(now_indx,2),1);
            y1 = intcoord(pt_mat(now_indx,1),pt_mat(now_indx,2),2);
            x2 = intcoord(pt_mat(i,1),pt_mat(i,2),1);
            y2 = intcoord(pt_mat(i,1),pt_mat(i,2),2);
            dis_now_i = distance(x1,y1,x2,y2);
            if dis_now_i + label(row,now_indx) < label(row,i)
                label(row,i) = dis_now_i + label(row,now_indx);
                path(i) = now_indx;     % update where it came from
            end
        end
    end
    [min_num, now_indx] = nextPoint(label(row,:),pass);

    row = row + 1;
    label(row,:) = label(row - 1,:);    % copy the last record
%     path(row,:) = path(row - 1,:);
    pass(row) = now_indx;               % record the passed point
    loop_t = loop_t -1;
%     text(intcoord(pt_mat(now_indx,1),pt_mat(now_indx,2),1),...
%         intcoord(pt_mat(now_indx,1),pt_mat(now_indx,2),2),...
%         num2str(label(row,now_indx)))
    scatter(intcoord(pt_mat(now_indx,1),pt_mat(now_indx,2),1),...
        intcoord(pt_mat(now_indx,1),pt_mat(now_indx,2),2))
end

cost = label(row,fn_pt_indx)
min_path(1) = fn_pt_indx;
min_path_x(1) = intcoord(pt_mat(min_path(1),1),pt_mat(min_path(1),2),1);
min_path_y(1) = intcoord(pt_mat(min_path(1),1),pt_mat(min_path(1),2),2);

for i = 2:int_num
    if cost == inf
        break
    end
    min_path(i) = path(min_path(i-1));
    min_path_x(i) = intcoord(pt_mat(min_path(i),1),pt_mat(min_path(i),2),1);
    min_path_y(i) = intcoord(pt_mat(min_path(i),1),pt_mat(min_path(i),2),2);
    if min_path(i) == sr_pt_indx
        break
    end
end

plot(min_path_x,min_path_y,'LineWidth',6)


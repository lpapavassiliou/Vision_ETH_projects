load data\K.txt K
load data\poses.txt poses

%% DRAW GRID ON IMAGE

Im = imread("data\images_undistorted\img_0001.jpg");
grayIm = rgb2gray(Im);
imshow(grayIm)
hold on

grid_edge = 0.04;
Pw = gridPoints(6);
Pw = grid_edge*Pw;

% Homog. Transf. from World to Camera
T_CW = poseToT(1);
p = projectPoints(Pw, T_CW);
for i=1:size(Pw,1)
    scatter(p(i,1), p(i,2))
    hold on
end

%% DRAW CUBE ON IMAGE

side = 2;        % choose side in grid units

Im = imread("data\images_undistorted\img_0001.jpg");
grayIm = rgb2gray(Im);
imshow(grayIm)
hold on

base = gridPoints(1);
base = base*side*grid_edge;
base3 = base(3,1:2);   % swap line 3 and 4 of base
base(3,1:2) = base(4,1:2);
base(4,1:2) = base3;
top = base;
for i = 1:size(top,1)
    top(i,3) = top(i,3)-side*grid_edge;
end

base_uv = projectPoints(base, T_CW);
top_uv = projectPoints(top, T_CW);

line_base = line(base_uv(1:4,1),base_uv(1:4,2));
line_base.Color =  'green';
line_top = line(top_uv(1:4,1),top_uv(1:4,2));
line_top.Color =  'green';

x = [];
y = [];
for i=1:4
    x = [base_uv(i,1) top_uv(i,1)];
    y = [base_uv(i,2) top_uv(i,2)];
    line_top = line(x,y);
line_top.Color =  'green';

end


%% UNDISTORT IMAGE

Im_dist = imread("data\images\img_0001.jpg");
grayIm_dist = rgb2gray(Im_dist);
undistIm = undistort(grayIm_dist);
imshow(undistIm)
hold on

grid_edge = 0.04;
Pw = gridPoints(6);
Pw = grid_edge*Pw;

% Homog. Transf. from World to Camera
T_CW = poseToT(1);
p = projectPoints(Pw, T_CW);
for i=1:size(Pw,1)
    scatter(p(i,1), p(i,2))
    hold on
end

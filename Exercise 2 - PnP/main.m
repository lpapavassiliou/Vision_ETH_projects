load data\K.txt
load data\p_W_corners.txt
load data\detected_corners.txt

%% IMAGE 1 READ
Im1 = imread("data\images_undistorted\img_0001.jpg");
imshow(Im1)
hold on

n = size(p_W_corners,1);
numIm = 1;
cornersOfIm = reshape(detected_corners(numIm,:),[2,n])';

%% POSE ESTIMATION
M = estimatePoseDLT(cornersOfIm,p_W_corners,K);

%% REPROJECTION
reprojected_points = reprojectPoints(p_W_corners, M, K);
for i=1:n
    scatter(reprojected_points(:,1),reprojected_points(:,2));
    %scatter(cornersOfIm(:,1),cornersOfIm(:,2));
    hold on
end

%% POSE ESTIMATION
n_images = size(detected_corners,1);
n = size(p_W_corners,1);

quat_list = [];
t_list = [];

for numIm = 1:n_images

    cornersOfIm = reshape(detected_corners(numIm,:),[2,n])';
    M_CW = estimatePoseDLT(cornersOfIm, p_W_corners, K);
    R_CW = M_CW(1:3,1:3);
    t_CW = M_CW(1:3,4);

    M_WC = [R_CW' -R_CW'*t_CW];
    R_WC = M_WC(1:3,1:3);
    t_WC = M_WC(1:3,4);

    quat = rotMatrix2Quat(R_WC);
    quat_list = [quat_list quat];
    t_list = [t_list t_WC];

end

plotTrajectory3D(30, t_list/100, quat_list, p_W_corners'/100)

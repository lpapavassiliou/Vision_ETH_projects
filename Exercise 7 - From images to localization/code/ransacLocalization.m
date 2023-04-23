function [R_C_W, t_C_W, best_inliers, max_num_inliers_history, num_iteration_history] ...
    = ransacLocalization(matched_query_keypoints, corresponding_landmarks, K)
% matched_query_keypoints should be 2x1000
% corrisponding_landmarks should be 3x1000 and correspond to the output from the
%   matchDescriptors() function from exercise 3.
% best_inlier_mask should be 1xnum_matched (!!!) and contain, only for the
%   matched keypoints (!!!), 0 if the match is an outlier, 1 otherwise.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FINDING BEST INLAIERS

% initialization
indeces = 1:size(matched_query_keypoints,2);
max_num_inliers_history = [];
max_num_inliers = 0;
best_M = zeros(3,4);
best_inliers = [];

for iter = 1:2000

    % pick 8 random corrispondences and use DLT to find an M
    random8  = datasample(indeces, 8, 2, 'Replace', false);
    currM = estimatePoseDLT(matched_query_keypoints(:,random8)', corresponding_landmarks(:,random8)', K);

    % see how many inlayers
    rep_points = reprojectPoints(corresponding_landmarks', currM, K)';
    for j = 1:size(delta,2)
        norm_vec = norm(rep_points(:,j)-matched_query_keypoints(:,j));
    end
    inliers = norm_vec>10;
    curr_num_inliers = sum(inliers,'all');

    % update best if max number of inlaiers is improved
    if  max_num_inliers < curr_num_inliers
        max_num_inliers = curr_num_inliers;
        best_inliers = inliers;
    end

    % keep track of results
    max_num_inliers_history = [max_num_inliers_history max_num_inliers];

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% calculating M using best inliers

filtered_p = matched_query_keypoints(:, best_inliers);
filtered_P = corresponding_landmarks(:, best_inliers);
last_M = estimatePoseDLT(filtered_p', filtered_P', K);
max_num_inliers_history = [max_num_inliers_history  max_num_inliers];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% recovering R and t

R_C_W = last_M(1:3,1:3);
t_C_W = last_M(1:3,4);

num_iteration_history = 0;

end
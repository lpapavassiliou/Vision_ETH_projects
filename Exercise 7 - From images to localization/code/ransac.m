function [best_guess_history, max_num_inliers_history] = ...
    ransac(data, max_noise)
% data is 2xN with the data points given column-wise, 
% best_guess_history is 3xnum_iterations with the polynome coefficients 
%   from polyfit of the BEST GUESS SO FAR at each iteration columnwise and
% max_num_inliers_history is 1xnum_iterations, with the inlier count of the
%   BEST GUESS SO FAR at each iteration.

N = 100;
s = 3;

best_guess_history = [];
max_num_inliers_history = [];
max_num_inliers = 0;
best_p = [0 0 0];
best_inliers = [];

for iter = 1:N
    
    % choose 3 random points and fit parabola
    temp_data = datasample(data, s, 2, 'Replace', false);
    curr_p = polyfit(temp_data(1,:), temp_data(2,:), 2);

    % calculate norm-1 error vector between model prediction and data labels
    y = polyval(curr_p, data(1,:), 2);
    inliers = abs(y - data(2,:)) <= max_noise;
    curr_num_layers = sum(inliers);

    % see how many points are inliers. update best if improved
    if  curr_num_layers > max_num_inliers
        max_num_inliers = curr_num_layers;
        best_p = curr_p;
        best_inliers = inliers;
    end

    % keep track of results
    max_num_inliers_history = [max_num_inliers_history max_num_inliers];
    best_guess_history = [best_guess_history best_p'];
end

filtered_data = data(:, best_inliers);
last_p = polyfit(filtered_data(1,:), filtered_data(2,:), 2);
max_num_inliers_history = [max_num_inliers_history  max_num_inliers];
best_guess_history = [best_guess_history last_p'];

end
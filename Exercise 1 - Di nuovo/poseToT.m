function T = poseToT(n_pose)
    % given the number of pose it returns corrisponding T = R|t (3x4)
    load data\poses.txt poses
    raw = poses(n_pose, 1:6);
    R = rodriguezToRotMat(raw(1:3));
    T = [R, raw(4:6)'];
end
function p_reprojected = reprojectPoints(P, M, K)

% supposes P is nx3
% return nx2

p_reprojected = [];
[raws, columns] = size(P);
for i in raws
    add_p = K*M*P[raws];
    p_reprojected = [p reprojected;
                     add_p]
end

end
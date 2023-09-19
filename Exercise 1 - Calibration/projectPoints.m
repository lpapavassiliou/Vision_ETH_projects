function p = projectPoints(Pw, T)
    
    % Input: vector of points Pw (nx3) and a tranformation matrix T from World to Camera
    % Output: vector of projections (nx2) on the image

    load data\K.txt K
    p = [];
    n = size(Pw, 1);

    for i = 1:n
        add_p = K * T * [Pw(i, 1:3) 1]';
        add_p = add_p/add_p(3);
        add_p = add_p(1:2);
        p = [    p ; 
             add_p'];
    end


end
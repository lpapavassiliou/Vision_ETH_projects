function Im = undistort(Im_dist)

    Im = Im_dist;
    V = size(Im, 1);
    U = size(Im, 2);

    for u = 1:U
        for v = 1:V
            p_dist = distort([u,v]);
            p_dist(1) = round(p_dist(1));
            p_dist(2) = round(p_dist(2));
            Im(v,u) = Im_dist( p_dist(2) , p_dist(1) );
        end
    end
end
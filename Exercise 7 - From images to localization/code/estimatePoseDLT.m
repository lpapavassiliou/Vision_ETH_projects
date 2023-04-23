function M_tilde = estimatePoseDLT(p, P, K)

    % P nx3
    % p nx2
    
    n = size(P,1);
    Q = [];
    for i = 1:n
        Pi = P(i,1:3);
        pi = p(i,1:2);
        pi_norm = inv(K)*[pi 1]';
        x = pi_norm(1);
        y = pi_norm(2);
        L = [Pi 1  0  0  0  0];
        R = [0   0  0  0 Pi 1];
        Q = [      Q        ;
               L   -x*[Pi 1] ;
               R   -y*[Pi 1] ];
    end
    
    [U, S, V] = svd(Q);
    m = V(:,12);
    M = reshape(m, [4,3])';
    if M(3,4)<0
        M = -M;
    end

    R = M(1:3,1:3);
    t = M(1:3,4);
    [u s v] = svd(R);
    R_tilde  = u*v';

    alpha = norm(R_tilde)/norm(R);
    t_tilde = alpha*t;
    M_tilde = [R_tilde t_tilde];
end
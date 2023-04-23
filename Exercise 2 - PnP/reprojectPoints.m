function p = reprojectPoints(P, M, K)
    % P nx3
    % p nx2

    n = size(P,1);
    p = [];
    for i=1:n
        Pi = P(i, :);
        pi = K*M*[Pi 1]' ;
        pi = pi/pi(3);
        pi = pi(1:2);

        p = [p;
             pi'];
    end
end
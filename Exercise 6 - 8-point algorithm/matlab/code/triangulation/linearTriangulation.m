function P = linearTriangulation(p1,p2,M1,M2)
% LINEARTRIANGULATION  Linear Triangulation
%
% Input:
%  - p1(3,N): homogeneous coordinates of points in image 1
%  - p2(3,N): homogeneous coordinates of points in image 2
%  - M1(3,4): projection matrix corresponding to first image
%  - M2(3,4): projection matrix corresponding to second image
%
% Output:
%  - P(4,N): homogeneous coordinates of 3-D points


N = size(p1, 2);
P = [];
for i = 1:N
    P1X_i = cross2Matrix(p1(:, i));
    P2X_i = cross2Matrix(p2(:, i));
    A_i = [P1X_i*M1;
           P2X_i*M2];
    [~, ~, V_i] = svd(A_i);
    X = V_i(:, end);   % last column corrisponds to min sigma
    X = X/X(4);        % 4th element must be 1 for homogeneus coordinate
    P =  [P X];
end

end
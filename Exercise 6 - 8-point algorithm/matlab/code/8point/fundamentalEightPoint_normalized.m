function F = fundamentalEightPoint_normalized(p1, p2)
% estimateEssentialMatrix_normalized: estimates the essential matrix
% given matching point coordinates, and the camera calibration K
%
% Input: point correspondences
%  - p1(3,N): homogeneous coordinates of 2-D points in image 1
%  - p2(3,N): homogeneous coordinates of 2-D points in image 2
%
% Output:
%  - F(3,3) : fundamental matrix
%

N = size(p1, 2);

mu_1 = 1/N*sum(p1, 2);
mu_1_mat = repmat(mu_1,1,N);
delta_1 = p1 - mu_1_mat;
sigma2_1 = 1/N*sum(delta_1.^2, 'all');
s_1 = sqrt(2)/sigma2_1;

mu_2 = 1/N *sum(p2, 2);
mu_2_mat = repmat(mu_2,1,N);
delta_2 = p2 - mu_2_mat;
sigma2_2 = 1/N*sum(delta_2.^2, 'all');
s_2 = sqrt(2)/sigma2_2;

T1 =       [s_1    0     -s_1*mu_1(1);
            0      s_1   -s_1*mu_2(2);
            0      0            1    ];
T2 =       [s_2    0     -s_2*mu_1(1);
            0      s_2   -s_2*mu_2(2);
            0      0            1    ];

p1_tilde = T1*p1;
p2_tilde = T2*p2;

F_tilde = fundamentalEightPoint(p1_tilde, p2_tilde);
F = T2'*F_tilde*T1;

end

function R = rodriguezToRotMat(phi)
    theta = norm(phi);
    k = 1/theta *phi;
    R = eye(3) + sin(theta)*crossMat(k) + (1-cos(theta)) * (crossMat(k))^2;
end
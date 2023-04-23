function dist_p = distort(r)

    load data\D.txt D
    load data\K.txt K
   
    k1 = D(1);
    k2 = D(2);
    u0 = K(1,3);
    v0 = K(2,3);
    u = r(1);
    v = r(2);

    r2 = (u-u0)^2 + (v-v0)^2;
    dist_p = (1 + k1*r2 + k2*(r2^2))* ([u-u0 v-v0]') + [u0 v0]';

end
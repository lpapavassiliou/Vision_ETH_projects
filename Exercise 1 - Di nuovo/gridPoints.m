function P = gridPoints(grid_size)

    % returns grid_size x 3 vector with z = 0
    
    P = [];
    for i= 0:grid_size
        for j = 0:grid_size
            P = [   P;
                  [i,j,0] ];
            end
    end
    
    
end
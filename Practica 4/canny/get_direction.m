function res=get_direction(img)
    gradient_x = gradient_matrix_x(img);
    gradient_y = gradient_matrix_y(img);
    gradient_y(gradient_y == 0) = realmin;
    
    direction = atan(gradient_x./gradient_y).*(180/pi);
    res = best_approximation_matrix(direction);
end


function res=best_approximation_matrix(dir_img)
    [X,Y] = size(dir_img);
    res = zeros(X,Y);
    for i=1:X
        for j=1:Y
            res(i,j) = best_approximation(dir_img(i,j));
        end
    end
end


function res=best_approximation(radian)
    posible_dirs = [0, 45, 90, 135];
    dir = min(abs(posible_dirs-radian));
    if ismember(radian+dir, posible_dirs)
        res = dir+radian;
    else
        res = radian-dir;
    end
end
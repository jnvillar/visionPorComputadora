function res=get_direction(img, kernel_gradient_x, kernel_gradient_y)
    gradient_x = double(image_convolution(img, kernel_gradient_x));
    gradient_y = double(image_convolution(img, kernel_gradient_y));
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
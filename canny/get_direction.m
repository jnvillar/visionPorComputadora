function res=get_direction(img)
    gradient_x = gradient_matrix_x(img);
    gradient_y =gradient_matrix_y(img);
    gradient_y(gradient_y == 0) = realmin;
    
    direction = atan(gradient_x./gradient_y);
    res = direction.*200;
end
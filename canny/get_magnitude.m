function res=get_magnitude(img)
    gradient_x = gradient_matrix_x(img);
    gradient_y =gradient_matrix_y(img);
    res = sqrt(imadd(gradient_x.^2, gradient_y.^2));
end
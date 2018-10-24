function res=get_magnitude(img, kernel_gradient_x, kernel_gradient_y)
    gradient_x = double(image_convolution(img, kernel_gradient_x));
    gradient_y = double(image_convolution(img, kernel_gradient_y));
    res = sqrt(imadd(gradient_x.^2, gradient_y.^2));
end
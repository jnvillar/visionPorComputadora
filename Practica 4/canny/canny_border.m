function res=canny_border(img, kernel_gradient_x, kernel_gradient_y, apply_hysteresis)
    
    [X,Y,Z] = size(img);
    if Z == 3
        img = rgb2gray(img);
    end
    
    smooth_img = image_convolution(img, gaussian_mask(5, 1.050));
    smooth_img = double(smooth_img);
    magnitude = get_magnitude(smooth_img, kernel_gradient_x, kernel_gradient_y);
    direction = get_direction(smooth_img, kernel_gradient_x, kernel_gradient_y);
    no_max_supr_img = no_max_supressor(magnitude, direction);
    res = no_max_supr_img;
    
    gradient_x = double(image_convolution(img, kernel_gradient_x));
    gradient_y = double(image_convolution(img, kernel_gradient_y));
    
    if (apply_hysteresis)
        greater_than_0 = no_max_supr_img(no_max_supr_img > 0);
        s = size(greater_than_0);
        avg = sum(greater_than_0)/s(1);
        lower_threshold_hysteresis = avg;
        upper_threshold_hysteresis = 2*avg;
        
        disp(strcat('lower_threshold = ', num2str(lower_threshold_hysteresis)));
        disp(strcat('upper_threshold = ', num2str(upper_threshold_hysteresis)));
        res = hysteresis_threshold(no_max_supr_img, direction, lower_threshold_hysteresis, upper_threshold_hysteresis);
    end
    
%     figure('name', 'Original');imshow(img);
%     figure('name', 'After Gaussian mask');imshow([uint8(smooth_img)]);
%     figure('name', 'Gradients');imshow([gradient_x, gradient_y]);
%     figure('name', 'Direction');imshow(uint8(direction));
%     
%     figure('name', 'Magnitude');imshow(magnitude);
%     figure('name', 'No max supress');imshow(no_max_supr_img);
%     figure('name', 'Hysteresis filter');imshow(hysteresis_img);
    
end
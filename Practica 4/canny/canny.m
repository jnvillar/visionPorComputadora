filepath = fileparts(mfilename('fullpath'));
addpath(strcat(filepath, '/../../imgs'));
addpath(strcat(filepath, '/../../Practica 3'));
lena_img = imread('imgs/lena.png');
img = lena_img;

[X,Y,Z] = size(img);
if Z == 3
    img = rgb2gray(img);
end
canny_border(img);

function res=canny_border(img)
    smooth_img = image_convolution(img, gaussian_mask(5, 1.050));
    smooth_img = double(smooth_img);
    magnitude = get_magnitude(smooth_img);
    direction = get_direction(smooth_img);
    no_max_supr_img = no_max_supressor(magnitude, direction);
      
    gradient_x = gradient_matrix_x(img);
    gradient_y = gradient_matrix_y(img);
    
    hysteresis_img = hysteresis_threshold(magnitude, direction, 10, 12);
    
    figure('name', 'Original');imshow([uint8(smooth_img)]);
    figure('name', 'Gradients');imshow([gradient_x, gradient_y]);
    figure('name', 'Direction');imshow(uint8(direction));
    
    figure('name', 'Magnitude');imshow(magnitude);
    figure('name', 'No max supress');imshow(no_max_supr_img);
    figure('name', 'Hysteresis filter');imshow(hysteresis_img);
    %figure;imshow([magnitude, no_max_supr_img, hysteresis_img])
    
    res=magnitude;
end




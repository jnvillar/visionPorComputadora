addpath('./Practica 2/functions');
img1 = imread('imgs/river1.jpg');
img2 = imread('imgs/fruit.png');
img3 = imread('imgs/colors.jpg');


show = 1;


% Ejercicio 1
% a
reduce_saturation = map_saturation(img1,multiply_constant_function(0.5));
increase_saturation = map_saturation(img1, multiply_constant_function(2));
if(show), figure('Name','Reduce and Increase saturation'), imshow([img1, reduce_saturation, increase_saturation]), end

% b
apply_cuadratic_function_to_saturation = map_saturation(img1, exponencial_function(2));
apply_exponencial_function_to_saturation = map_saturation(img1, exponencial_function(5));
apply_log_function_to_saturation = map_saturation(img1, log_function());
apply_square_root_to_saturation = map_saturation(img1, exponencial_function(0.5));
apply_sin_to_saturation = map_saturation(img1, sin_function());
apply_cos_to_saturation = map_saturation(img1, cos_function());
apply_tan_to_saturation = map_saturation(img1, tan_function());
if(show), figure('Name','Reduce and Increase saturation by ^2'), imshow([img1, apply_tan_to_saturation,apply_cos_to_saturation,apply_sin_to_saturation,apply_cuadratic_function_to_saturation,apply_exponencial_function_to_saturation,apply_log_function_to_saturation,apply_square_root_to_saturation]), end

% Ejercicio 2
% a
increase_hue_by_small_constant = map_hue(img1, add_constant_function(0.08));
increase_hue_by_big_constant = map_hue(img1, add_constant_function(5));
if(show), figure('Name','Reduce and Increase hue'), imshow([img1, increase_hue_by_small_constant, increase_hue_by_big_constant]), end



% Ejercicio 3
if(show), figure('Name','Show hsi planes'), imshow(separate_planes(img1)), end
if(show), figure('Name','Show hsi planes'), imshow(separate_planes(img2)), end
if(show), figure('Name','Show hsi planes'), imshow(separate_planes(img3)), end

function res=imgChangeSaturation(img, f)
    hsvImg = rgb2hsv(img);
    hsvImg(:,:,2) = f(hsvImg(:,:,2));
    hsvImg(hsvImg > 1) = 1;
    res = uint8(hsv2rgb(hsvImg)*256);
end



function f=cuadratic_function()
    f = @(vec) vec.^2;
end





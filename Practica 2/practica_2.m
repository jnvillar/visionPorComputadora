img1 = imread('imgs/fruit.png');
show = 1;

% Ejercicio 1
% a
reduce_saturation = map_saturation(img1,multiply_constant_function(0.5));
increase_saturation = map_saturation(img1, multiply_constant_function(2));
if(show), figure('Name','Reduce and Increase saturation'), imshow([img1, reduce_saturation, increase_saturation]), end

% Ejercicio 2
% a
increase_hue_by_small_constant = map_hue(img1, add_constant_function(0.08));
increase_hue_by_big_constant = map_hue(img1, add_constant_function(5));
if(show), figure('Name','Reduce and Increase hue'), imshow([img1, increase_hue_by_small_constant, increase_hue_by_big_constant]), end


function res=imgChangeSaturation(img, f)
    hsvImg = rgb2hsv(img);
    hsvImg(:,:,2) = f(hsvImg(:,:,2));
    hsvImg(hsvImg > 1) = 1;
    res = uint8(hsv2rgb(hsvImg)*256);
end



function f=cuadratic_function()
    f = @(vec) vec.^2;
end




filepath = fileparts(mfilename('fullpath'));
addpath(strcat(filepath, '/../imgs'));
test_img = imread('imgs/test.png');
lena_img = imread('imgs/lena.png');
show = 1;

% Ejercicio 1

% a
box_blur_mask = ones(1,9).*(1/9);
gaussian_blur_mask = [1,2,1,2,4,2,1,2,1].*(1/16);
border_mask = [-1,-1,-1,-1,8,-1,-1,-1,-1];

res=image_convolution(lena_img, box_blur_mask);
res2=image_convolution(lena_img, gaussian_blur_mask);
res3=image_convolution(lena_img, border_mask);

figure;
imshow([lena_img, res]);

figure;
imshow([lena_img, res2]);

figure;
imshow([lena_img, res3]);

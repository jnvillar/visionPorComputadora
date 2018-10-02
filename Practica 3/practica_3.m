filepath = fileparts(mfilename('fullpath'));
addpath(strcat(filepath, '/../imgs'));
img1 = imread('imgs/river1.jpg');
img2 = imread('imgs/fruit.png');
img3 = imread('imgs/big.jpg');
imgBW = imread('imgs/b&w.png');
dif = imread('imgs/difuminada.png');
show = 1;

% Ejercicio 1

% a
box_blur_mask = ones(1,9).*(1/9);
gaussian_blur_mask = [1,2,1; 2,4,2; 1,2,1].*(1/16);
border_mask = [-1,-1,-1;-1,8,-1;-1,-1,-1];

res=image_convolution(img3, box_blur_mask);
res2=image_convolution(img3, gaussian_blur_mask);
res3=image_convolution(img3, border_mask);

figure;
imshow([img3, res]);

figure;
imshow([img3, res2]);

figure;
imshow([img3, res3]);

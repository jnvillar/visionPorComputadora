filepath = fileparts(mfilename('fullpath'));
addpath(strcat(filepath, '/../imgs'));
test_img = imread('imgs/test.png');
lena_img = imread('imgs/lena.png');
show = 0;

% Ejercicio 1

% a
% box_blur_mask = ones(1,9).*(1/9);
% gaussian_blur_mask = [1,2,1,2,4,2,1,2,1].*(1/16);
% border_mask = [-1,-1,-1,-1,8,-1,-1,-1,-1];
% 
% res=image_convolution(lena_img, box_blur_mask);
% res2=image_convolution(lena_img, gaussian_blur_mask);
% res3=image_convolution(lena_img, border_mask);
% 
% figure;
% imshow([lena_img, res]);
% 
% figure;
% imshow([lena_img, res2]);
% 
% figure;
% imshow([lena_img, res3]);






% Ejercicio 3
%a

img = lena_img;
params = containers.Map({'sigma', 'size'}, {5, 30});
res_smoothing = smoothing(img, params);
if(show), figure('Name', 'Image smoothing'), imshow([img, res_smoothing]), end


%b
img = lena_img;
params = containers.Map({'sigma', 'size'}, {5, 30});
res_unsharp = unsharp_masking(img, params);
if(show), figure('Name', 'Image unsharp masking'), imshow([img, res_unsharp]), end




% Ejercicio 5
img = lena_img;
res_median_fitler = median_filter(img, 3);
if(1), figure('Name', 'Image median filter'), imshow([img, res_median_fitler]), end
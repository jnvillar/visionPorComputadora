filepath = fileparts(mfilename('fullpath'));
addpath(strcat(filepath, '/../imgs'));
test_img = imread('imgs/test.png');
lena_img = imread('imgs/lena.png');
show = 1;

% Ejercicio 1

% a
low_pass_filter_3x3 = (1/9).*ones(3);
low_pass_filter_5x5 = (1/25).*ones(5);

low_pass_filter_3x3_img = image_convolution(lena_img, low_pass_filter_3x3);
low_pass_filter_5x5_img = image_convolution(lena_img, low_pass_filter_5x5);
if(show), figure('Name','Low pass filter (3x3 and 5x5)'), imshow([lena_img, low_pass_filter_3x3_img, low_pass_filter_5x5_img]), end

%b
duplicate_filter_3x3 = zeros(3);
duplicate_filter_3x3(2,2) = 2;
high_pass_filter_3x3 = duplicate_filter_3x3 - low_pass_filter_3x3;

duplicate_filter_5x5 = zeros(5);
duplicate_filter_5x5(3,3) = 2;
high_pass_filter_5x5 = duplicate_filter_5x5 - low_pass_filter_5x5;

high_pass_filter_3x3_img = image_convolution(lena_img, high_pass_filter_3x3);
high_pass_filter_5x5_img = image_convolution(lena_img, high_pass_filter_5x5);
if(show), figure('Name','High pass filter (3x3 and 5x5)'), imshow([lena_img, high_pass_filter_3x3_img, high_pass_filter_5x5_img]), end

% Ejercicio 2
% Lo implementamos en el ejercicio anterior para poder aplicar los filtros
% pasa bajos y pasa altos (image_convolution)

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
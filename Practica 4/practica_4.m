filepath = fileparts(mfilename('fullpath'));
addpath(strcat(filepath, '/../imgs'));
addpath(strcat(filepath, '/../Practica 3'));
test = imread('imgs/test.png');
lena = imread('imgs/lena.png');

show_1 = 1;

% 1

if show_1 
mu = 0;

lena_noise_1 = gauss_noise(lena,0, 1);
lena_noise_2 = gauss_noise(lena,0, 2);
lena_noise_3 = gauss_noise(lena,0, 3);

test_noise_1 = rayleigh_noise(lena,0, 1);
test_noise_2 = rayleigh_noise(lena,0, 2);
test_noise_3 = rayleigh_noise(lena,0, 3);

imshow([lena_noise_1,lena_noise_2,lena_noise_3,test_noise_1,test_noise_2,test_noise_3])
end


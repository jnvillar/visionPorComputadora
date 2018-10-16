filepath = fileparts(mfilename('fullpath'));
addpath(strcat(filepath, '/../imgs'));
addpath(strcat(filepath, '/../Practica 3'));
test = imread('imgs/test.png');
lena = imread('imgs/lena.png');

show_2 = 0;

% Ejercicio 1


lena_g_noise_1 = gauss_noise(lena,0, 0.1);
lena_g_noise_2 = gauss_noise(lena,0, 0.5);
lena_g_noise_3 = gauss_noise(lena,0, 0.9);

lena_r_noise_1 = rayleigh_noise(lena,0, 1);
lena_r_noise_2 = rayleigh_noise(lena,0, 2);
lena_r_noise_3 = rayleigh_noise(lena,0, 3);

test_g_noise_1 = gauss_noise(test,0, 0.1);
test_g_noise_2 = gauss_noise(test,0, 0.5);
test_g_noise_3 = gauss_noise(test,0, 0.9);

test_r_noise_1 = rayleigh_noise(test,0, 1);
test_r_noise_2 = rayleigh_noise(test,0, 2);
test_r_noise_3 = rayleigh_noise(test,0, 3);


% Ejercicio 2

if show_2
m = 2; % m must be close to 2 

%-----------lena image-----------%

lena_g_noise_1_borders = lapplacian_borders(lena_g_noise_1,2000,m);
figure('Name','Gauss noise 0.1'); imshow([lena_g_noise_1, lena_g_noise_1_borders])

lena_g_noise_2_borders = lapplacian_borders(lena_g_noise_2,9000,m);
figure('Name','Gauss noise 0.5'); imshow([lena_g_noise_2, lena_g_noise_2_borders])

lena_g_noise_3_borders = lapplacian_borders(lena_g_noise_3,11000,m);
figure('Name','Gauss noise 0.9'); imshow([lena_g_noise_3, lena_g_noise_3_borders])

lena_r_noise_1_borders = lapplacian_borders(lena_r_noise_1,5000,m);
figure('Name','rayleigh noise 1'); imshow([lena_r_noise_1, lena_r_noise_1_borders])

lena_r_noise_2_borders = lapplacian_borders(lena_r_noise_2,6000,m);
figure('Name','rayleigh noise 2'); imshow([lena_r_noise_2, lena_r_noise_2_borders])

lena_r_noise_3_borders = lapplacian_borders(lena_r_noise_3,6000,m);
figure('Name','rayleigh noise 3'); imshow([lena_r_noise_3, lena_r_noise_3_borders])

%-----------test image-----------%

test_g_noise_1_borders = lapplacian_borders(test_g_noise_1,2000,m);
figure('Name','Gauss noise 0.1'); imshow([test_g_noise_1, test_g_noise_1_borders])

test_g_noise_2_borders = lapplacian_borders(test_g_noise_2,9000,m);
figure('Name','Gauss noise 0.5'); imshow([test_g_noise_2, test_g_noise_2_borders])

test_g_noise_3_borders = lapplacian_borders(test_g_noise_3,11000,m);
figure('Name','Gauss noise 0.9'); imshow([test_g_noise_3, test_g_noise_3_borders])

test_r_noise_1_borders = lapplacian_borders(test_r_noise_1,5000,m);
figure('Name','rayleigh noise 1'); imshow([test_r_noise_1, test_r_noise_1_borders])

test_r_noise_2_borders = lapplacian_borders(test_r_noise_2,6000,m);
figure('Name','rayleigh noise 2'); imshow([test_r_noise_2, test_r_noise_2_borders])

test_r_noise_3_borders = lapplacian_borders(test_r_noise_3,6000,m);
figure('Name','rayleigh noise 3'); imshow([test_r_noise_3, test_r_noise_3_borders])
end





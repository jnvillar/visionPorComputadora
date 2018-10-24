filepath = fileparts(mfilename('fullpath'));
addpath(strcat(filepath, '/../imgs'));
addpath(strcat(filepath, '/../Practica 3'));
addpath(strcat(filepath, '/canny'));
addpath(strcat(filepath, '/corner_detection'));
test = imread('imgs/test.png');
lena = imread('imgs/lena.png');

show_2_a = 0;
show_2_c = 0;
show_3_a = 0;
show_3_b = 0;
show_4_a = 0;
show_4_b = 0;
show_4_c = 0;
show_4_d = 0;

% Ejercicio 1

lena_g_noise_1 = gauss_noise(lena,0, 0.1);
lena_g_noise_2 = gauss_noise(lena,0, 0.5);
lena_g_noise_3 = gauss_noise(lena,0, 0.9);
lena_g_noise_4 = gauss_noise(lena,0, 0.3);

lena_r_noise_1 = rayleigh_noise(lena,0, 1);
lena_r_noise_2 = rayleigh_noise(lena,0, 2);
lena_r_noise_3 = rayleigh_noise(lena,0, 3);

test_g_noise_1 = gauss_noise(test,0, 0.1);
test_g_noise_2 = gauss_noise(test,0, 0.5);
test_g_noise_3 = gauss_noise(test,0, 0.9);
test_g_noise_4 = gauss_noise(test,0, 0.3);

test_r_noise_1 = rayleigh_noise(test,0, 1);
test_r_noise_2 = rayleigh_noise(test,0, 2);
test_r_noise_3 = rayleigh_noise(test,0, 3);


% Ejercicio 2

if show_2_a
m = 2; % m must be close to 2 

%-----------lena image-----------%

lena_g_noise_1_borders = laplacian_borders(lena_g_noise_1,2000,m);
figure('Name','Laplacian - Lena with Gauss noise (0.1)'); imshow([lena_g_noise_1, lena_g_noise_1_borders])

lena_g_noise_2_borders = laplacian_borders(lena_g_noise_2,9000,m);
figure('Name','Laplacian - Lena with Gauss noise (0.5)'); imshow([lena_g_noise_2, lena_g_noise_2_borders])

lena_g_noise_3_borders = laplacian_borders(lena_g_noise_3,11000,m);
figure('Name','Laplacian - Lena with Gauss noise (0.9)'); imshow([lena_g_noise_3, lena_g_noise_3_borders])

lena_r_noise_1_borders = laplacian_borders(lena_r_noise_1,5000,m);
figure('Name','Laplacian - Lena with Rayleigh noise (1)'); imshow([lena_r_noise_1, lena_r_noise_1_borders])

lena_r_noise_2_borders = laplacian_borders(lena_r_noise_2,6000,m);
figure('Name','Laplacian - Lena with Rayleigh noise (2)'); imshow([lena_r_noise_2, lena_r_noise_2_borders])

lena_r_noise_3_borders = laplacian_borders(lena_r_noise_3,6000,m);
figure('Name','Laplacian - Lena with Rayleigh noise (3)'); imshow([lena_r_noise_3, lena_r_noise_3_borders])

%-----------test image-----------%

test_g_noise_1_borders = laplacian_borders(test_g_noise_1,2000,m);
figure('Name','Laplacian - Test with Gauss noise (0.1)'); imshow([test_g_noise_1, test_g_noise_1_borders])

test_g_noise_2_borders = laplacian_borders(test_g_noise_2,9000,m);
figure('Name','Laplacian - Test with Gauss noise (0.5)'); imshow([test_g_noise_2, test_g_noise_2_borders])

test_g_noise_3_borders = laplacian_borders(test_g_noise_3,11000,m);
figure('Name','Laplacian - Test with Gauss noise (0.9)'); imshow([test_g_noise_3, test_g_noise_3_borders])

test_r_noise_1_borders = laplacian_borders(test_r_noise_1,5000,m);
figure('Name','Laplacian - Test with Rayleigh noise (1)'); imshow([test_r_noise_1, test_r_noise_1_borders])

test_r_noise_2_borders = laplacian_borders(test_r_noise_2,6000,m);
figure('Name','Laplacian - Test with Rayleigh noise (2)'); imshow([test_r_noise_2, test_r_noise_2_borders])

test_r_noise_3_borders = laplacian_borders(test_r_noise_3,6000,m);
figure('Name','Laplacian - Test with Rayleigh noise (3)'); imshow([test_r_noise_3, test_r_noise_3_borders])
end

if show_2_c
m = 2; % m must be close to 2 

%-----------lena image-----------%

lena_g_noise_1 = smoothing(lena_g_noise_1);
lena_g_noise_2 = smoothing(lena_g_noise_2);
lena_g_noise_3 = smoothing(lena_g_noise_3);
lena_r_noise_1 = smoothing(lena_r_noise_1);
lena_r_noise_2 = smoothing(lena_r_noise_2);
lena_r_noise_3 = smoothing(lena_r_noise_3);

lena_g_noise_1_borders = laplacian_borders(lena_g_noise_1,500,m);
figure('Name','Laplacian of Gaussian - Lena with Gauss noise (0.1)'); imshow([lena_g_noise_1, lena_g_noise_1_borders])

lena_g_noise_2_borders = laplacian_borders(lena_g_noise_2,600,m);
figure('Name','Laplacian of Gaussian - Lena with Gauss noise (0.5)'); imshow([lena_g_noise_2, lena_g_noise_2_borders])

lena_g_noise_3_borders = laplacian_borders(lena_g_noise_3,650,m);
figure('Name','Laplacian of Gaussian - Lena with Gauss noise (0.9)'); imshow([lena_g_noise_3, lena_g_noise_3_borders])

lena_r_noise_1_borders = laplacian_borders(lena_r_noise_1,500,m);
figure('Name','Laplacian of Gaussian - Lena with Rayleigh noise (1)'); imshow([lena_r_noise_1, lena_r_noise_1_borders])

lena_r_noise_2_borders = laplacian_borders(lena_r_noise_2,500,m);
figure('Name','Laplacian of Gaussian - Lena with Rayleigh noise (2)'); imshow([lena_r_noise_2, lena_r_noise_2_borders])

lena_r_noise_3_borders = laplacian_borders(lena_r_noise_3,500,m);
figure('Name','Laplacian of Gaussian - Lena with Rayleigh noise (3)'); imshow([lena_r_noise_3, lena_r_noise_3_borders])

%-----------test image-----------%

test_g_noise_1 = smoothing(test_g_noise_1);
test_g_noise_2 = smoothing(test_g_noise_2);
test_g_noise_3 = smoothing(test_g_noise_3);
test_r_noise_1 = smoothing(test_r_noise_1);
test_r_noise_2 = smoothing(test_r_noise_2);
test_r_noise_3 = smoothing(test_r_noise_3);

test_g_noise_1_borders = laplacian_borders(test_g_noise_1,500,m);
figure('Name','Laplacian of Gaussian - Test with Gauss noise (0.1)'); imshow([test_g_noise_1, test_g_noise_1_borders])

test_g_noise_2_borders = laplacian_borders(test_g_noise_2,600,m);
figure('Name','Laplacian of Gaussian - Test with Gauss noise (0.5)'); imshow([test_g_noise_2, test_g_noise_2_borders])

test_g_noise_3_borders = laplacian_borders(test_g_noise_3,700,m);
figure('Name','Laplacian of Gaussian - Test with Gauss noise (0.9)'); imshow([test_g_noise_3, test_g_noise_3_borders])

test_r_noise_1_borders = laplacian_borders(test_r_noise_1,500,m);
figure('Name','Laplacian of Gaussian - Test with Rayleigh noise (1)'); imshow([test_r_noise_1, test_r_noise_1_borders])

test_r_noise_2_borders = laplacian_borders(test_r_noise_2,500,m);
figure('Name','Laplacian of Gaussian - Test with Rayleigh noise (2)'); imshow([test_r_noise_2, test_r_noise_2_borders])

test_r_noise_3_borders = laplacian_borders(test_r_noise_3,500,m);
figure('Name','Laplacian of Gaussian - Test with Rayleigh noise (3)'); imshow([test_r_noise_3, test_r_noise_3_borders])
end

% Ejercicio 3

roberts_gradient_x = [1 0; 0 -1];
roberts_gradient_y = [0 1; -1 0];

prewitt_gradient_x = [-1 0 1; -1 0 1; -1 0 1];
prewitt_gradient_y = [-1 -1 -1; 0 0 0; 1 1 1];

sobel_gradient_x = [-1 0 1; -2 0 2; -1 0 1];
sobel_gradient_y = [1 2 1; 0 0 0; -1 -2 -1];

% a
if show_3_a

apply_hysteresis = false;

%-----------lena image-----------%

canny_roberts = canny_border(lena, roberts_gradient_x, roberts_gradient_y, apply_hysteresis);
canny_prewitt = canny_border(lena, prewitt_gradient_x, prewitt_gradient_y, apply_hysteresis);
canny_sobel = canny_border(lena, sobel_gradient_x, sobel_gradient_y, apply_hysteresis);
figure('name', 'Canny (Roberts - Prewitt - Sobel) - Lena - No max supression');imshow([lena, canny_roberts, canny_prewitt, canny_sobel]);

canny_roberts = canny_border(lena_g_noise_1, roberts_gradient_x, roberts_gradient_y, apply_hysteresis);
canny_prewitt = canny_border(lena_g_noise_1, prewitt_gradient_x, prewitt_gradient_y, apply_hysteresis);
canny_sobel = canny_border(lena_g_noise_1, sobel_gradient_x, sobel_gradient_y, apply_hysteresis);
figure('name', 'Canny (Roberts - Prewitt - Sobel) - Lena - No max supression - Gauss noise (0.1)');imshow([lena_g_noise_1, canny_roberts, canny_prewitt, canny_sobel]);

canny_roberts = canny_border(lena_g_noise_4, roberts_gradient_x, roberts_gradient_y, apply_hysteresis);
canny_prewitt = canny_border(lena_g_noise_4, prewitt_gradient_x, prewitt_gradient_y, apply_hysteresis);
canny_sobel = canny_border(lena_g_noise_4, sobel_gradient_x, sobel_gradient_y, apply_hysteresis);
figure('name', 'Canny (Roberts - Prewitt - Sobel) - Lena - No max supression - Gauss noise (0.3)');imshow([lena_g_noise_4, canny_roberts, canny_prewitt, canny_sobel]);

canny_roberts = canny_border(lena_g_noise_3, roberts_gradient_x, roberts_gradient_y, apply_hysteresis);
canny_prewitt = canny_border(lena_g_noise_3, prewitt_gradient_x, prewitt_gradient_y, apply_hysteresis);
canny_sobel = canny_border(lena_g_noise_3, sobel_gradient_x, sobel_gradient_y, apply_hysteresis);
figure('name', 'Canny (Roberts - Prewitt - Sobel) - Lena - No max supression - Gauss noise (0.5)');imshow([lena_g_noise_3, canny_roberts, canny_prewitt, canny_sobel]);

canny_roberts = canny_border(lena_r_noise_1, roberts_gradient_x, roberts_gradient_y, apply_hysteresis);
canny_prewitt = canny_border(lena_r_noise_1, prewitt_gradient_x, prewitt_gradient_y, apply_hysteresis);
canny_sobel = canny_border(lena_r_noise_1, sobel_gradient_x, sobel_gradient_y, apply_hysteresis);
figure('name', 'Canny (Roberts - Prewitt - Sobel) - Lena - No max supression - Rayleigh noise (1)');imshow([lena_r_noise_1, canny_roberts, canny_prewitt, canny_sobel]);

canny_roberts = canny_border(lena_r_noise_2, roberts_gradient_x, roberts_gradient_y, apply_hysteresis);
canny_prewitt = canny_border(lena_r_noise_2, prewitt_gradient_x, prewitt_gradient_y, apply_hysteresis);
canny_sobel = canny_border(lena_r_noise_2, sobel_gradient_x, sobel_gradient_y, apply_hysteresis);
figure('name', 'Canny (Roberts - Prewitt - Sobel) - Lena - No max supression - Rayleigh noise (2)');imshow([lena_r_noise_2, canny_roberts, canny_prewitt, canny_sobel]);

canny_roberts = canny_border(lena_r_noise_3, roberts_gradient_x, roberts_gradient_y, apply_hysteresis);
canny_prewitt = canny_border(lena_r_noise_3, prewitt_gradient_x, prewitt_gradient_y, apply_hysteresis);
canny_sobel = canny_border(lena_r_noise_3, sobel_gradient_x, sobel_gradient_y, apply_hysteresis);
figure('name', 'Canny (Roberts - Prewitt - Sobel) - Lena - No max supression - Rayleigh noise (3)');imshow([lena_r_noise_3, canny_roberts, canny_prewitt, canny_sobel]);

%-----------test image-----------%

canny_roberts = canny_border(test, roberts_gradient_x, roberts_gradient_y, apply_hysteresis);
canny_prewitt = canny_border(test, prewitt_gradient_x, prewitt_gradient_y, apply_hysteresis);
canny_sobel = canny_border(test, sobel_gradient_x, sobel_gradient_y, apply_hysteresis);
figure('name', 'Canny (Roberts - Prewitt - Sobel) - Test - No max supression');imshow([test, canny_roberts, canny_prewitt, canny_sobel]);

canny_roberts = canny_border(test_g_noise_1, roberts_gradient_x, roberts_gradient_y, apply_hysteresis);
canny_prewitt = canny_border(test_g_noise_1, prewitt_gradient_x, prewitt_gradient_y, apply_hysteresis);
canny_sobel = canny_border(test_g_noise_1, sobel_gradient_x, sobel_gradient_y, apply_hysteresis);
figure('name', 'Canny (Roberts - Prewitt - Sobel) - Test - No max supression - Gauss noise (0.1)');imshow([test_g_noise_1, canny_roberts, canny_prewitt, canny_sobel]);

canny_roberts = canny_border(test_g_noise_2, roberts_gradient_x, roberts_gradient_y, apply_hysteresis);
canny_prewitt = canny_border(test_g_noise_2, prewitt_gradient_x, prewitt_gradient_y, apply_hysteresis);
canny_sobel = canny_border(test_g_noise_2, sobel_gradient_x, sobel_gradient_y, apply_hysteresis);
figure('name', 'Canny (Roberts - Prewitt - Sobel) - Test - No max supression - Gauss noise (0.3)');imshow([test_g_noise_2, canny_roberts, canny_prewitt, canny_sobel]);

canny_roberts = canny_border(test_g_noise_3, roberts_gradient_x, roberts_gradient_y, apply_hysteresis);
canny_prewitt = canny_border(test_g_noise_3, prewitt_gradient_x, prewitt_gradient_y, apply_hysteresis);
canny_sobel = canny_border(test_g_noise_3, sobel_gradient_x, sobel_gradient_y, apply_hysteresis);
figure('name', 'Canny (Roberts - Prewitt - Sobel) - Test - No max supression - Gauss noise (0.5)');imshow([test_g_noise_3, canny_roberts, canny_prewitt, canny_sobel]);

canny_roberts = canny_border(test_r_noise_1, roberts_gradient_x, roberts_gradient_y, apply_hysteresis);
canny_prewitt = canny_border(test_r_noise_1, prewitt_gradient_x, prewitt_gradient_y, apply_hysteresis);
canny_sobel = canny_border(test_r_noise_1, sobel_gradient_x, sobel_gradient_y, apply_hysteresis);
figure('name', 'Canny (Roberts - Prewitt - Sobel) - Test - No max supression - Rayleigh noise (1)');imshow([test_r_noise_1, canny_roberts, canny_prewitt, canny_sobel]);

canny_roberts = canny_border(test_r_noise_2, roberts_gradient_x, roberts_gradient_y, apply_hysteresis);
canny_prewitt = canny_border(test_r_noise_2, prewitt_gradient_x, prewitt_gradient_y, apply_hysteresis);
canny_sobel = canny_border(test_r_noise_2, sobel_gradient_x, sobel_gradient_y, apply_hysteresis);
figure('name', 'Canny (Roberts - Prewitt - Sobel) - Test - No max supression - Rayleigh noise (2)');imshow([test_r_noise_2, canny_roberts, canny_prewitt, canny_sobel]);

canny_roberts = canny_border(test_r_noise_3, roberts_gradient_x, roberts_gradient_y, apply_hysteresis);
canny_prewitt = canny_border(test_r_noise_3, prewitt_gradient_x, prewitt_gradient_y, apply_hysteresis);
canny_sobel = canny_border(test_r_noise_3, sobel_gradient_x, sobel_gradient_y, apply_hysteresis);
figure('name', 'Canny (Roberts - Prewitt - Sobel) - Test - No max supression - Rayleigh noise (3)');imshow([test_r_noise_3, canny_roberts, canny_prewitt, canny_sobel]);

end

% b
if show_3_b

apply_hysteresis = true;

%-----------lena image-----------%

canny_roberts = canny_border(lena, roberts_gradient_x, roberts_gradient_y, apply_hysteresis);
canny_prewitt = canny_border(lena, prewitt_gradient_x, prewitt_gradient_y, apply_hysteresis);
canny_sobel = canny_border(lena, sobel_gradient_x, sobel_gradient_y, apply_hysteresis);
figure('name', 'Canny (Roberts - Prewitt - Sobel) - Lena - Hysteresis');imshow([lena, canny_roberts, canny_prewitt, canny_sobel]);

canny_roberts = canny_border(lena_g_noise_1, roberts_gradient_x, roberts_gradient_y, apply_hysteresis);
canny_prewitt = canny_border(lena_g_noise_1, prewitt_gradient_x, prewitt_gradient_y, apply_hysteresis);
canny_sobel = canny_border(lena_g_noise_1, sobel_gradient_x, sobel_gradient_y, apply_hysteresis);
figure('name', 'Canny (Roberts - Prewitt - Sobel) - Lena - Hysteresis - Gauss noise (0.1)');imshow([lena_g_noise_1, canny_roberts, canny_prewitt, canny_sobel]);

canny_roberts = canny_border(lena_g_noise_4, roberts_gradient_x, roberts_gradient_y, apply_hysteresis);
canny_prewitt = canny_border(lena_g_noise_4, prewitt_gradient_x, prewitt_gradient_y, apply_hysteresis);
canny_sobel = canny_border(lena_g_noise_4, sobel_gradient_x, sobel_gradient_y, apply_hysteresis);
figure('name', 'Canny (Roberts - Prewitt - Sobel) - Lena - Hysteresis - Gauss noise (0.3)');imshow([lena_g_noise_4, canny_roberts, canny_prewitt, canny_sobel]);

canny_roberts = canny_border(lena_g_noise_3, roberts_gradient_x, roberts_gradient_y, apply_hysteresis);
canny_prewitt = canny_border(lena_g_noise_3, prewitt_gradient_x, prewitt_gradient_y, apply_hysteresis);
canny_sobel = canny_border(lena_g_noise_3, sobel_gradient_x, sobel_gradient_y, apply_hysteresis);
figure('name', 'Canny (Roberts - Prewitt - Sobel) - Lena - Hysteresis - Gauss noise (0.5)');imshow([lena_g_noise_3, canny_roberts, canny_prewitt, canny_sobel]);

canny_roberts = canny_border(lena_r_noise_1, roberts_gradient_x, roberts_gradient_y, apply_hysteresis);
canny_prewitt = canny_border(lena_r_noise_1, prewitt_gradient_x, prewitt_gradient_y, apply_hysteresis);
canny_sobel = canny_border(lena_r_noise_1, sobel_gradient_x, sobel_gradient_y, apply_hysteresis);
figure('name', 'Canny (Roberts - Prewitt - Sobel) - Lena - Hysteresis - Rayleigh noise (1)');imshow([lena_r_noise_1, canny_roberts, canny_prewitt, canny_sobel]);

canny_roberts = canny_border(lena_r_noise_2, roberts_gradient_x, roberts_gradient_y, apply_hysteresis);
canny_prewitt = canny_border(lena_r_noise_2, prewitt_gradient_x, prewitt_gradient_y, apply_hysteresis);
canny_sobel = canny_border(lena_r_noise_2, sobel_gradient_x, sobel_gradient_y, apply_hysteresis);
figure('name', 'Canny (Roberts - Prewitt - Sobel) - Lena - Hysteresis - Rayleigh noise (2)');imshow([lena_r_noise_2, canny_roberts, canny_prewitt, canny_sobel]);

canny_roberts = canny_border(lena_r_noise_3, roberts_gradient_x, roberts_gradient_y, apply_hysteresis);
canny_prewitt = canny_border(lena_r_noise_3, prewitt_gradient_x, prewitt_gradient_y, apply_hysteresis);
canny_sobel = canny_border(lena_r_noise_3, sobel_gradient_x, sobel_gradient_y, apply_hysteresis);
figure('name', 'Canny (Roberts - Prewitt - Sobel) - Lena - Hysteresis - Rayleigh noise (3)');imshow([lena_r_noise_3, canny_roberts, canny_prewitt, canny_sobel]);

%-----------test image-----------%

canny_roberts = canny_border(test, roberts_gradient_x, roberts_gradient_y, apply_hysteresis);
canny_prewitt = canny_border(test, prewitt_gradient_x, prewitt_gradient_y, apply_hysteresis);
canny_sobel = canny_border(test, sobel_gradient_x, sobel_gradient_y, apply_hysteresis);
figure('name', 'Canny (Roberts - Prewitt - Sobel) - Test - Hysteresis');imshow([test, canny_roberts, canny_prewitt, canny_sobel]);

canny_roberts = canny_border(test_g_noise_1, roberts_gradient_x, roberts_gradient_y, apply_hysteresis);
canny_prewitt = canny_border(test_g_noise_1, prewitt_gradient_x, prewitt_gradient_y, apply_hysteresis);
canny_sobel = canny_border(test_g_noise_1, sobel_gradient_x, sobel_gradient_y, apply_hysteresis);
figure('name', 'Canny (Roberts - Prewitt - Sobel) - Test - Hysteresis - Gauss noise (0.1)');imshow([test_g_noise_1, canny_roberts, canny_prewitt, canny_sobel]);

canny_roberts = canny_border(test_g_noise_2, roberts_gradient_x, roberts_gradient_y, apply_hysteresis);
canny_prewitt = canny_border(test_g_noise_2, prewitt_gradient_x, prewitt_gradient_y, apply_hysteresis);
canny_sobel = canny_border(test_g_noise_2, sobel_gradient_x, sobel_gradient_y, apply_hysteresis);
figure('name', 'Canny (Roberts - Prewitt - Sobel) - Test - Hysteresis - Gauss noise (0.3)');imshow([test_g_noise_2, canny_roberts, canny_prewitt, canny_sobel]);

canny_roberts = canny_border(test_g_noise_3, roberts_gradient_x, roberts_gradient_y, apply_hysteresis);
canny_prewitt = canny_border(test_g_noise_3, prewitt_gradient_x, prewitt_gradient_y, apply_hysteresis);
canny_sobel = canny_border(test_g_noise_3, sobel_gradient_x, sobel_gradient_y, apply_hysteresis);
figure('name', 'Canny (Roberts - Prewitt - Sobel) - Test - Hysteresis - Gauss noise (0.5)');imshow([test_g_noise_3, canny_roberts, canny_prewitt, canny_sobel]);

canny_roberts = canny_border(test_r_noise_1, roberts_gradient_x, roberts_gradient_y, apply_hysteresis);
canny_prewitt = canny_border(test_r_noise_1, prewitt_gradient_x, prewitt_gradient_y, apply_hysteresis);
canny_sobel = canny_border(test_r_noise_1, sobel_gradient_x, sobel_gradient_y, apply_hysteresis);
figure('name', 'Canny (Roberts - Prewitt - Sobel) - Test - Hysteresis - Rayleigh noise (1)');imshow([test_r_noise_1, canny_roberts, canny_prewitt, canny_sobel]);

canny_roberts = canny_border(test_r_noise_2, roberts_gradient_x, roberts_gradient_y, apply_hysteresis);
canny_prewitt = canny_border(test_r_noise_2, prewitt_gradient_x, prewitt_gradient_y, apply_hysteresis);
canny_sobel = canny_border(test_r_noise_2, sobel_gradient_x, sobel_gradient_y, apply_hysteresis);
figure('name', 'Canny (Roberts - Prewitt - Sobel) - Test - Hysteresis - Rayleigh noise (2)');imshow([test_r_noise_2, canny_roberts, canny_prewitt, canny_sobel]);

canny_roberts = canny_border(test_r_noise_3, roberts_gradient_x, roberts_gradient_y, apply_hysteresis);
canny_prewitt = canny_border(test_r_noise_3, prewitt_gradient_x, prewitt_gradient_y, apply_hysteresis);
canny_sobel = canny_border(test_r_noise_3, sobel_gradient_x, sobel_gradient_y, apply_hysteresis);
figure('name', 'Canny (Roberts - Prewitt - Sobel) - Test - Hysteresis - Rayleigh noise (3)');imshow([test_r_noise_3, canny_roberts, canny_prewitt, canny_sobel]);

end

% Ejercicio 4

% a
if show_4_a

harris_test = apply_corner_detection(test, @harris_r, 2);
figure('name', 'Harris corners detection - Test');imshow(harris_test);

end

% b
if show_4_b
    
szeliski_test = apply_corner_detection(test, @szeliski_r, 2);
figure('name', 'Szeliski corners detection - Test');imshow(szeliski_test);

end

% c
if show_4_c
    
shi_tomasi_test = apply_corner_detection(test, @shi_tomasi_r, 0.5);
figure('name', 'Shi-Tomasi corners detection - Test');imshow(shi_tomasi_test);

end

% d
if show_4_d
    
triggs_test = apply_corner_detection(test, @triggs_r, 2);
figure('name', 'Triggs corners detection - Test');imshow(triggs_test);

end

function res=harris_r(eigs)
    k = 0.04;
    res = eigs(1)*eigs(2) - k * (eigs(1)+eigs(2)).^2;
end

function res=triggs_r(eigs)
    alpha = 0.05;
    res = eigs(1)-alpha*eigs(2);
end

function res=szeliski_r(eigs)
    res = eigs(1)*eigs(2)/(eigs(1)+eigs(2));
end

function res=shi_tomasi_r(eigs)
    res = eigs(1);
end

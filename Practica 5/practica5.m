filepath = fileparts(mfilename('fullpath'));
addpath(strcat(filepath, '/../imgs'));

img_a = rgb2gray(imread('imgs/damero1.jpg'));
img_b = rgb2gray(imread('imgs/damero2.jpg'));

% Ejercicio 1


% a) 4 pares de correspondencias

scale = 0.100;
img_a = imresize(img_a,scale);
img_b = imresize(img_b,scale);

% edges_img_a = scale*[ 870 780; 1167 792; 869 1085; 1162 1090; 1451 1391];
% edges_img_b = scale*[ 285 1832 ; 409 1617; 482 1960; 612 1739; 949 1641];

edges_img_a = scale*[870 780 ; 1167 792 ; 869 1085 ; 1451 1391];
edges_img_b = scale*[285 1832 ; 409 1617 ; 482 1960 ; 949 1641];

h_a = dlt(edges_img_a, edges_img_b);
img_dlt_a = apply_transformation(img_a, h_a);

figure('Name','DLT - 4 correspondencias (original - original rotada - rotada por DLT)');
montage({img_a, img_b, img_dlt_a}, 'Size', [1 NaN])


% b) Muchos pares de correspondencias (obtenemos las correspondencias
% usando SURF)

h_b = calculate_homography_dlt(img_a, img_b, 'Surf');
img_dlt_b = apply_transformation(img_a, h_b);

figure('Name','DLT - Muchas correspondencias (original - original rotada - rotada por DLT)');
montage({img_a, img_b, img_dlt_b}, 'Size', [1 NaN])


% Ejercicio 2


% a) Ransac sobre Damero

h_ransac_damero = calculate_homography_ransac(img_a, img_b, 50, 5, 'Surf');
img_ransac_damero = apply_transformation(img_a, h_ransac_damero);

figure('Name','Ransac sobre Damero - Muchas correspondencias (original - original rotada - rotada por DLT refinada con Ransac)');
montage({img_a, img_b, img_ransac_damero}, 'Size', [1 NaN]);


% b) Ransac sobre otras imagenes

img_a = imread('imgs/lena.png');
img_b = imrotate(img_a,-30);

h_ransac_lena = calculate_homography_ransac(img_a, img_b, 50, 5, 'Surf');
img_ransac_lena = apply_transformation(img_a, h_ransac_lena);

figure('Name','Ransac sobre Lena - Muchas correspondencias (original - original rotada - rotada por DLT refinada con Ransac)');
montage({img_a, img_b, img_ransac_lena}, 'Size', [1 NaN]);

img_a = imread('imgs/test.png');
img_b = imrotate(img_a,80);

h_ransac_test = calculate_homography_ransac(img_a, img_b, 50, 5, 'Surf');
img_ransac_test = apply_transformation(img_a, h_ransac_test);

figure('Name','Ransac sobre Test - Muchas correspondencias (original - original rotada - rotada por DLT refinada con Ransac)');
montage({img_a, img_b, img_ransac_test}, 'Size', [1 NaN]);

img_a = imread('imgs/flinstones.png');
img_b = imrotate(img_a,80);

h_ransac_flinstones = calculate_homography_ransac(img_a, img_b, 50, 5, 'Surf');
img_ransac_flinstones = apply_transformation(img_a, h_ransac_flinstones);

figure('Name','Ransac sobre Flinstones - Muchas correspondencias (original - original rotada - rotada por DLT refinada con Ransac)');
montage({img_a, img_b, img_ransac_flinstones}, 'Size', [1 NaN]);

% OBS: Funciona bien con todas excepto con Damero. Lo que pasa es que el
% matchFeatures de matlab no anda muy bien con esta imagen ya que hay
% muchos puntos similares. Por lo tanto los puntos a partir de los cuales
% se genera la transforamcion no son buenos




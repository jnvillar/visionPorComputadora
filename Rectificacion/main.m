filepath = fileparts(mfilename('fullpath'));
addpath(strcat(filepath, '/../imgs'));
addpath(strcat(filepath, '/../Practica 6'));

% Puntos extraidos a ojo de la imagen
down_point = [258 356];
left_point = [35 159];
right_point = [473 151];
up_point = [254 43];

% Armamos 4 rectas
line1 = [left_point ; up_point];
line2 = [down_point ; right_point];
line3 = [down_point ; left_point];
line4 = [right_point ; up_point];

% Calculamos una transformacion a partir de las rectas elegidas
h = calculate_rectification_transformation(line1, line2, line3, line4);

invh = inv(h);
img = imread('imgs/piso-mosaico.png');
new_img = apply_transformation(img, h);

% figure; imagesc(new_img); colormap(gray); %axis equal;

figure('Name','Imagen original');
imshow(img);
figure('Name','Imagen rectificada');
imagesc(new_img); colormap(gray);



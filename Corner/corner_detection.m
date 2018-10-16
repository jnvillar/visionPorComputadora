lena_img = imread('imgs/lena.png');
img = lena_img;

figure('name', 'Original');imshow(img);
res = harris(img, 0.000001);
figure('name', 'Harris');imshow(res);
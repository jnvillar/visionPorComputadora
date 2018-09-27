img1 = imread('imgs/color.png');
img2 = imread('imgs/color.png');
bw = imread('imgs/b&w.png');
% Poner show = 1 para mostrar imprimir en pantalla todas las imagenes
show = 0;

% Ej 1

sum = imgSum(img1,img2);
if(show), figure('Name', 'Suma imagen'), imshow([img1, img2, sum]), end

sub = imgSub(img1,img2);
if(show), figure('Name', 'Resta imagen'), imshow([img1, img2, sub]), end

prod = imgProd(img1,img2);
if(show), figure('Name', 'Producto imagen'), imshow([img1, img2, prod]), end

scalar = imgScalarProduct(img1,3);
if(show), figure('Name', 'Producto escalar imagen'), imshow([img1, scalar]), end

compress = imgDynamicRangeCompr(img1);
if(show), figure('Name', 'Compresion del rango dinamico'), imshow([img1, compress]), end

% Ej 2

neg = imgNeg(img1);
if(show), figure('Name', 'Imagen en negativo'), imshow([img1, neg]), end

% Ej 3

imgThresh = imgThresholding(bw, 100);
if(show), figure('Name', 'Imagen con umbral'), imshow([bw, imgThresh]), end

% Ej 4

planes = cat(2, imgBitPlane(bw, 1), imgBitPlane(bw, 2), imgBitPlane(bw, 3), imgBitPlane(bw, 4), imgBitPlane(bw, 5), imgBitPlane(bw, 6), imgBitPlane(bw, 7), imgBitPlane(bw, 8));

if(show), figure('Name', 'Bit Planes de una imagen'), imshow(planes), end

% Ej 5

vector = imgHist(bw);
if(show), figure('Name', 'Histograma'), bar(vector), end

% Ej 6

imgStretching = imgHistStretching(bw);
if(show), figure('Name', 'Aumento de contraste de una imagen'), imshow([bw, imgStretching]), end

% Ej 7

imgEqualization = imgHistEqualization(bw);
if(show), figure('Name', 'Ecualización por histograma de una imagen'), imshow([bw, imgEqualization]), end

% Ej 8

imgEqualizationDoble = imgHistEqualization(imgEqualization);
if(show), figure('Name', 'Ecualización por histograma aplicada 2 veces'), imshow([bw, imgEqualizationDoble]), end

% Al aplicar por segunda vez la ecualización por histograma observamos que
% la imagen no se modifica.

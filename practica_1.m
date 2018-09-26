img1 = imread('imgs/color.png');
img2 = imread('imgs/color.png');
bw = imread('imgs/b&w.png');
show = 0;

% Ej 1

sum = imgSum(img1,img2);
if(show), figure(1),title("Suma imagen"),imshow(sum), end

sub = imgSub(img1,img2);
if(show), figure(2),title("Resta imagen"),imshow(sub) , end

prod = imgProd(img1,img2);
if(show), figure(3),title("Prod imagen"),imshow(prod)  , end

scalar = imgScalarProduct(img1,3);
if(show), figure(4),title("Producto escalar imagen"),imshow(scalar), end

compress = imgDynamicRangeCompr(img1);
if(show), figure(5),title("Compresion del rango dinamico"),imshow(compress), end

% Ej 2

neg = imgNeg(img1);
if(show), figure(6),title("Imagen en negativo"),imshow(neg), end

% Ej 3

imgThresh = imgThresholding(bw, 100);
if(show), figure(7),title("Imagen con umbral"),imshow(imgThresh), end

% Ej 4

planes = cat(2, imgBitPlane(bw, 1), imgBitPlane(bw, 2), imgBitPlane(bw, 3), imgBitPlane(bw, 4), imgBitPlane(bw, 5), imgBitPlane(bw, 6), imgBitPlane(bw, 7), imgBitPlane(bw, 8));
if(show), figure(8),title("Bit Planes de una imagen"),imshow(planes), end

% Ej 5

vector = imgHist(bw);
if(show), figure(9),title("Histograma"),histogram(vector), end





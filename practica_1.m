img1 = imread('imgs/img.png');
img2 = imread('imgs/img.png');

% Ej 1

sum = imgSum(img1,img2);
figure(1),title("Suma imagen"),imshow(sum)

sub = imgSub(img1,img2);
figure(2),title("Resta imagen"),imshow(sub)

prod = imgProd(img1,img2);
figure(3),title("Prod imagen"),imshow(prod);


scalar = imgScalarProduct(img1,3);
figure(4),title("Producto escalar imagen"),imshow(scalar);

% Ej 2

neg = imgNeg(img1);
figure(5),title("Imagen en negativo"),imshow(neg)


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

% Ej 2

neg = imgNeg(img1);
if(show), figure(5),title("Imagen en negativo"),imshow(neg), end






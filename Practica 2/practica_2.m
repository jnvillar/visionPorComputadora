img1 = imread('imgs/fruit.png');
reduce_intensity = multiply_constant_function(0.5);
increase_intensity = multiply_constant_function(2);
res = imgChangeSaturation(img1, reduce_intensity);
res2 = imgChangeSaturation(img1, increase_intensity);
figure;
imshow([img1, res, res2]);

add_small = add_constant_function(0.08);
add_big = add_constant_function(5);
res = imgChangeHue(img1, add_small);
res2 = imgChangeHue(img1, add_big);
figure;
imshow([img1, res, res2]);


function res=imgChangeSaturation(img, f)
    hsvImg = rgb2hsv(img);
    hsvImg(:,:,2) = f(hsvImg(:,:,2));
    hsvImg(hsvImg > 1) = 1;
    res = uint8(hsv2rgb(hsvImg)*256);
end

function f=multiply_constant_function(c)
    f = @(vec) c.*vec;
end

function f=cuadratic_function()
    f = @(vec) vec.^2;
end

function f=add_constant_function(c)
    f = @(vec) c+vec;
end

function res=imgChangeHue(img, f)
hsvImg = rgb2hsv(img);
    hsvImg(:,:,1) = f(hsvImg(:,:,1));
    hsvImg(hsvImg > 1) = 1;
    res = uint8(hsv2rgb(hsvImg)*256);
end
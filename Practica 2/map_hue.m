function res=map_hue(img, f)
hsvImg = rgb2hsv(img);
    hsvImg(:,:,1) = f(hsvImg(:,:,1));
    hsvImg(hsvImg > 1) = 1;
    res = uint8(hsv2rgb(hsvImg)*256);
end
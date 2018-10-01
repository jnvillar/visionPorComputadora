function res=map_saturation(img, f)
    hsvImg = rgb2hsv(img);
    hsvImg(:,:,2) = f(hsvImg(:,:,2));
    hsvImg(hsvImg > 1) = 1;
    res = uint8(hsv2rgb(hsvImg)*256);
   
end
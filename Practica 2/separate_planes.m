function res=separate_planes(img)
    hsvImg = rgb2hsv(img);
    res=[hsvImg(:,:,1), hsvImg(:,:,2), hsvImg(:,:,3)];
end
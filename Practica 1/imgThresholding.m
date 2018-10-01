function f = imgThresholding(img, threshold)
    f = (img >= threshold) * 255;
end
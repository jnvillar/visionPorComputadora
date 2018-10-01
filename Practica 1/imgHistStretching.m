function f = imgHistStretching(img)

    hist = imgHist(img);
    min = 0;
    max = 1;
    for x = 1:length(hist)
       if (min == 0 && hist(1,x) > 0)
           min = x;
       end
       if (hist(1,x) > 0)
           max = x;
       end
    end
    
    max = max - 1;
    min = min - 1;
    
    [x,y] = size(img);
    minMatrix(1:x,1:y) = uint8(min);
    f = (img - minMatrix) .* (255/(max - min));
end
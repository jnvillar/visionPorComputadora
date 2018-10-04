function res=median_filter(img, k)
    [X, Y, Z] = size(img);
    res = zeros(X,Y,Z);
    for i=1:X
        for j=1:Y
            for c=1:Z
                from_x = max(i-k,1);
                to_x = min(i+k,X);
                from_y = max(j-k,1);
                to_y = min(j+k,Y);
                neighbours = img(from_x:to_x,from_y:to_y,c);
                pixel_median = median(neighbours(:));
                res(i,j,c) = pixel_median;
            end
        end
    end
end
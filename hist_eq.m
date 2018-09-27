function [res]=hist_eq(img)
[X, Y, Z] = size(img);
histograms_by_color = zeros(Z, 256);
for i=1:Z
    histograms_by_color(i,:) = imgHist(img(:,:,i));
end

total_pixels = X*Y;
res = zeros(X,Y,Z);
for i=1:X
    for j=1:Y
        for k=1:Z
            gray_level = img(i,j, k);
            acum = 0;
            for h=1:gray_level
                acum = acum + histograms_by_color(k, h);
            end
            res(i,j,k) = acum/total_pixels;
        end
    end
end
sk_min = min(min(res));
res = (254/(1-sk_min)).*(res-sk_min)+0.5;
res = uint8(res);
end
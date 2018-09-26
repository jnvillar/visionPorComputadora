function [res]=hist_eq(img)
hist = imgHist(img);

[X, Y] = size(img);
total_pixels = X*Y;

for i=1:X
    for j=1:Y
        gray_level = img(i,j);
        acum = 0;
        for h=1:gray_level
             acum = acum + hist(h);
        end
        if gray_level == 245
            disp("okaaa");
            disp(acum);
        end
        res(i,j) = acum/total_pixels;
    end
end
sk_min = min(min(res));
res = (254/(1-sk_min)).*(res-sk_min)+0.5;
res = uint8(res);
hist_res = imgHist(res);
bar(hist_res);
end
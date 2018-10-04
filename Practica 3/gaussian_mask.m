function res=gaussian_mask(size, sigma)
    res = fspecial('gaussian',size,sigma);
end

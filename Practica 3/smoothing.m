function res=smoothing(img, params)
    if ~exist('params','var')
        size = 5;
        sigma = 2;
    else
        size = params('size');
        sigma = params('sigma');
    end
    
    mask = gaussian_mask(size, sigma);
    res = image_convolution(img, mask);
end
function res=canny(img)
    smooth_img = image_convolution(img, gaussian_mask(5, 1.050)); 
    magnitude = get_magnitude(smooth_img);
   
    direction = get_direction(smooth_img);
    no_max_supr_img = no_max_supressor(magnitude, direction);
    imshow([smooth_img, magnitude, direction, no_max_supr_img])
    
    res=magnitude;
end



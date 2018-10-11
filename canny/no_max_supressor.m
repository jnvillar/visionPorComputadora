function res=no_max_supressor(magnitude_img, direction_img)
    best_direction_img = best_approximation_matrix(direction_img);
    [X,Y] = size(magnitude_img);
    res = zeros(X,Y);
    for i=1:X
        for j=1:Y
            res(i,j) = name_to_change(best_direction_img, magnitude_img, i, j);
        end
    end
end


function res=best_approximation_matrix(dir_img)
    [X,Y] = size(dir_img);
    res = zeros(X,Y);
    for i=1:X
        for j=1:Y
            res(i,j) = best_approximation(dir_img(i,j));
        end
    end
end


function res=best_approximation(radian)
    posible_dirs = [0, 0.7854, 1.5708, 2.3562];
    dir = min(posible_dirs-radian);
    res = dir+radian;
end


function res=name_to_change(best_dir_img, magnitude_img, i, j)
    best_dir = best_dir_img(i,j);
    
    if best_dir == 0
        i1 = i+1;
        j1 = j;
        i2 = i-1;
        j2 = j;
    elseif best_dir == 0.7854
        i1 = i+1;
        j1 = j+1;
        i2 = i-1;
        j2 = j-1;
    elseif best_dir == 1.5708
        i1 = i;
        j1 = j+j;
        i2 = i;
        j2 = j-1;
    elseif best_dir == 2.3562
        i1 = i-1;
        j1 = j+1;
        i2 = i+1;
        j2 = j-1;
    end
    mag1 = get_or_default(magnitude_img, i1, j1, 9999999);
    mag2 = get_or_default(magnitude_img, i2, j2, 9999999);
    res=calculate_value(mag1, mag2, magnitude_img(i,j));
end
        
        
function res=get_or_default(img, i, j, default)
    [X,Y] = size(img);
    if i > X || j > Y || j == 0 || i == 0
        res = default;
    else
        res = img(i,j);
    end
end

function res=calculate_value(mag1, mag2, pixel)
    if pixel < mag1 || pixel < mag2
        res = 0;
    else 
        res = pixel;
    end
end


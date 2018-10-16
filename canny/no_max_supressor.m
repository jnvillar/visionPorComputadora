function res=no_max_supressor(magnitude_img, direction_img)
    [X,Y] = size(magnitude_img);
    res = zeros(X,Y);
    for i=1:X
        for j=1:Y
            res(i,j) = get_or_supress(direction_img, magnitude_img, i, j);
        end
    end
end


function res=get_or_supress(best_dir_img, magnitude_img, i, j)
    best_dir = best_dir_img(i,j);
    
    if best_dir == 0
        i1 = i+1;
        j1 = j;
        i2 = i-1;
        j2 = j;
    elseif best_dir == 45
        i1 = i+1;
        j1 = j+1;
        i2 = i-1;
        j2 = j-1;
    elseif best_dir == 90
        i1 = i;
        j1 = j+j;
        i2 = i;
        j2 = j-1;
    elseif best_dir == 135
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


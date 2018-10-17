function res=hysteresis_threshold(magnitude, directions, u_min, u_max)
    [X,Y] = size(magnitude);
    borders = zeros(X,Y);
    visited = zeros(X,Y);
        for i=1:X
            for j=1:Y       
                if visited(i,j) == 0 && magnitude(i,j) > u_max
                    k = i;
                    l = j;
                    while magnitude(k,l) > u_min
                        borders(k,l) = 255;
                        visited(k,l) = 1;
                        m = next(visited,directions, k,l);
                        disp(m)
                        k = m(1);
                        l = m(2);
                    end
                end
            end
        end  
    res = uint8(borders);
end

function f=next(visited, directions, k, l)
    m = pixel_in_direction(directions, k, l, 90);
    res_x = m(1);
    res_y = m(2);
    if visited(res_x,res_y) == 1
        m = pixel_in_direction(directions, k, l, 90*3);
        res_x = m(1);
        res_y = m(2);
    end
    f=[res_x,res_y];
end

function f = pixel_in_direction(directions, k, l, degrees)
    [i,j] = size(directions);
    direction = directions(k,l);
    
%     disp("degrees")
%     disp(degrees) 
%     disp("pixel")
%     disp([k,l])
%     disp("direction")
%     disp(direction)
    
    res_x = cosd(direction+degrees);
    res_y = sind(direction+degrees);

    if res_x > 0
        res_x = max(k-1,1);
    elseif res_x < 0
        res_x = min(k+1, i); 
    elseif res_x == 0
        res_x = k;
    end
    
    if res_y > 0
        res_y = max(l-1,1);
    elseif res_y < 0
        res_y = min(l+1, j);
    elseif res_y == 0
        res_y = l;
    end
    
%     disp("resultado")
%     disp([res_x,res_y])
    
    f = [res_x,res_y];
end

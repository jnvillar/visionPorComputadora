function res = harris(img, threshold, func_r)
    img = im2double(img);
    
    dx = [-1 0 1; -1 0 1; -1 0 1]; % image derivatives
    dy = dx';
    
    gradient_x = conv2(img, dx, 'same');
    gradient_y = conv2(img, dy, 'same');
    
    %figure('name', 'gradients'); imshow([gradient_x, gradient_y]);
    
    gx2 = gradient_x.*gradient_x;
    gy2 = gradient_y.*gradient_y;
    gxy = gradient_x.*gradient_y;
    
    %figure('name', 'gradients^2'); imshow([gx2, gy2, gxy]);
    
    gaussian = gaussian_mask(9, 2);
    gx2 = conv2(gx2, gaussian, 'same');
    gy2 = conv2(gy2, gaussian, 'same');
    gxy = conv2(gxy, gaussian, 'same');
    
    %figure('name', 'after gauss'); imshow([gx2, gy2, gxy])

    [X,Y] = size(img);
    
    R = zeros(X,Y);
    E1 = zeros(X,Y);
    E2 = zeros(X,Y);
    

    sigma = 3;

    for i=2:X-1
        for j=2:Y-1
            w = 1;
            ix2 = sum(sum(gx2(i-1:i+1,j-1:j+1).*w));
            iy2 = sum(sum(gy2(i-1:i+1,j-1:j+1).*w));
            ixy = sum(sum(gxy(i-1:i+1,j-1:j+1).*w));
            M = [ix2 ixy;ixy iy2].*w;
            
            
            eigs = eig(M);
            
            R(i,j) = func_r(eigs);
            %R(i,j) = eigs(1)*eigs(2) - k * (eigs(1)+eigs(2)).^2;

            
        end
    end

    %figure('name', 'R'); imshow(R);

    for i=1:X
        for j=1:Y
            if R(i,j) < threshold
                R(i,j) = 0;
            end
        end
    end
    %figure('name', 'Above Threshold'); imshow(R);
    
    local_max = zeros(X,Y);
    remove_center = ones(3,3);
    remove_center(2,2) = 0;
    for i=2:X-1
        for j=2:Y-1
            max_value = max(max(R(i-1:i+1,j-1:j+1).*remove_center));
            if R(i,j) > max_value
                local_max(i,j) = 1;
            else
                local_max(i,j) = 0;
            end
        end
    end

     
    %figure('name', 'No max supression'); imshow(local_max);
        
    res = local_max;
    
    
end


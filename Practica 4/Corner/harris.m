function res = harris(img, threshold)
    img = im2double(img);
    
    dx = [-1 0 1; -1 0 1; -1 0 1]; % image derivatives
    dy = dx';
    
    gradient_x = conv2(img, dx);
    gradient_y = conv2(img, dy);
    
    %figure('name', 'gradients'); imshow([gradient_x, gradient_y]);
    
    gx2 = gradient_x.*gradient_x;
    gy2 = gradient_y.*gradient_y;
    gxy = gradient_x.*gradient_y;
    
    %figure('name', 'gradients^2'); imshow([gx2, gy2, gxy]);
    
    gaussian = gaussian_mask(9, 2);
    gx2 = conv2(gx2, gaussian);
    gy2 = conv2(gy2, gaussian);
    gxy = conv2(gxy, gaussian);
    
    %figure('name', 'after gauss'); imshow([gx2, gy2, gxy])

    [X,Y] = size(img);
    
    R = zeros(X,Y);
    E1 = zeros(X,Y);
    E2 = zeros(X,Y);
    
    k = 0.04;
    sigma = 3;
%     for i=1:X
%         for j=1:Y
%             w = exp(-(i^2+j^2)/2*sigma^2);
%             M = [gx2(i,j) gxy(i,j);gxy(i,j) gy2(i,j)].*w;
%             det_M = det(M);
%             trace_M = trace(M);
%             R(i,j) = det_M - k * trace_M^2;
%         end
%     end
    for i=2:X-1
        for j=2:Y-1
            w = 1;%exp(-(i^2+j^2)/2*sigma^2);
            ix2 = sum(sum(gx2(i-1:i+1,j-1:j+1)));
            iy2 = sum(sum(gy2(i-1:i+1,j-1:j+1)));
            ixy = sum(sum(gxy(i-1:i+1,j-1:j+1)));
            M = [ix2 ixy;ixy iy2].*w;
            det_M = det(M);
            trace_M = trace(M);
            R(i,j) = det_M - k * trace_M^2;
        end
    end

    
    figure('name', 'R'); imshow(R);
    
    res = zeros(X,Y);
    for i=1:X
        for j=1:Y
            if R(i,j) > 2
                res(i,j) = 255;
            else
                res(i,j) = 0;
            end
        end
    end
    
end


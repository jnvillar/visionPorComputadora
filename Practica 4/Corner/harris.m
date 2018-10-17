function res = harris(img, threshold)
    gradient_x = gradient_matrix_x(img);
    gradient_y = gradient_matrix_y(img);
    
    gx2 = gradient_x.*gradient_x;
    gy2 = gradient_y.*gradient_y;
    gxy = gradient_x.*gradient_y;
    
    gaussian = gaussian_mask(9, 2);
    gx2 = conv2(gx2, gaussian);
    gy2 = conv2(gy2, gaussian);
    gxy = conv2(gxy, gaussian);
    
    [X,Y] = size(img);
    R = zeros(X,Y);
    k = 0.04 - 0.06;
    sigma = 3;
    for i=1:X
        for j=1:Y
            w = exp(-(i^2+j^2)/2*sigma^2);
            M = [gx2(i,j) gxy(i,j);gxy(i,j) gy2(i,j)].*w;
            det_M = det(M);
            trace_M = trace(M);
            R(i,j) = det_M - k * trace_M^2;
        end
    end

    res = zeros(X,Y);
    for i=1:X
        for j=1:Y
            if R(i,j) > threshold
                res(i,j) = 255;
            else
                res(i,j) = 0;
            end
            
        end
    end
    
    
end


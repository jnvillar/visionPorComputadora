function f=lapplacian_borders(img, t, m)
    square_gradient_matrix = calculate_square_gradient_matrix(img);
    [X,Y] = size(img);
    f = zeros(X,Y);
    for i=1:X
        for j=1:Y
            if(square_gradient_matrix(i,j) == 0)
                variance = local_variance(m,img,i,j);
                
                if variance > t
                    f(i,j) = 255;
                end
            else
                f(i,j) = 0;
            end
        end
    end
end

   
function f=calculate_square_gradient_matrix(img)
    laplacian_mask = [0 1 0;1 -4 1;0 1 0];
    square_gradients_matrix = image_convolution(img,laplacian_mask);
    f = square_gradients_matrix;
end


function f=local_variance(m, img, i, j)
    [X,Y] = size(img);
    constant = 1/((2*m + 1)^2);
    
    round_m = round(m);   
    min_i = max(1,i-round_m);
    max_i = min(X,i+round_m);  
    min_j = max(1,j-round_m);
    max_j = min(Y,j+round_m);
    
    sum = 0;
    for eje_x=min_i:max_i
        for eje_y=min_j:max_j
           sum = sum + ((img(eje_x,eje_y)-aux(m,i,j,img))^2);
        end
    end
   f=constant*sum;
end

function f=aux(m,i,j,img)
    [X,Y] = size(img);
    constant = 1/((2*m + 1)^2);
    
    round_m = round(m);   
    min_i = max(1,i-round_m);
    max_i = min(X,i+round_m);  
    min_j = max(1,j-round_m);
    max_j = min(Y,j+round_m);

    sum = 0;
    for eje_x=min_i:max_i
        for eje_y=min_j:max_j
           sum = sum + img(eje_x,eje_y);
        end
    end
   
    f=constant*sum;
end
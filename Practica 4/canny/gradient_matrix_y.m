function res=gradient_matrix_y(img)
    [X,Y] = size(img);
    res = zeros(X,Y);
    for i=1:X
        for j=1:Y
            if j ~= Y
                res(i,j) = img(i,j+1)-img(i,j);
            else
                res(i,j) = 0;
            end
        end
    end
end
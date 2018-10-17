function res=gradient_matrix_x(img)
    [X,Y] = size(img);
    res = zeros(X,Y);
    for i=1:X
        for j=1:Y
            if i ~= X
                res(i,j) = img(i+1,j)-img(i,j);
            else
                res(i,j) = 0;
            end
        end
    end
end
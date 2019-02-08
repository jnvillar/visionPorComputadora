function res_img=apply_transformation(img, h)
    res_img = res_image(img, h);
    offset = offsets(img, h);
    [height_original_img, width_original_img] = size(img);
    [height, width] = size(res_img);

    invh = inv(h);

    for i=1:width
        for j=1:height
            pos_in_original_img = transform(i + offset(1),j + offset(2),invh);
            if pos_in_original_img(1) <= 0 || pos_in_original_img(1) > width_original_img || pos_in_original_img(2) <= 0 || pos_in_original_img(2) > height_original_img

            else
                res_img(j,i) = img(pos_in_original_img(2),pos_in_original_img(1));
            end
        end
    end
end

function f = offsets(img, h)
    [Y, X] = size(img);
    b1 = transform(1,1,h);
    b2 = transform(X,1,h);
    b3 = transform(1,Y,h);
    b4 = transform(X,Y,h);
    left = min([b1(1) b2(1) b3(1) b4(1)]);
    up = min([b1(2) b2(2) b3(2) b4(2)]);
    f = [left, up];
end

function f=res_image(img, h)
    [Y, X] = size(img);
    b1 = transform(1,1,h);
    b2 = transform(X,1,h);
    b3 = transform(1,Y,h);
    b4 = transform(X,Y,h);
    left = min([b1(1) b2(1) b3(1) b4(1)]);
    right = max([b1(1) b2(1) b3(1) b4(1)]);
    new_x = abs(left-right);
    
    up = min([b1(2) b2(2) b3(2) b4(2)]);
    down = max([b1(2) b2(2) b3(2) b4(2)]);
    new_y = abs(up-down);
    
    f = uint8(ones(new_y,new_x).*100);
end
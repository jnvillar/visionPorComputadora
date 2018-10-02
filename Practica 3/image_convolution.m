function res=image_convolution(img, conv)
    [X, Y, Z] = size(img);
    for i=1:Z
        res(:,:,i) = uint8(conv2(img(:,:,i), conv, 'same'));
    end
    %res = uint8(conv2(img, conv, 'same'));
end
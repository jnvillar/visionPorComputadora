lena_img = imread('imgs/lena.png');
test_img = imread('imgs/test.png');
img = test_img;

figure('name', 'Original');imshow(img);
show_corner_detection(img, @harris_r, 2)
show_corner_detection(img, @triggs_r, 2)
show_corner_detection(img, @szeliski_r, 1)
show_corner_detection(img, @shi_tomasi_r, 0.5)


function show_corner_detection(img, f, threshold)
    res = harris(img, threshold, f);

    [X,Y] = size(res);
    with_markers = cat(3, img, img, img);
    for i=1:X
        for j=1:Y
            if res(i,j) > 0
                with_markers = insertMarker(with_markers,[j,i],'plus');
            end
        end
    end
    figure();imshow(with_markers);
end

function res=harris_r(eigs)
    k = 0.04;
    res = eigs(1)*eigs(2) - k * (eigs(1)+eigs(2)).^2;
end


function res=triggs_r(eigs)
    alpha = 0.05;
    res = eigs(1)-alpha*eigs(2);
end


function res=szeliski_r(eigs)
    res = eigs(1)*eigs(2)/(eigs(1)+eigs(2));
end

function res=shi_tomasi_r(eigs)
    res = eigs(1);
end


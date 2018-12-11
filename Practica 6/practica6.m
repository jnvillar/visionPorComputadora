lena = imread('imgs/lena.png');
img = lena;
[X, Y] = size(lena);

points = detectSURFFeatures(img);
figure; imshow(img);
hold on;
plot(points);

ransac_threshold = round(X * 0.1);
points = get_features_points(img, false, 0);
filtered_points = get_features_points(img, true, ransac_threshold);
[nk, ~] = size(points);
[nm, ~] = size(filtered_points);

disp("Cantidad de puntos caracteristicos encontrados por sift " + nk);
disp("Cantidad de puntos caracteristicos encontrados por sift filtrando con ransac " + nm);
disp("Media de reduccion por ransac " + nm/nk);



function points=get_features_points(img, with_ransac, ransac_threshold)
    points = [];
    for angle=1:360
        rotated_img = imrotate(img, angle);
        features = detectSURFFeatures(rotated_img);
        features = features.Location;
        if with_ransac
            features = ransac(features, ransac_threshold);
        end
        points = [points; features];
    end

    for scale=0.25:0.01:2
        resized_img = imresize(img,scale);
        features = detectSURFFeatures(resized_img);
        features = features.Location;
        if with_ransac
            features = ransac(features, ransac_threshold);
        end
        points = [points; features];
    end

    for bright=-127:127
        brighted_img = img+bright;
        features = detectSURFFeatures(brighted_img);
        features = features.Location;
        if with_ransac
            features = ransac(features, ransac_threshold);
        end
        points = [points; features];
    end

    for sigma=3:2:41
        with_noise_img = imnoise(img,'gaussian',0,sqrt(sigma));
        features = detectSURFFeatures(with_noise_img);
        features = features.Location;
        if with_ransac
            features = ransac(features, ransac_threshold);
        end
        points = [points; features];
    end

end




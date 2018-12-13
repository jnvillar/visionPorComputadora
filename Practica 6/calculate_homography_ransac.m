
function h=calculate_homography_ransac(img1, img2, iterations, threshold, detectionMethod)

    if size(img1,3) > 1
        img1 = rgb2gray(img1);
    end
    if size(img2,3) > 1
        img2 = rgb2gray(img2);
    end
    
    if strcmp(detectionMethod,'Surf')
        points1 = detectSURFFeatures(img1);
        points2 = detectSURFFeatures(img2);
    elseif strcmp(detectionMethod,'Harris')
        points1 = detectHarrisFeatures(img1);
        points2 = detectHarrisFeatures(img2);
    else
        disp('Ransac: el metodo dado es invalido. Usar Harris o Surf');
        return;
    end

    [features1,valid_points1] = extractFeatures(img1,points1);
    [features2,valid_points2] = extractFeatures(img2,points2);

    indexPairs = matchFeatures(features1,features2);
    matchedPoints1 = valid_points1(indexPairs(:,1));
    matchedPoints2 = valid_points2(indexPairs(:,2));
    
    %Para mostrar en un grafico las correspondencias calculadas
%     figure; showMatchedFeatures(img1,img2,matchedPoints1,matchedPoints2);
%     legend('matched points 1','matched points 2');

    h = ransac(matchedPoints1.Location, matchedPoints2.Location, iterations, threshold);
end
function p=interest_points(img)
    corners = detectHarrisFeatures(img);
    [~, valid_corners] = extractFeatures(img, corners);
    
    p=valid_corners.Location;
end


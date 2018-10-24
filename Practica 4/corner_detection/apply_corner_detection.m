function res=apply_corner_detection(img, f, threshold)
    res = corner_detection(img, threshold, f);

    [X,Y] = size(res);
    with_markers = cat(3, img, img, img);
    for i=1:X
        for j=1:Y
            if res(i,j) > 0
                with_markers = insertMarker(with_markers,[j,i],'plus');
            end
        end
    end
    res=with_markers;
end


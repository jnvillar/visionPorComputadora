function h=ransac(correspondence_points1, correspondence_points2, iterations, threshold)
    
    [total_points, ~] = size(correspondence_points1);
    
    if total_points < 4
        disp('RANSAC: Al menos se deben tener 4 correspondencias');
        return;
    end
    
    min_outliers_h = -1;
    min_outliers_number = inf;

    for i=1:iterations
        points = four_random_points(total_points, correspondence_points1);
        points_c1 = correspondence_points1(points,:);
        points_c2 = correspondence_points2(points,:);
        h = dlt(points_c1, points_c2);
        outliers_i = 0;
        for j=1:total_points
            p1 = correspondence_points1(j,:);
            p2 = correspondence_points2(j,:);
            
            transfer_error = calcualte_transfer_error(p1, p2, h);
            if (transfer_error > threshold)
                outliers_i = outliers_i + 1;
            end
        end
        
        if outliers_i < min_outliers_number
            min_outliers_number = outliers_i;
            min_outliers_h = h;
        end
    end
    h = min_outliers_h;
end

function te = calcualte_transfer_error(p1, p2, h)
    p1h = transform(p1(1), p1(2), h);
    p2invh = transform(p2(1), p2(2), inv(h));
    te = pdist([p1h ; p2]).^2 + pdist([p1 ; p2invh]).^2;
end

function p = four_random_points(total_points, points)
    p = [];
    n = 4;
    while n > 0
        point = random_point(total_points);           
        if ~ismember(point, p)
            if n == 2 && collinear(points(p(1),:), points(p(2),:), points(point,:))
                continue
            elseif n == 1 && (collinear(points(p(1),:), points(p(2),:), points(point,:)) || collinear(points(p(2),:), points(p(3),:), points(point,:)) || collinear(points(p(1),:), points(p(3),:), points(point,:)))
                continue
            end
            p = [p ; point];
            n = n - 1;
        end
    end
end

function p = random_point(total_points)
    p = ceil(rand() * total_points);
end

function tf = collinear(p1, p2, p3)
    mat = [p1(1)-p3(1) p1(2)-p3(2); p2(1)-p3(1) p2(2)-p3(2)];
    tf = det(mat) == 0;
end

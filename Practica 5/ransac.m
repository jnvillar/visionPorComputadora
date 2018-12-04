%original_points = [2 2; 3 3; 4 4; 5 5; 6 7; 9 0; 3 0; 3 4; 7 3; 6 5; 8 4; 5 2];
%figure(1); plot(original_points(:,1),original_points(:,2), 'gx' )
%hold on
function p=ransac(original_points, max_distance)


    [amount_of_points, ~] = size(original_points);
    iterations = 1000;
    thresshold = 1;

    max_close_points = 0;
    res_slope = 0;
    res_intercept = 0;
    res_point_one = [];
    res_point_two = [];

    for i=1:iterations 
        points = two_random_points(original_points);
        point_one = points(1,:);
        point_two = points(2,:);

        slope = (point_two(2) - point_one(2)) / (point_two(1) - point_one(1));
        intercept = point_one(2) - slope * point_one(1);
        amount_of_close_points = 0;

        for j=1:amount_of_points
            d = distance(original_points(j,:), slope, intercept);
            if d < thresshold
                amount_of_close_points = amount_of_close_points + 1;
            end
        end

        if amount_of_close_points > max_close_points
            max_close_points = amount_of_close_points;
            res_slope = slope;
            res_intercept = intercept;
            res_point_one = point_one;
            res_point_two = point_two;
        end
    end

    p = [];
    amount = 0;
    for i=1:amount_of_points
        if distance(original_points(i,:),res_slope,res_intercept) <= max_distance
            amount = amount+1;
            p(amount,:) = original_points(i,:);
        end
    end
end
%plot([res_point_one(1) res_point_two(1)],[res_point_one(2) res_point_two(2)], 'Color', 'red', 'LineStyle', '--');
%hold off

function f = distance(point, slope, intercept)
    f = abs(slope*point(1) - point(2) + intercept)/(sqrt(slope*slope + 1));
end

function f = two_random_points(points)
    point_one = random_point(points);
    point_two = random_point(points);
    while point_one(1) == point_two(1)
         point_two = random_point(points);
    end
    f = [point_one ; point_two];
end


function f = random_point(points)
    [X, ~] = size(points);
    random_position = ceil(rand()*X);
    f = points(random_position,:);
end
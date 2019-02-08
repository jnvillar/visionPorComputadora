function h=calculate_rectification_transformation(line1, line2, line3, line4)
    
    p1_intersection = intersection_point(line1(1,:), line1(2,:), line2(1,:), line2(2,:));
    p2_intersection = intersection_point(line3(1,:), line3(2,:), line4(1,:), line4(2,:));

    p1_proyective = [p1_intersection, 1];
    p2_proyective = [p2_intersection, 1];
    
    l = cross(p1_proyective, p2_proyective);

    h = [1 0  0 ; 0 1 0; l./l(3)];
end

function res=intersection_point(p1, p2, p3, p4)
    xi = ((p1(1)*p2(2) - p1(2)*p2(1)) * (p3(1)-p4(1)) - (p1(1)-p2(1)) * (p3(1)*p4(2) - p3(2)*p4(1))) / ((p1(1)-p2(1)) * (p3(2)-p4(2)) - (p1(2)-p2(2)) * (p3(1)-p4(1)));
    yi = ((p1(1)*p2(2) - p1(2)*p2(1)) * (p3(2)-p4(2)) - (p1(2)-p2(2)) * (p3(1)*p4(2) - p3(2)*p4(1))) / ((p1(1)-p2(1)) * (p3(2)-p4(2)) - (p1(2)-p2(2)) * (p3(1)-p4(1)));
    res = [xi yi];
end
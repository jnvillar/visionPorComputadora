function h=dlt(edges_a, edges_b)
    
    [edges, ~] = size(edges_a);
    
    if edges < 4
        disp('DLT: Al menos se deben tener 4 correspondencias');
        return;
    end
    
    corresponde_matrixes = zeros(2*edges, 9);
    
    for i=1:edges
        an_edge_a = edges_a(i,:);
        an_edge_b = edges_b(i,:);
        proyective_point_a = [an_edge_a 1];
        proyective_point_b = [an_edge_b 1];
        correspondence_matrix = generate_correspondence_matrix(proyective_point_a, proyective_point_b);
        corresponde_matrixes(2*(i-1)+1,:) = correspondence_matrix(1,:);
        corresponde_matrixes(2*(i-1)+2,:) = correspondence_matrix(2,:);
    end

    [U,S,V] = svd(corresponde_matrixes);
    h = V(:,9);
    h = [h(1) h(2) h(3); h(4) h(5) h(6); h(7) h(8) h(9)];
end
    
    
function res=generate_correspondence_matrix(img_a_edge, img_b_edge)
    a = img_a_edge;
    b = img_b_edge;
    res = [0 0 0 (-1)*b(3)*a b(2)*a;(1)*b(3)*a 0 0 0 (-1)*b(1)*a];
end

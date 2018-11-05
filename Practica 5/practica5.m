filepath = fileparts(mfilename('fullpath'));
addpath(strcat(filepath, '/../imgs'));

img_a = imread('imgs/lena.png');
img_b = imread('imgs/lena.png');

edges_img_a = [ 607 533 ; 752 256 ; 636 465 ; 985 341 ];
edges_img_b = [ 711 525 ; 298 215 ; 284 361 ; 687 338 ];
[edges, ignore] = size(edges_img_a);

show_selected_edges(edges, img_a, img_b, edges_img_a, edges_img_b)
corresponde_matrixes = zeros(2*edges, 9);

for i=1:edges
    an_edge_a = edges_img_a(i,:);
    an_edge_b = edges_img_b(i,:);
    proyective_point_a = [an_edge_a 1];
    proyective_point_b = [an_edge_b 1];
    correspondence_matrix = generate_correspondence_matrix(proyective_point_a, proyective_point_b);
    corresponde_matrixes(2*(i-1)+1,:) = correspondence_matrix(1,:);
    corresponde_matrixes(2*(i-1)+2,:) = correspondence_matrix(2,:);
end

[U,S,V] = svd(corresponde_matrixes);
h = V(:,9);
h = vec2mat(h, 3);

res = image_convolution(img_a, h);

disp(res)
imshow(res)

function res=generate_correspondence_matrix(img_a_edge, img_b_edge)
    a = img_a_edge;
    b = img_b_edge;
    res = [0 0 0 (-1)*b(3)*a b(2)*a;(-1)*b(3)*a 0 0 0 (-1)*b(1)*a];
end

function show_selected_edges(edges, img_a, img_b, edges_img_a, edges_img_b)
    for i=1:edges
        with_markers_a = insertMarker(img_a,edges_img_a(i,:),'plus');
        with_markers_b = insertMarker(img_b,edges_img_b(i,:),'plus');
    end
    imshow(with_markers_a);
     imshow(with_markers_b);
end





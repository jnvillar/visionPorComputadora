filepath = fileparts(mfilename('fullpath'));
addpath(strcat(filepath, '/../imgs/dameros'));
addpath(strcat(filepath, '/../Practica 3'));

img_a = imread('dameros/rect_a.jpg');
img_b = imread('dameros/rect_b.jpg');

edges_img_a = [ 850 140 ; 1500 2000 ; 1500 2000 ; 1500 2000 ];
edges_img_b = [ 607 533 ; 752 256 ; 636 465 ; 985 341 ];

[edges, ignore] = size(edges_img_a);

show_selected_edges(edges, img_a, img_b, edges_img_a, edges_img_b)
return;
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
figure; imshow(res)

function res=generate_correspondence_matrix(img_a_edge, img_b_edge)
    a = img_a_edge;
    b = img_b_edge;
    res = [0 0 0 (-1)*b(3)*a b(2)*a;(-1)*b(3)*a 0 0 0 (-1)*b(1)*a];
end

function show_selected_edges(edges, img_a, img_b, edges_img_a, edges_img_b)
    for i=1:edges
        img_a = insertMarker(img_a,edges_img_a(i,:),'plus', 'size', 40);
        imb_b = insertMarker(img_b,edges_img_b(i,:),'plus', 'size', 40);
    end
    figure; imshow(img_a);
   % figure; imshow(imb_b);
end





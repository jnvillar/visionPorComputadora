filepath = fileparts(mfilename('fullpath'));
addpath(strcat(filepath, '/../imgs'));
addpath(strcat(filepath, '/../Practica 3'));

lena = imread('imgs/lena.png');
img_a = rgb2gray(imread('imgs/damero1.jpg'));
img_b = rgb2gray(imread('imgs/damero2.jpg'));

edges_img_a = [ 870 780; 1167 792; 869 1085; 1162 1090];
edges_img_b = [ 285 1832 ; 409 1617; 482 1960; 612 1739];
[height, width] = size(img_a);
[edges, ignore] = size(edges_img_a);

%show_selected_edges(edges, img_a, img_b, edges_img_a, edges_img_b)
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

rotation = [ cosd(90) -sind(90) 500 ;  sind(90) cosd(90) 100 ; 0 0 1];

disp(corresponde_matrixes)

[U,S,V] = svd(corresponde_matrixes);
h = V(:,9);
h = vec2mat(h, 3);
new_img = uint8(zeros(10000,10000));

disp(h)

for i=1:height
    for j=1:width
        old_pos = [i j];
        new_pos = transform(i,j,h);
        new_img(new_pos(1), new_pos(2)) = img_a(old_pos(1),old_pos(2));
    end
end

figure; imshow(new_img);
figure; imshow(img_a);
figure; imshow(img_b);

function res=generate_correspondence_matrix(img_a_edge, img_b_edge)
    a = img_a_edge;
    b = img_b_edge;
    res = [0 0 0 (-1)*b(3)*a b(2)*a;(-1)*b(3)*a 0 0 0 (-1)*b(1)*a];
end

function show_selected_edges(img_a, img_b, edges_img_a, edges_img_b)
    img_a = insertMarker(img_a,edges_img_a,'plus', 'color', 'green', 'size', 100);
    imb_b = insertMarker(img_b,edges_img_b,'plus', 'color', 'green', 'size', 100);

    figure; imshow(img_a);
    figure; imshow(imb_b);
end

function f = transform(x,y,m)
    v = [x y 1]';
    v = m*v;
    v = [round(v(1)*3000)+4000 round(v(2)*3000)+4000];
    f = v;
end





filepath = fileparts(mfilename('fullpath'));
addpath(strcat(filepath, '/../imgs'));
addpath(strcat(filepath, '/../Practica 3'));

lena = imread('imgs/lena.png');
img_a = rgb2gray(imread('imgs/damero1.jpg'));
img_b = rgb2gray(imread('imgs/damero2.jpg'));

scale = 0.125;
img_a = imresize(img_a,scale);
img_b = imresize(img_b,scale);
size(img_a)

edges_img_a = scale*[ 870 780; 1167 792; 869 1085; 1162 1090];
edges_img_b = scale*[ 285 1832 ; 409 1617; 482 1960; 612 1739];
[edges, ignore] = size(edges_img_a);





% img_b = new_img; 
% edges_img_b = h2*[edges_img_a'; ones(1,length(edges_img_a))];
% edges_img_b = edges_img_b'
% 
% offset = offsets(img_a, h2)
% edges_img_b = edges_img_b - [repmat([offset 0],4,1)]




% close all;
% figure
% imagesc(img_a)
% colormap(gray)
% hold on;
% plot(edges_img_a(:,1),edges_img_a(:,2),'gx-')
% title('image a ')
% 
% figure
% imagesc(img_b)
% colormap(gray)
% hold on;
% plot(edges_img_b(:,1),edges_img_b(:,2),'gx-')
% title('image b ')



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


disp(corresponde_matrixes)

[U,S,V] = svd(corresponde_matrixes);
h = V(:,9);
h = vec2mat(h, 3);

ang = pi/4;
h = [cos(ang) -sin(ang) 0;
    sin(ang) cos(ang) 0;
    0 0 1];



new_img = res_image(img_a, h);
offset = offsets(img_a, h);
[width_original_img, height_original_img] = size(img_a);
[width, height] = size(new_img);
invh = inv(h);


for i=1:width
    for j=1:height
        pos_in_original_img = transform(i + offset(1),j + offset(2),invh);
        if pos_in_original_img(1) <= 0 || pos_in_original_img(1) > width_original_img || pos_in_original_img(2) <= 0 || pos_in_original_img(2) > height_original_img
        
        else
             new_img(i,j) = img_a(pos_in_original_img(1),pos_in_original_img(2));
        end
    end
end


figure; imshow(new_img);


function f = offsets(img, h)
    [X, Y] = size(img);
    b1 = transform(1,1,h);
    b2 = transform(X,1,h);
    b3 = transform(1,Y,h);
    b4 = transform(X,Y,h);
    left = min([b1(1) b2(1) b3(1) b4(1)]);
    up = min([b1(2) b2(2) b3(2) b4(2)]);
    f = [left, up];
end

function res=generate_correspondence_matrix(img_a_edge, img_b_edge)
    a = img_a_edge;
    b = img_b_edge;
    res = [0 0 0 (-1)*b(3)*a b(2)*a;(-1)*b(3)*a 0 0 0 (-1)*b(1)*a];
end

function f=res_image(img, h)
    [X, Y] = size(img);
    b1 = transform(1,1,h);
    b2 = transform(X,1,h);
    b3 = transform(1,Y,h);
    b4 = transform(X,Y,h);
    left = min([b1(1) b2(1) b3(1) b4(1)]);
    right = max([b1(1) b2(1) b3(1) b4(1)]);
    new_x = abs(left-right);
    
    up = min([b1(2) b2(2) b3(2) b4(2)]);
    down = max([b1(2) b2(2) b3(2) b4(2)]);
    new_y = abs(up-down);
    
    f = uint8(zeros(new_x,new_y));
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
    v = [round(v(1)/v(3)) round(v(2)/v(3))];
    f = v;
end





lena = imread('imgs/lena.png');
img = lena;
max_distance = 2;

relevant_points = interest_points(img);
filtered = ransac(relevant_points, max_distance);


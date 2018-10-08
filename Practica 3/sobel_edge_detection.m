function f=sobel_edge_detection(img)
    sobel_filter1 = zeros(3);
    sobel_filter1(:,1) = [1; 2; 1];
    sobel_filter1(:,3) = [-1; -2; -1];

    sobel_filter2 = zeros(3);
    sobel_filter2(1,:) = [1 2 1];
    sobel_filter2(3,:) = [-1 -2 -1];

    edge_detection_partial_1 = abs(image_convolution(img, sobel_filter1));
    edge_detection_partial_2 = abs(image_convolution(img, sobel_filter2));
    f = edge_detection_partial_1 + edge_detection_partial_2;
end    
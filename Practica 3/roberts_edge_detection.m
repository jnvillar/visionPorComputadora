function f=roberts_edge_detection(img)
    roberts_filter1 = zeros(2);
    roberts_filter1(1,1) = 1;
    roberts_filter1(2,2) = -1;

    roberts_filter2 = zeros(2);
    roberts_filter2(1,2) = 1;
    roberts_filter2(2,1) = -1;

    edge_detection_partial_1 = abs(image_convolution(img, roberts_filter1));
    edge_detection_partial_2 = abs(image_convolution(img, roberts_filter2));
    f = edge_detection_partial_1 + edge_detection_partial_2;
end    
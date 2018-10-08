function f=prewitt_edge_detection(img)
    prewitt_filter1 = zeros(3);
    prewitt_filter1(:,1) = -1;
    prewitt_filter1(:,3) = 1;
    
    prewitt_filter2 = zeros(3);
    prewitt_filter2(1,:) = -1;
    prewitt_filter2(3,:) = 1;
    
    edge_detection_partial_1 = abs(image_convolution(img, prewitt_filter1));
    edge_detection_partial_2 = abs(image_convolution(img, prewitt_filter2));
    f = edge_detection_partial_1 + edge_detection_partial_2;
end
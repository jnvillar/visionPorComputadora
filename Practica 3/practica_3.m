filepath = fileparts(mfilename('fullpath'));
addpath(strcat(filepath, '/../imgs'));
test_img = imread('imgs/test.png');
lena_img = imread('imgs/lena.png');
show_all = 0;
show1 = 0;
show3 = 0;
show4a = 1;
show4b = 1;
show5 = 0;
show6 = 0;
show7 = 0;

% Ejercicio 1

% a
low_pass_filter_3x3 = (1/9).*ones(3);
low_pass_filter_5x5 = (1/25).*ones(5);

if (show_all || show1)
    low_pass_filter_3x3_img = image_convolution(lena_img, low_pass_filter_3x3);
    low_pass_filter_5x5_img = image_convolution(lena_img, low_pass_filter_5x5);
    figure('Name','Low pass filter (3x3 and 5x5)'), imshow([lena_img, low_pass_filter_3x3_img, low_pass_filter_5x5_img]);
end

%b
duplicate_filter_3x3 = zeros(3);
duplicate_filter_3x3(2,2) = 2;
high_pass_filter_3x3 = duplicate_filter_3x3 - low_pass_filter_3x3;

duplicate_filter_5x5 = zeros(5);
duplicate_filter_5x5(3,3) = 2;
high_pass_filter_5x5 = duplicate_filter_5x5 - low_pass_filter_5x5;

if (show_all || show1)
    high_pass_filter_3x3_img = image_convolution(lena_img, high_pass_filter_3x3);
    high_pass_filter_5x5_img = image_convolution(lena_img, high_pass_filter_5x5);
    figure('Name','High pass filter (3x3 and 5x5)'), imshow([lena_img, high_pass_filter_3x3_img, high_pass_filter_5x5_img]);
end

% Ejercicio 2
% Lo implementamos en el ejercicio anterior para poder aplicar los filtros
% pasa bajos y pasa altos (image_convolution)

% Ejercicio 3

%a
if (show_all || show3)
    img = lena_img;
    params = containers.Map({'sigma', 'size'}, {5, 30});
    res_smoothing = smoothing(img, params);
    figure('Name', 'Image lena smoothing'), imshow([img, res_smoothing]);

    img = test_img;
    params = containers.Map({'sigma', 'size'}, {5, 30});
    res_smoothing = smoothing(img, params);
    figure('Name', 'Image test smoothing'), imshow([img, res_smoothing]);
end

%b
if (show_all || show3)
    img = lena_img;
    params = containers.Map({'sigma', 'size'}, {5, 30});
    res_unsharp = unsharp_masking(img, params);
    figure('Name', 'Image lena unsharp masking'), imshow([img, res_unsharp]);

    img = test_img;
    params = containers.Map({'sigma', 'size'}, {5, 30});
    res_unsharp = unsharp_masking(img, params);
    figure('Name', 'Image test unsharp masking'), imshow([img, res_unsharp]);
end

%Ejercicio 4

%a gaussian noise
if (show_all || show4a)    
    img = lena_img;
    params = containers.Map({'sigma', 'size'}, {5, 30});
    lena_smoothing = smoothing(img, params);
    
    
    lena_gauss_noise_1 = gauss_noise(lena_smoothing,mu, 1);
    lena_gauss_noise_2 = gauss_noise(lena_smoothing,mu, 2);
    lena_gauss_noise_3 = gauss_noise(lena_smoothing,mu, 3);
    figure('Name', "Gauss Noise lena with smoothing Sigma variation"), imshow([lena_smoothing, lena_gauss_noise_1,lena_gauss_noise_2,lena_gauss_noise_3]);

    img = test_img;
    params = containers.Map({'sigma', 'size'}, {5, 30});
    test_smoothing = smoothing(img, params);
   
    test_gauss_noise_1 = gauss_noise(test_smoothing,mu, 1);
    test_gauss_noise_2 = gauss_noise(test_smoothing,mu, 2);
    test_gauss_noise_3 = gauss_noise(test_smoothing,mu, 3);
    figure('Name', "Gauss Noise test with smoothing Sigma variation"), imshow([test_smoothing, test_gauss_noise_1,test_gauss_noise_2,test_gauss_noise_3]);

    img = lena_img;
    params = containers.Map({'sigma', 'size'}, {5, 30});
    lena_unsharp = unsharp_masking(img, params);
   
    lena_gauss_noise_1 = gauss_noise(lena_unsharp,mu, 1);
    lena_gauss_noise_2 = gauss_noise(lena_unsharp,mu, 2);
    lena_gauss_noise_3 = gauss_noise(lena_unsharp,mu, 3);
    figure('Name', "Gauss Noise lena with unsharp Sigma variation"), imshow([lena_unsharp, lena_gauss_noise_1,lena_gauss_noise_2,lena_gauss_noise_3]);

    
    img = test_img;
    params = containers.Map({'sigma', 'size'}, {5, 30});
    test_unsharp = unsharp_masking(img, params);
   
    
    test_gauss_noise_1 = gauss_noise(test_unsharp,mu, 1);
    test_gauss_noise_2 = gauss_noise(test_unsharp,mu, 2);
    test_gauss_noise_3 = gauss_noise(test_unsharp,mu, 3);
    figure('Name', "Gauss Noise test with unsharp Sigma variation"), imshow([test_unsharp, test_gauss_noise_1,test_gauss_noise_2,test_gauss_noise_3]);
end

%b rayleigh noise

if (show_all || show4b)
    mu = 0;
    
    img = lena_img;
    params = containers.Map({'sigma', 'size'}, {5, 30});
    lena_smoothing = smoothing(img, params);
    
    
    lena_gauss_noise_1 = rayleigh_noise(lena_smoothing,mu, 1);
    lena_gauss_noise_2 = rayleigh_noise(lena_smoothing,mu, 2);
    lena_gauss_noise_3 = rayleigh_noise(lena_smoothing,mu, 3);
    figure('Name', "rayleigh Noise lena with smoothing Sigma variation"), imshow([lena_smoothing, lena_gauss_noise_1,lena_gauss_noise_2,lena_gauss_noise_3]);

    img = test_img;
    params = containers.Map({'sigma', 'size'}, {5, 30});
    test_smoothing = smoothing(img, params);
   
    test_gauss_noise_1 = rayleigh_noise(test_smoothing,mu, 1);
    test_gauss_noise_2 = rayleigh_noise(test_smoothing,mu, 2);
    test_gauss_noise_3 = rayleigh_noise(test_smoothing,mu, 3);
    figure('Name', "rayleigh Noise test with smoothing Sigma variation"), imshow([test_smoothing, test_gauss_noise_1,test_gauss_noise_2,test_gauss_noise_3]);

    img = lena_img;
    params = containers.Map({'sigma', 'size'}, {5, 30});
    lena_unsharp = unsharp_masking(img, params);
   
    lena_gauss_noise_1 = rayleigh_noise(lena_unsharp,mu, 1);
    lena_gauss_noise_2 = rayleigh_noise(lena_unsharp,mu, 2);
    lena_gauss_noise_3 = rayleigh_noise(lena_unsharp,mu, 3);
    figure('Name', "rayleigh Noise lena with unsharp Sigma variation"), imshow([lena_unsharp, lena_gauss_noise_1,lena_gauss_noise_2,lena_gauss_noise_3]);

    
    img = test_img;
    params = containers.Map({'sigma', 'size'}, {5, 30});
    test_unsharp = unsharp_masking(img, params);
   
    
    test_gauss_noise_1 = rayleigh_noise(test_unsharp,mu, 1);
    test_gauss_noise_2 = rayleigh_noise(test_unsharp,mu, 2);
    test_gauss_noise_3 = rayleigh_noise(test_unsharp,mu, 3);
    figure('Name', "rayleigh Noise test with unsharp Sigma variation"), imshow([test_unsharp, test_gauss_noise_1,test_gauss_noise_2,test_gauss_noise_3]);

end
% Ejercicio 5
if (show_all || show5)
    img = lena_img;
    res_median_fitler = median_filter(img, 3);
    figure('Name', 'Image median filter'), imshow([img, res_median_fitler]);
end

% Ejercico 6
if (show_all || show6)
    img = lena_img;
    with_noise = gauss_noise(img, -0.7, 0.7, 0, 0.5);
    res = median_filter(with_noise,3);
	figure('Name', 'Image lena with noise median filter'), imshow([img, with_noise, res]);

    img = test_img;
    with_noise = gauss_noise(img, -0.7, 0.7, 0, 0.5);
    res = median_filter(with_noise,3);
    figure('Name', 'Image test with noise median filter'), imshow([img, with_noise, res])
end

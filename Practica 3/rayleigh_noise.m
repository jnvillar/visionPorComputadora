function f=rayleigh_noise(img, white_limit, black_limit, mu, sigma)
    noise_img = generate_noise_image(img,white_limit, black_limit, mu, sigma);
    f = imgProd(img, noise_img);
end

function f=generate_noise_image(img,white_limit,black_limit,  mu, sigma)
    [X,Y] = size(img);    
    for i=1:X
        for j=1:Y
            r = rand();           
            r = mu + sqrt((-1)*sigma*log(1-r));
            if r <= white_limit
                f(i,j) = uint8(-255);
            end
            if r > white_limit && r<= black_limit
                f(i,j) = uint8(1);
            end
            if r>black_limit
                f(i,j) = uint8(255);
            end
        end
    end
end
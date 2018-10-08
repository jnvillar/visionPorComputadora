function f=gauss_noise(img, white_limit, black_limit, mu, sigma)
    %noise_img = generate_noise_image(img,white_limit, black_limit, mu, sigma);
    %f = imadd(img, noise_img);
    f = add_noise(img, white_limit, black_limit, mu, sigma);
end

function f=generate_noise_image(img,white_limit,black_limit,  mu, sigma)
    [X,Y] = size(img);    
    for i=1:X
        for j=1:Y
            r = normrnd(mu,sigma);
            r = mu+(sigma-mu)*r;
            if r <= white_limit
                f(i,j) = uint8(-255);
            end
            if r > white_limit && r<= black_limit
                f(i,j) = uint8(0);
            end
            if r>black_limit
                f(i,j) = uint8(255);
            end
        end
    end
end


function f=add_noise(img,white_limit,black_limit,  mu, sigma)
   [i,j] = size(img);
    for i=1:i
        for j=1:j
            r = normrnd(mu,sigma);
            r = mu+(sigma-mu)*r;
            if r <= white_limit
                f(i,j)=0;
            end
            if r > white_limit && r<= black_limit
                f(i,j)=img(i,j);
            end
            if r>black_limit
                f(i,j)=255;
            end
        end
    end
end
function f=gauss_noise(img, mu, sigma)
    img_d = im2double(img);
    noise_img = generate_noise_image(img_d, mu, sigma);
    f = imadd(im2double(img_d), noise_img);
    f = f.*255;
    %f = add_noise(img, white_limit, black_limit, mu, sigma);
end

function f=generate_noise_image(img,  mu, sigma)
    [X,Y] = size(img);    
    f=mu+(sigma-mu).*randn(X,Y);
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